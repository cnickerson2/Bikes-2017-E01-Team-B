
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    [Table("Categories")]
    public partial class Category
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Category()
        {
            Parts = new HashSet<Part>();
        }

        public int CategoryID { get; set; }

        [Required(ErrorMessage = "The category must have a description.")]
        [StringLength(40, ErrorMessage = "The category's description can not be any longer than 40 characters.")]
        public string Description { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Part> Parts { get; set; }
    }
}
