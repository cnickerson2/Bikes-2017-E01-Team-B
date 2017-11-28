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
        public List<OutstandingPurchaseOrderDetails> PurchaseOrderDetails_GetOutstandingOrdersByPurchaseOrder(int purchaseOrderID)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.PurchaseOrderDetails
                              where x.PurchaseOrderID.Equals(purchaseOrderID)
                              orderby x.PartID
                              select new OutstandingPurchaseOrderDetails
                              {
                                  PurchaseOrderDetailID = x.PurchaseOrderDetailID,
                                  PurchaseOrderID = x.PurchaseOrderID,
                                  PurchaseOrderNumber = x.PurchaseOrder.PurchaseOrderNumber,
                                  VendorContactPhone = x.PurchaseOrder.Vendor.Phone,
                                  VendorName = x.PurchaseOrder.Vendor.VendorName,
                                  PartID = x.PartID,
                                  PartDescription = x.Part.Description,
                                  QuantityOnOrder = x.Quantity,
                                  //If there is some received already, remove that amount from the Ordered, else just show the ordered
                                  QuantityOutstanding = x.ReceiveOrderDetails.Count.Equals(0) ? x.Quantity : x.Quantity - (from y in x.ReceiveOrderDetails
                                                                                                                           where y.PurchaseOrderDetailID == x.PurchaseOrderDetailID
                                                                                                                           select y.QuantityReceived).Sum(),
                                  ReceivingAmount = 0,
                                  ReturningAmount = 0,
                                  ReturningReason = ""
                              };
                return results.ToList();
            }
        }

     
    }
}
