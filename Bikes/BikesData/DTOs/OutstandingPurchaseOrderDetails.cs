using BikesData.Entities;
using BikesData.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.DTOs
{
    public class OutstandingPurchaseOrderDetails
    {
        public int PurchaseOrderDetailID { get; set; }
        public int? PurchaseOrderNumber { get; set; }
        public string VendorName { get; set; }
        public string VendorContactPhone { get; set; }
        public int PurchaseOrderID { get; set; }
        public int PartID { get; set; }
        public string PartDescription { get; set; }
        public int QuantityOnOrder { get; set; }
        public int QuantityOutstanding { get; set; }


    }
}
