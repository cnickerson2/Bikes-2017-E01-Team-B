
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    [Table("Coupons")]
    public partial class Coupon
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Coupon()
        {
            JobDetails = new HashSet<JobDetail>();
            Sales = new HashSet<Sale>();
        }

        public int CouponID { get; set; }
        
        [Required(ErrorMessage = "The coupon id value is required.")]
        [StringLength(10, ErrorMessage = "The coupon id value can not be longer than 10 characters.")]
        public string CouponIDValue { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public int CouponDiscount { get; set; }

        public int SalesOrService { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<JobDetail> JobDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Sale> Sales { get; set; }
    }
}
