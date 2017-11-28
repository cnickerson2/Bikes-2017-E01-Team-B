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
    public class ReturnOrderDetailController
    {
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public int ReturnOrderDetail_AddNewReturnOrderDetail(ReturnedOrderDetail newReturnOrderDetail)
        {
            using (var context = new EBikesContext())
            {
                newReturnOrderDetail = context.ReturnedOrderDetails.Add(newReturnOrderDetail);
                return context.SaveChanges();
            }
        }

     
    }
}
