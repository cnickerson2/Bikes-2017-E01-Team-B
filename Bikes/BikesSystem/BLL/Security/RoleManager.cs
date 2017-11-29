﻿using BikesData.Entities.Security;
using BikesSystem.DAL.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL.Security
{
    [DataObject]
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

        #region UserRole Administration
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<string> ListAllRoleNames()
        {
            return this.Roles.Where(r => r.Name != SecurityRoles.RegisteredUsers).Select(r => r.Name).ToList();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RoleProfile> ListAllRoles()
        {
            var um = new UserManager();
            var results = from role in Roles.ToList()
                          select new RoleProfile
                          {
                              RoleId = role.Id,
                              RoleName = role.Name,
                              UserNames = role.Users.Select(r => um.FindById(r.UserId).UserName)
                          };
            return results.ToList();
        }

        public List<RoleProfile> GetUserRoles(string userId)
        {
            return null;
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void AddRole(RoleProfile role)
        {
            if(!this.RoleExists(role.RoleName))
            {
                this.Create(new IdentityRole(role.RoleName));
            }
            else
            {
                throw new Exception("Creation failed. " + role.RoleName + " already exists.");
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public void RemoveRole(RoleProfile role)
        {
            var existing = this.FindById(role.RoleId);
            if (existing.Users.Count == 0)
            {
                this.Delete(this.FindById(role.RoleId));
            }
            else
            {
                throw new Exception("Deletion failed. " + role.RoleName + " still has existing users. Please reassign them first.");
            }
        }

        public void ForceRemoveRole(RoleProfile role)
        {
            // Removes all users from the role and deletes the role.
        }

        #endregion


    }
}
