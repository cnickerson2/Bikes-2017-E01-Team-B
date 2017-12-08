using BikesData.Entities;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class ShoppingCartItemController
    {
        internal ShoppingCartItem GetShoppingCartItem(int shoppingCartId, int productId,
            EBikesContext context)
        {
            return context.ShoppingCartItems.Where((item) =>
                item.ShoppingCartID == shoppingCartId && item.PartID == productId).FirstOrDefault();
        }

        internal ShoppingCartItem CreateShoppingCartItem(int shoppingCartId, int productId,
            EBikesContext context)
        {
            ShoppingCartItem item = new ShoppingCartItem()
            {
                ShoppingCartID = shoppingCartId,
                PartID = productId,
                Quantity = 0
            };
            context.ShoppingCartItems.Add(item);
            return item;
        }
    }
}
