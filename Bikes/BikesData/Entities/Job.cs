
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    [Table("Jobs")]
    public partial class Job
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Job()
        {
            JobDetails = new HashSet<JobDetail>();
            Sales = new HashSet<Sale>();
        }

        public int JobID { get; set; }

        public DateTime JobDateIn { get; set; }

        public DateTime? JobDateStarted { get; set; }

        public DateTime? JobDateDone { get; set; }

        public DateTime? JobDateOut { get; set; }

        public int CustomerID { get; set; }

        public int EmployeeID { get; set; }

        public decimal ShopRate { get; set; }

        [Required(ErrorMessage = "The job must have a status code.")]
        [StringLength(1, ErrorMessage = "The job status code must be a single character.")]
        public string StatusCode { get; set; }

        [Required(ErrorMessage = "The vehicle for the job must be identified.")]
        [StringLength(50, ErrorMessage = "The job's identified vehicle must be described in less than 50 characters.")]
        public string VehicleIdentification { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Employee Employee { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<JobDetail> JobDetails { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Sale> Sales { get; set; }
    }
}
