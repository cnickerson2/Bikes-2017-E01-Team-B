namespace BikesSystem.BLL
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UnorderedPurchaseItemCart")]
    public partial class UnorderedPurchaseItemCart
    {
        [Key]
        public int CartID { get; set; }

        public int PurchaseOrderNumber { get; set; }

        [StringLength(100, ErrorMessage = "The description for the item being purchased must be less than 100 characters.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "The vendor part number for the item being purchased must be provided.")]
        [StringLength(50, ErrorMessage = "The vendor part number for the item being purchased can not be longer than 50 characters.")]
        public string VendorPartNumber { get; set; }

        public int Quantity { get; set; }
    }
}
