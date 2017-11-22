
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    public partial class Vendor
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Vendor()
        {
            Parts = new HashSet<Part>();
            PurchaseOrders = new HashSet<PurchaseOrder>();
        }

        public int VendorID { get; set; }

        [Required(ErrorMessage = "The vendor must have a name.")]
        [StringLength(100, ErrorMessage = "The vendor's name can not be longer than 100 characters.")]
        public string VendorName { get; set; }
        
        [Required(ErrorMessage = "The vendor must have a phone number.")]
        [RegularExpression("[0-9][0-9][0-9]\\.[0-9][0-9][0-9]\\.[0-9][0-9][0-9][0-9]",
            ErrorMessage = "The vendor's phone number must be valid (format: 000.000.0000).")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "The vendor must have an address.")]
        [StringLength(30, ErrorMessage = "The vendor's address can not be longer than 30 characters.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "The vendor must have a city.")]
        [StringLength(30, ErrorMessage = "The vendor's city name can not can not be longer than 30 characters.")]
        public string City { get; set; }

        [Required(ErrorMessage = "The vendor must be in a province.")]
        [RegularExpression("[a-zA-Z][a-zA-Z]?",
            ErrorMessage = "The vendor's province must be 2 initial characters.")]
        public string ProvinceID { get; set; }

        [Required(ErrorMessage = "The vendor must have a postal code.")]
        [RegularExpression("[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]",
            ErrorMessage = "The vendor's postal code must be valid (format: A0A0A0).")]
        public string PostalCode { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Part> Parts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PurchaseOrder> PurchaseOrders { get; set; }
    }
}
