using BikesData.Entities;
using BikesData.Entities.Security;
using BikesData.POCOs;
using BikesSystem.DAL;
using BikesSystem.DAL.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Security.Principal;

namespace BikesSystem.BLL.Security
{
    [DataObject]
    public class UserManager : UserManager<ApplicationUser>
    {
        #region Constraints
        private const string STR_DEFAULT_PASSWORD = "Pa$$word1";
        private const string STR_USERNAME_FORMAT = "{0}{1}";
        private const string STR_EMAIL_FORMAT = "{0}@eBikes.ca";
        private const string STR_WEBMASTER_USERNAME = "Webmaster";
        #endregion
        public UserManager() : base( new UserStore<ApplicationUser>(new ApplicationDbContext()))
        {
            
        }

        public void AddWebMaster()
        {
            if (!Users.Any(u=> u.UserName.Equals(STR_WEBMASTER_USERNAME)))
            {
                var webmasterAccount = new ApplicationUser()
                {
                    UserName = STR_WEBMASTER_USERNAME,
                    Email = string.Format(STR_EMAIL_FORMAT, STR_WEBMASTER_USERNAME)
                };

                this.Create(webmasterAccount, STR_DEFAULT_PASSWORD);

                this.AddToRole(webmasterAccount.Id, SecurityRoles.WebsiteAdmins);
            }
        }

        public void AddEmployees()
        {
            using (var context = new EBikesContext())
            {
                var currentEmployees = from x in context.Employees
                                       select new EmployeeListPOCO
                                       {
                                           EmployeeId = x.EmployeeID,
                                           FirstName = x.FirstName,
                                           LastName = x.LastName
                                       };
                var userEmployees = from x in Users.ToList()
                                    where x.EmployeeId.HasValue
                                    select new RegisteredEmployeePOCO
                                    {
                                        UserName = x.UserName,
                                        EmployeeId = int.Parse(x.EmployeeId.ToString())
                                    };

                foreach (var employee in currentEmployees)
                {
                    if(!userEmployees.Any(us => us.EmployeeId == employee.EmployeeId))
                    {
                        var newUserName = employee.FirstName.Substring(0, 1) + employee.LastName;

                        var userAccount = new ApplicationUser()
                        {
                            UserName = newUserName,
                            Email = string.Format(STR_EMAIL_FORMAT, newUserName),
                            EmailConfirmed = true
                        };
                        userAccount.EmployeeId = employee.EmployeeId;

                        IdentityResult result = this.Create(userAccount, STR_DEFAULT_PASSWORD);
                        if(!result.Succeeded)
                        {
                            newUserName = VerifyNewUserName(newUserName);
                            userAccount.UserName = newUserName;
                            this.Create(userAccount, STR_DEFAULT_PASSWORD);
                        }

                        this.AddToRole(userAccount.Id, SecurityRoles.Staff);
                    }
                }
            }
        }

        public string VerifyNewUserName(string suggestedUserName)
        {
            var allUserNames = from x in Users.ToList()
                               where x.UserName.StartsWith(suggestedUserName)
                               orderby x.UserName
                               select x.UserName;
            var verifiedUserName = suggestedUserName;

            for (int i=1; allUserNames.Any (x=> x.Equals(verifiedUserName,StringComparison.OrdinalIgnoreCase)); i++)
            {
                verifiedUserName = suggestedUserName + i.ToString();
            }
            return verifiedUserName;
        }
        
        public IdentityResult CreatePublic(ApplicationUser user, string password)
        {
            IdentityResult result;
            try
            {
                using (EBikesContext context = new EBikesContext())
                {
                    OnlineCustomer customer = new OnlineCustomerController()
                        .CreateOnlineCustomer(user.UserName, context);
                    context.SaveChanges();
                    user.OnlineCustomerId = customer.OnlineCustomerID;
                    result = this.Create(user, password);
                }
            }
            catch (Exception exc)
            {
                while (exc.InnerException != null)
                    exc = exc.InnerException;
                result = new IdentityResult(exc.Message);
            }

            return result;
        }

