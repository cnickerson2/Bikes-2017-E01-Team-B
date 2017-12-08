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
using BikesData.DTOs;
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

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public int PurchaseOrder_ReceiveOrder(List<OutstandingPurchaseOrderDetails> outstandingDetailsList)
        {
            using (var context = new EBikesContext())
            {
                ReceiveOrder newReceiveOrder = new ReceiveOrder
                {
                    //All the ones coming in will have the same POID
                    PurchaseOrderID = outstandingDetailsList[0].PurchaseOrderID,
                    ReceiveDate = DateTime.UtcNow
                };
                //Stage a new Receive Order
                newReceiveOrder = context.ReceiveOrders.Add(newReceiveOrder);
                

                //To check if we can close off the order
                bool isOrderCompleted = true;

                foreach (OutstandingPurchaseOrderDetails outDetail in outstandingDetailsList)
                {

                    if (outDetail.ReceivingAmount > 0)
                    {
                        //New ReceiveOrderDetail made for each part received
                        ReceiveOrderDetail newReceiveOrderDetail = new ReceiveOrderDetail
                        {
                            ReceiveOrderID = newReceiveOrder.ReceiveOrderID,
                            PurchaseOrderDetailID = outDetail.PurchaseOrderDetailID,
                            QuantityReceived = outDetail.ReceivingAmount
                        };
                        newReceiveOrderDetail = context.ReceiveOrderDetails.Add(newReceiveOrderDetail);

                        //Increase QuantityOnHand of Part
                        Part receivedPart = context.Parts.Find(outDetail.PartID);
                        receivedPart.QuantityOnHand += outDetail.ReceivingAmount;
                        //Reduce QuantityOnOrder of Part
                        receivedPart.QuantityOnOrder -= outDetail.ReceivingAmount;
                        //Update the Part
                        context.Entry(receivedPart).State = System.Data.Entity.EntityState.Modified;
                        
                    }
                    if (outDetail.ReturningAmount > 0)
                    {
                        Part receivedPart = context.Parts.Find(outDetail.PartID);

                        //ReturnOrderDetail made for each returning item

                        ReturnedOrderDetail newReturnOrderDetail = new ReturnedOrderDetail
                        {
                            ReceiveOrderID = newReceiveOrder.ReceiveOrderID,
                            PurchaseOrderDetailID = outDetail.PurchaseOrderDetailID,
                            ItemDescription = outDetail.PartDescription,
                            Quantity = outDetail.ReturningAmount,
                            Reason = outDetail.ReturningReason,
                            VendorPartNumber = outDetail.VendorPartNumber
                        };

                        newReturnOrderDetail = context.ReturnedOrderDetails.Add(newReturnOrderDetail);

                        //Add this to the Cart
                        UnorderedPurchaseItemCart newCartItem = new UnorderedPurchaseItemCart
                        {
                            PurchaseOrderNumber = outDetail.PurchaseOrderNumber == null ? 0 : (int)outDetail.PurchaseOrderNumber,
                            Description = outDetail.PartDescription,
                            VendorPartNumber = string.IsNullOrWhiteSpace(outDetail.VendorPartNumber) ? "N/A" : outDetail.VendorPartNumber,
                            Quantity = outDetail.ReturningAmount
                        };
                        newCartItem = context.UnorderedPurchaseItemCarts.Add(newCartItem);
                        
                    }
                    if (outDetail.QuantityOutstanding - outDetail.ReceivingAmount > 0)
                    {
                        //Order is not complete if there are receiving amounts still
                        isOrderCompleted = false;
                    }
                }

                //Complete the order
                if (isOrderCompleted)
                {
                    PurchaseOrder closingPurchaseOrder = context.PurchaseOrders.Find(outstandingDetailsList[0].PurchaseOrderID);

                    closingPurchaseOrder.Closed = true;

                    context.Entry(closingPurchaseOrder).State = System.Data.Entity.EntityState.Modified;
                    
                }
                return context.SaveChanges();
            }
        }
        
        public int PurchaseOrder_ForceClose(int purchaseOrderID, string closureNotes)
        {
            using (var context = new EBikesContext())
            {
                PurchaseOrder closingPurchaseOrder = context.PurchaseOrders.Find(purchaseOrderID);

                closingPurchaseOrder.Notes = closureNotes;
                closingPurchaseOrder.Closed = true;

                context.Entry(closingPurchaseOrder).State = System.Data.Entity.EntityState.Modified;

                return context.SaveChanges();
            }
        }
    }
}
