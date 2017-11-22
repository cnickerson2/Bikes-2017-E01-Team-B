
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace BikesData.Entities
{
    public partial class ReturnedOrderDetail
    {
        public int ReturnedOrderDetailID { get; set; }

        public int ReceiveOrderID { get; set; }

        public int? PurchaseOrderDetailID { get; set; }

        [StringLength(50, ErrorMessage = "The return order's item description can not be longer than 50 characters.")]
        public string ItemDescription { get; set; }

        public int Quantity { get; set; }

        [Required(ErrorMessage = "The return order's reason can not be longer than 50 characters.")]
        [StringLength(50)]
        public string Reason { get; set; }

        [StringLength(50, ErrorMessage = "The return order's vendor part number can not be longer than 50 characters.")]
        public string VendorPartNumber { get; set; }

        public virtual PurchaseOrderDetail PurchaseOrderDetail { get; set; }

        public virtual ReceiveOrder ReceiveOrder { get; set; }
    }
}
