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
    public class CouponController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Coupon> Coupon_List()
        {
            using (var context = new EBikesContext())
            {
                return context.Coupons.ToList();
            }
        }
    }
}
