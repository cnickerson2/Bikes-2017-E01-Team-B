
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Jobs = new HashSet<Job>();
        }

        public int CustomerID { get; set; }

        [Required(ErrorMessage = "The customer must have a last name.")]
        [StringLength(30, ErrorMessage = "The customer's last name can not be any longer than 30 characters.")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "The customer must have a first name.")]
        [StringLength(30, ErrorMessage = "The customer's first name can not be any longer than 30 characters.")]
        public string FirstName { get; set; }

        [StringLength(40, ErrorMessage = "The customer's address can not be any longer than 40 characters.")]
        public string Address { get; set; }

        [StringLength(20, ErrorMessage = "The customer's city name can not be any longer than 20 characters.")]
        public string City { get; set; }
        
        [RegularExpression("[a-zA-Z][a-zA-Z]?",
            ErrorMessage = "The customer's province must be 2 initial characters.")]
        public string Province { get; set; }
        
        [RegularExpression("[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]",
            ErrorMessage = "The customer's postal code must be valid (format: A0A0A0).")]
        public string PostalCode { get; set; }
        
        [RegularExpression("[0-9][0-9][0-9]\\.[0-9][0-9][0-9]\\.[0-9][0-9][0-9][0-9]",
            ErrorMessage = "The customer's phone number must be valid (format: 000.000.0000).")]
        public string ContactPhone { get; set; }

        [StringLength(30, ErrorMessage = "The customer's email address can not be any longer than 30 characters.")]
        public string EmailAddress { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Job> Jobs { get; set; }
    }
}
