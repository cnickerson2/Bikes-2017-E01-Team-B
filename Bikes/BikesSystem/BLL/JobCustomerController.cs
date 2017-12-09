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
    public class JobCustomerController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Customer> Customer_List()
        {
            using (var context = new EBikesContext())
            {
                return context.Customers.ToList();
            }
        }
    }
}
