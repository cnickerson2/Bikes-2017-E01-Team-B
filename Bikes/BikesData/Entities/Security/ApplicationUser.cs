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
        public int? EmployeeId { get; set; }
        [Display(Name = "Customer")]
        public int? CustomerId { get; set; }
        [Display(Name = "Online Customer")]
        public int? OnlineCustomerId { get; set; }
        public DateTime? LastLogin { get; set; }
        public int? CouponId { get; set; }
    }
}
