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
    public class ShoppingCartController
    {
        internal ShoppingCart GetShoppingCart(OnlineCustomer user, EBikesContext context)
        {
            return user.ShoppingCarts.FirstOrDefault();
        }

        internal ShoppingCart GetShoppingCart(IPrincipal user, EBikesContext context)
        {
            OnlineCustomer customer = new OnlineCustomerController().GetOnlineCustomer(user, context);

            if (customer != null)
            {
                return GetShoppingCart(customer, context);
            }
            else
            {
                return null;
            }
        }

        internal ShoppingCart CreateShoppingCart(int customerId, EBikesContext context)
        {
            ShoppingCart cart = new ShoppingCart()
            {
                OnlineCustomerID = customerId,
                CreatedOn = DateTime.Now
            };
            context.ShoppingCarts.Add(cart);
            return cart;
        }
    }
}
