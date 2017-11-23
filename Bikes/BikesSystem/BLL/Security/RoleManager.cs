using BikesData.Entities.Security;
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
    public class RoleManager : RoleManager<IdentityRole>
    {
        public RoleManager() : base(new RoleStore<IdentityRole>(new ApplicationDbContext()))
        {

        }

        public void AddDefaultRoles()
        {
            foreach (string role in SecurityRoles.DefaultSecurityRoles)
            {
                if (!Roles.Any(r => r.Name == role))
                {
                    this.Create(new IdentityRole(role));
                }
            }
        }

    }
}
