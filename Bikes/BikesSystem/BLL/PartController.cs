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
                // TODO: Migrate getting the user's cart to the ShoppingCart controller.
                UserManager users = new UserManager();
                ShoppingCart cart = null;
                ApplicationUser appUser = users.FindByNameAsync(user.Identity.Name).Result;

                if (appUser != null)
                {
                    OnlineCustomer customerUser = context.OnlineCustomers.Where((customer) =>
                        customer.OnlineCustomerID == appUser.OnlineCustomerId).FirstOrDefault();

                    if (customerUser != null)
                        cart = customerUser.ShoppingCarts.FirstOrDefault();
                }
                
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
