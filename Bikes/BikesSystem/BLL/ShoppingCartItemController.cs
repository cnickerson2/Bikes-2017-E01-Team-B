using BikesData.Entities;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class ShoppingCartItemController
    {
        public void ChangeShoppingCartItemQuantity(IPrincipal user, int shoppingCartItemId, int quantity)
        {
            using (EBikesContext context = new EBikesContext())
            {
                ShoppingCart cart;
                ShoppingCartItem item;

                cart = new ShoppingCartController().GetShoppingCart(user,
                    context);
                if (cart == null)
                    throw new Exception("You do not have a shopping cart to remove an item from (you may have been logged out).");

                item = new ShoppingCartItemController().GetShoppingCartItem(cart, shoppingCartItemId,
                    context);
                if (item == null)
                    throw new Exception("The item is not in yuor shopping cart (did you already remove the item from your cart).");

                if (quantity == 0)
                {
                    context.ShoppingCartItems.Remove(item);
                }
                else
                {
                    item.Quantity = quantity;
                    context.Entry(item).Property("Quantity").IsModified = true;
                }
                context.SaveChanges();
            }
        }

        internal ShoppingCartItem GetShoppingCartPart(ShoppingCart cart, int partId,
            EBikesContext context)
        {
            return context.ShoppingCartItems.Where((item) =>
                item.ShoppingCartID == cart.ShoppingCartID && item.PartID == partId).FirstOrDefault();
        }

        internal ShoppingCartItem GetShoppingCartItem(ShoppingCart cart, int itemId,
            EBikesContext context)
        {
            return context.ShoppingCartItems.Where((item) =>
                item.ShoppingCartID == cart.ShoppingCartID && item.ShoppingCartItemID == itemId).FirstOrDefault();
        }

        internal ShoppingCartItem CreateShoppingCartItem(ShoppingCart cart, int productId,
            EBikesContext context)
        {
            ShoppingCartItem item = new ShoppingCartItem()
            {
                ShoppingCart = cart,
                PartID = productId,
                Quantity = 0
            };
            context.ShoppingCartItems.Add(item);
            return item;
        }
    }
}
