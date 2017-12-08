using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.Entities.Security
{
    public class RoleProfile
    {
        public string RoleId { get; set; }
        public string RoleName { get; set; }
        public string Members { get; set; }
    }
}
