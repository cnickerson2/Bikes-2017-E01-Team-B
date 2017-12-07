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
        internal ShoppingCartItem CreateShoppingCartItem(int shoppingCartId, int productId, int quantity,
            EBikesContext context)
        {
            ShoppingCartItem item = new ShoppingCartItem()
            {
                ShoppingCartID = shoppingCartId,
                PartID = productId,
                Quantity = quantity
            };
            context.ShoppingCartItems.Add(item);
            return item;
        }
    }
}
