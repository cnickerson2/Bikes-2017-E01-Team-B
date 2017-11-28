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
    public class ReceiveOrderController
    {
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public int ReceiveOrder_ReceiveNewOrder(ReceiveOrder newReceiveOrder)
        {
            using (var context = new EBikesContext())
            {
                newReceiveOrder = context.ReceiveOrders.Add(newReceiveOrder);
                return context.SaveChanges();
            }
        }
    }
}
