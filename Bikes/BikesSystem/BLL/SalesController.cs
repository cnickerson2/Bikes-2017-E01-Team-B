using BikesData.Entities;
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
    public class SalesController
    {
        public void AddToCart(IPrincipal user, int productId, int quantity)
        {
            if (!user.Identity.IsAuthenticated)
            {
                throw new Exception("You must login to add an item to your shopping cart.");
            }
            else if (user.IsInRole("Staff"))
            {
                throw new Exception("You are unable to use your employee account to shop online.");
            }

            using (EBikesContext context = new EBikesContext())
            {
                OnlineCustomerController customers = new OnlineCustomerController();
                ShoppingCartController carts = new ShoppingCartController();
                OnlineCustomer customer;
                ShoppingCart cart;

                customer = customers.GetOnlineCustomer(user, context);
                if (customer == null)
                    customer = customers.CreateOnlineCustomer(user.Identity.Name, context);
                cart = carts.GetShoppingCart(user, context);
                if (cart == null)
                    cart = carts.CreateShoppingCart(customer.OnlineCustomerID, context);
                new ShoppingCartItemController().CreateShoppingCartItem(cart.ShoppingCartID,
                    productId, quantity, context);
                context.SaveChanges();
            }
        }
    }
}
