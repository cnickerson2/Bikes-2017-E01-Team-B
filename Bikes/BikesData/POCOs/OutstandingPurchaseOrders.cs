using BikesData.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class OutstandingPurchaseOrders
    {
        public int PurchaseOrderNumber { get; set; }
        public DateTime OrderDate { get; set; }
        public string VendorName { get; set; }
        public string VendorContactPhone { get; set; }
        public int PurchaseOrderID { get; set; }
    }
}
