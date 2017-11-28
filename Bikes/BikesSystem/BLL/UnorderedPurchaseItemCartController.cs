using BikesData.Entities;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    [DataObject]
    public class UnorderedPurchaseItemCartController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<UnorderedPurchaseItemCart> UnorderedCartItems_List()
        {
            using (var context = new EBikesContext())
            {
                return context.UnorderedPurchaseItemCarts.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert,false)]
        public int UnorderedCartItems_Add(UnorderedPurchaseItemCart newItem)
        {
            using (var context = new EBikesContext())
            {
                newItem = context.UnorderedPurchaseItemCarts.Add(newItem);
                return context.SaveChanges();
            }
        }
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public int UnorderedCartItems_Delete(int CartID)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.UnorderedPurchaseItemCarts.Find(CartID);
                context.UnorderedPurchaseItemCarts.Remove(existingItem);
                return context.SaveChanges();
            }

        }
        
        public int UnorderedCartItems_Delete(UnorderedPurchaseItemCart item)
        {
            return UnorderedCartItems_Delete(item.CartID);
        }

        public void UnorderedCartItems_EmptyCart()
        {
            List<UnorderedPurchaseItemCart> theCart = UnorderedCartItems_List();
            foreach(UnorderedPurchaseItemCart item in theCart)
            {
                UnorderedCartItems_Delete(item);
            }
        }
    }
}
