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
                                    where x.EmployeeID.HasValue
                                    select new RegisteredEmployeePOCO
                                    {
                                        UserName = x.UserName,
                                        EmployeeId = int.Parse(x.EmployeeID.ToString())
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
                        userAccount.EmployeeID = employee.EmployeeId;

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
                                  EmployeeId = x.EmployeeID,
                                  CustomerId = x.CustomerID,
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
                    case "EmployeeID":
                        people = context.Employees.ToDictionary(
                            (employee) => employee.EmployeeID,
                            (employee) => employee.FormalName);
                        break;
                    case "CustomerID":
                        people = context.Customers.ToDictionary(
                            (customer) => customer.CustomerID,
                            (customer) => customer.FormalName);
                        break;
                    case "OnlineCustomerID":
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
            if (string.IsNullOrEmpty(userInfo.EmployeeId.ToString()))
            {
                throw new Exception("Employee ID is missing. Remember, employees must be on file to get an account");
            }
            else
            {
                EmployeeController sysmgr = new EmployeeController();
                Employee existing = sysmgr.Employee_Get(int.Parse(userInfo.EmployeeId.ToString()));
                if(existing == null)
                {
                    throw new Exception("Employee must be on file to get an account.");

                }
                else
                {
                    var userAccount = new ApplicationUser()
                    {
                        EmployeeID = userInfo.EmployeeId,
                        CustomerID = userInfo.CustomerId,
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
            }
        }

        public void AddUserToRole (ApplicationUser userAccount, string roleName)
        {
            this.AddToRole(userAccount.Id, roleName);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void RemoveUser (UserProfile userInfo)
        {
            this.Delete(this.FindById(userInfo.UserId));
        }

        #endregion
    }
}
