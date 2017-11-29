using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.Entities.Security
{
    public class ApplicationUser : IdentityUser
    {
        [Display(Name = "Employee")]
        public int? EmployeeID { get; set; }
        [Display(Name = "Customer")]
        public int? CustomerID { get; set; }
        [Display(Name = "Online Customer")]
        public int? OnlineCustomerID { get; set; }
    }
}
