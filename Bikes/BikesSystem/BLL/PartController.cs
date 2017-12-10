using BikesData.Entities;
using BikesData.Entities.Security;
using BikesData.POCOs;
using BikesSystem.BLL.Security;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    [DataObject]
    public class PartController
    {

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PartInfoPOCO> GetPartInfoNotOnOrder(int vendorID)
        {
            using (var context = new EBikesContext())
            {
                var results = (from x in context.Parts
                              where x.VendorID == vendorID
                              select new PartInfoPOCO
                              {
                                  PartID = x.PartID,
                                  Description = x.Description,
                                  QuantityOnHand = x.QuantityOnHand,
                                  QuantityOnorder = x.QuantityOnOrder,
                                  ReorderLevel = x.ReorderLevel,
                                  Buffer = (x.QuantityOnHand + x.QuantityOnOrder) - x.ReorderLevel,
                                  SellingPrice = x.SellingPrice
                              }).ToList();

                var ok = (from y in context.PurchaseOrderDetails
                         where y.PurchaseOrder.VendorID == vendorID && y.PurchaseOrder.OrderDate == null && y.PurchaseOrder.PurchaseOrderNumber == null
                         select y.PartID).ToList();

                for (int i = results.Count - 1; i >= 0; i--)
                {
                    for (int j = 0; j < ok.Count; j++)
                    {
                        if (results[i].PartID == ok[j])
                        {
                            results.RemoveAt(i);
                            break;
                        }
                    }
                }

                return results;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public int Part_Update(Part item)
        {
            using (var context = new EBikesContext())
            {
                context.Entry(item).State = System.Data.Entity.EntityState.Modified;
                return context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public Part Part_Get (int partID)
        {
            using (var context = new EBikesContext())
            {
                return context.Parts.Find(partID);
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<OnlinePart> GetParts(IPrincipal user, int categoryId)
        {
            using (var context = new EBikesContext())
            {
                ShoppingCart cart = new ShoppingCartController().GetShoppingCart(user, context);
                
                return (from part in context.Parts.ToList()
                        where categoryId == 0 || part.CategoryID == categoryId
                        select new OnlinePart
                        {
                            PartId = part.PartID,
                            Added = cart != null ? (cart.ShoppingCartItems.Where((item) =>
                                item.PartID == part.PartID).Select((item) =>
                                    item.Quantity).FirstOrDefault()) : 0,
                            Price = part.SellingPrice,
                            Description = part.Description,
                            Quantity = part.QuantityOnHand
                        }).ToList();
            }
        }
    }
}
