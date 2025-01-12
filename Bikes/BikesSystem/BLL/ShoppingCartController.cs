﻿using BikesData.DTOs;
using BikesData.Entities;
using BikesData.POCOs;
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
    public class ShoppingCartController
    {
        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public OnlineShoppingCart GetOnlineShoppingCart(IPrincipal user)
        {
            using (EBikesContext context = new EBikesContext())
            {
                ShoppingCart cart = GetShoppingCart(user, context);
                OnlineShoppingCart onlineCart = null;
                if (cart != null)
                {
                    onlineCart = new OnlineShoppingCart()
                    {
                        Total = 0,
                        LastUpdated = cart.UpdatedOn,
                        Parts = (from item in cart.ShoppingCartItems
                                 orderby item.Part.Description
                                 select new OnlineShoppingCartItem
                                 {
                                     ShoppingCartItemId = item.ShoppingCartItemID,
                                     Description = item.Part.Description,
                                     Quantity = item.Quantity,
                                     QuantityOnHand = item.Part.QuantityOnHand,
                                     Price = item.Part.SellingPrice,
                                     LastUpdated = DateTime.Now
                                 }).ToList()
                    };
                    onlineCart.Total = onlineCart.Parts.Sum((item) => item.Price*item.Quantity);
                }
                return onlineCart;
            }
        }

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

        internal ShoppingCart CreateShoppingCart(OnlineCustomer customer, EBikesContext context)
        {
            ShoppingCart cart = new ShoppingCart()
            {
                CreatedOn = DateTime.Now
            };
            cart.OnlineCustomer = customer;
            context.ShoppingCarts.Add(cart);
            return cart;
        }
    }
}
