
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    [Table("StandardJobs")]
    public partial class StandardJob
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public StandardJob()
        {
            StandardJobParts = new HashSet<StandardJobPart>();
        }

        public int StandardJobID { get; set; }

        [Required(ErrorMessage = "The job must have a description.")]
        [StringLength(100, ErrorMessage = "The job's description can not be longer than 100 characters.")]
        public string Description { get; set; }

        public decimal StandardHours { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StandardJobPart> StandardJobParts { get; set; }
    }
}
