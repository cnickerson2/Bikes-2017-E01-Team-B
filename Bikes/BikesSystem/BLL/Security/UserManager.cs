using BikesData.Entities.Security;
using BikesData.POCOs;
using BikesSystem.DAL;
using BikesSystem.DAL.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL.Security
{
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
    }
}