        #region UserRole Administration

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<UserProfile> ListAllUsers()
        {
            var rm = new RoleManager();
            List<UserProfile> results = new List<UserProfile>();
            var tempResults = from x in Users.ToList()
                              select new UserProfile
                              {
                                  UserId = x.Id,
                                  UserName = x.UserName,
                                  Email = x.Email,
                                  EmailConfirmation = x.EmailConfirmed,
                                  EmployeeId = x.EmployeeId,
                                  CustomerId = x.CustomerId,
                                  RoleMemberships = x.Roles.Select(r => rm.FindById(r.RoleId).Name)

                              };
            using (var context = new EBikesContext())
            {
                Employee tempEmployee;

                foreach(var person in tempResults)
                {
                    if(person.EmployeeId.HasValue)
                    {
                        tempEmployee = context.Employees.Find(person.EmployeeId);
                        if(tempEmployee != null)
                        {
                            person.FirstName = tempEmployee.FirstName;
                            person.LastName = tempEmployee.LastName;
                        }
                    }
                    results.Add(person);
                }
            }
            return results.ToList();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Dictionary<string, string> GetMemberTypes()
        {
            Dictionary<string, string> types = new Dictionary<string, string>();
            foreach (PropertyInfo info in typeof(ApplicationUser).GetProperties(
                BindingFlags.DeclaredOnly | BindingFlags.Public | BindingFlags.Instance))
            {
                if (info.Name.EndsWith("id", true, CultureInfo.InvariantCulture))
                {
                    types.Add(info.Name, info.GetCustomAttribute<DisplayAttribute>().Name);
                }
            }
            return types;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Dictionary<int, string> GetPeopleByType(string userType)
        {
            Dictionary<int, string> people = null;
            using (EBikesContext context = new EBikesContext())
            {
                switch (userType)
                {
                    case "EmployeeId":
                        people = context.Employees.ToDictionary(
                            (employee) => employee.EmployeeID,
                            (employee) => employee.FormalName);
                        break;
                    case "CustomerId":
                        people = context.Customers.ToDictionary(
                            (customer) => customer.CustomerID,
                            (customer) => customer.FormalName);
                        break;
                    case "OnlineCustomerId":
                        people = context.OnlineCustomers.ToDictionary(
                            (customer) => customer.OnlineCustomerID,
                            (customer) => customer.UserName);
                        break;
                }
            }
            if (people == null)
            {
                people = new Dictionary<int, string>();
            }
            return people;
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddUser(UserProfile userInfo)
        {
            if (!string.IsNullOrEmpty(userInfo.EmployeeId.ToString()))
            {
                EmployeeController sysmgr = new EmployeeController();
                Employee existing = sysmgr.Employee_Get(int.Parse(userInfo.EmployeeId.ToString()));
                if(existing == null)
                {
                    throw new Exception("Employee must be on file to get an account.");
                }
            }
            var userAccount = new ApplicationUser()
            {
                EmployeeId = userInfo.EmployeeId,
                CustomerId = userInfo.CustomerId,
                OnlineCustomerId = userInfo.OnlineCustomerId,
                UserName = userInfo.UserName,
                Email = userInfo.Email
            };
            IdentityResult result = this.Create(userAccount, string.IsNullOrEmpty(userInfo.RequestedPassword) ? STR_DEFAULT_PASSWORD : userInfo.RequestedPassword);
            if (!result.Succeeded)
            {
                userAccount.UserName = VerifyNewUserName(userInfo.UserName);
                this.Create(userAccount, STR_DEFAULT_PASSWORD);
            }
            foreach (var roleName in userInfo.RoleMemberships)
            {
                AddUserToRole(userAccount, roleName);
            }
        }

        public void AddUserToRole (ApplicationUser userAccount, string roleName)
        {
            this.AddToRole(userAccount.Id, roleName);
        }

        public void RemoveUserFromRole(ApplicationUser userAccount, string roleName)
        {
            this.RemoveFromRole(userAccount.Id, roleName);
        }

        public void AddUserToRole(string userID, string roleName)
        {
            this.AddToRole(userID, roleName);
        }

        public void RemoveUserFromRole(string userID, string roleName)
        {
            this.RemoveFromRole(userID, roleName);
        }

        public void RemoveUser (UserProfile userInfo)
        {
            this.Delete(this.FindById(userInfo.UserId));
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void ForceRemoveUser(UserProfile userInfo)
        {
            // TODO: Remove the user from all roles and delete the user.
        }

        public List<string> GetUserRoles(string userId)
        {
            return this.GetRoles(userId).ToList();
        }

        #endregion
    }
}
