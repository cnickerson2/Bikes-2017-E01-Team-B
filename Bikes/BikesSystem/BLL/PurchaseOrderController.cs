using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel;
using BikesSystem.DAL;
using BikesData.Entities;
using BikesData.POCOs;
#endregion

namespace BikesSystem.BLL
{
    [DataObject]
    public class PurchaseOrderController
    {
        
        /// <summary>
        /// Get a list of Outstanding Orders
        /// </summary>
        /// <returns>Returns a list of orders that are NOT closed, have an order date and a Purchase Order Number</returns>
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<OutstandingPurchaseOrders> PurchaseOrders_ListOutstandingOrders()
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.PurchaseOrders
                              where !x.Closed && !x.PurchaseOrderNumber.Equals(null) && !x.OrderDate.Equals(null)
                              select new OutstandingPurchaseOrders
                              {
                                  OrderDate = (DateTime)x.OrderDate,
                                  PurchaseOrderID = x.PurchaseOrderID,
                                  PurchaseOrderNumber = (int)x.PurchaseOrderNumber,
                                  VendorContactPhone = x.Vendor.Phone,
                                  VendorName = x.Vendor.VendorName
                              };
                return results.ToList();
            }

        }
        
    }
}
