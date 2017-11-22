using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel;
using BikesSystem.DAL;
using BikesData.Entities;
using BikesData.DTOs;
#endregion

namespace BikesSystem.BLL
{
    [DataObject]
    public class PurchaseOrderDetailsController
    {
        /// <summary>
        /// Get a single Outstanding Order's Information
        /// </summary>
        /// <param name="purchaseOrderID"></param>
        /// <returns></returns>
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public OutstandingPurchaseOrderDetails PurchaseOrder_GetOutstandingOrder(int purchaseOrderID)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.PurchaseOrderDetails
                              where x.PurchaseOrderID.Equals(purchaseOrderID)
                              select new OutstandingPurchaseOrderDetails
                              {
                                  PurchaseOrderID = x.PurchaseOrderID,
                                  PurchaseOrderNumber = x.PurchaseOrder.PurchaseOrderNumber,
                                  VendorContactPhone = x.PurchaseOrder.Vendor.Phone,
                                  VendorName = x.PurchaseOrder.Vendor.VendorName,
                                  PartID = x.PartID,
                                  PartDescription = x.Part.Description,
                                  QuantityOnOrder = x.Quantity,
                                  QuantityOutstanding = x.Quantity,
                                  ReceiveOrderDetails = x.ReceiveOrderDetails,
                                  ReturnedOrderDetails = x.ReturnedOrderDetails
                              };
                return results.First();
            }
        }
    }
}
