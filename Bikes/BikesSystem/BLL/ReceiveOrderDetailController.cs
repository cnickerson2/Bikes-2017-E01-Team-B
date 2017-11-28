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
    public class ReceiveOrderDetailController
    {
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public int ReceiveOrderDetail_ReceiveNewOrderItem(ReceiveOrderDetail newReceiveOrderDetail)
        {
            using (var context = new EBikesContext())
            {
                newReceiveOrderDetail = context.ReceiveOrderDetails.Add(newReceiveOrderDetail);
                return context.SaveChanges();
            }
        }
    }
}
