
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    public partial class Employee
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Employee()
        {
            Jobs = new HashSet<Job>();
            PurchaseOrders = new HashSet<PurchaseOrder>();
            SaleRefunds = new HashSet<SaleRefund>();
            Sales = new HashSet<Sale>();
        }

        public int EmployeeID { get; set; }

        [Required(ErrorMessage = "The employee must have provide a Social Insurance Number.")]
        [RegularExpression("[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]",
            ErrorMessage = "The employee must provide a valid Social Insurance Number (format: 000000000).")]
        public string SocialInsuranceNumber { get; set; }
        
        [Required(ErrorMessage = "The employee must provide their last name.")]
        [StringLength(30, ErrorMessage = "The employee must have a last name less then 30 characters.")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "The employee must provide their first name.")]
        [StringLength(30, ErrorMessage = "The employee must have a first name less then 30 characters.")]
        public string FirstName { get; set; }

        [StringLength(40, ErrorMessage = "The employee's address must be less than 40 characters.")]
        public string Address { get; set; }

        [StringLength(20, ErrorMessage = "The employee's city name must be less than 20 characters.")]
        public string City { get; set; }

        [RegularExpression("[a-zA-Z][a-zA-Z]?",
            ErrorMessage = "The employee's province must be 2 initial characters.")]
        public string Province { get; set; }

        [RegularExpression("[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]",
            ErrorMessage = "The employee's postal code must be valid (format: A0A0A0).")]
        public string PostalCode { get; set; }
        
        [RegularExpression("[0-9][0-9][0-9]\\.[0-9][0-9][0-9]\\.[0-9][0-9][0-9][0-9]",
            ErrorMessage = "The customer's phone number must be valid (format: 000.000.0000).")]
        public string HomePhone { get; set; }

        [StringLength(30, ErrorMessage = "The employee's email address can not be any longer than 30 characters.")]
        public string EmailAddress { get; set; }

        public int PositionID { get; set; }

        public virtual Position Position { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Job> Jobs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PurchaseOrder> PurchaseOrders { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SaleRefund> SaleRefunds { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Sale> Sales { get; set; }
    }
}
