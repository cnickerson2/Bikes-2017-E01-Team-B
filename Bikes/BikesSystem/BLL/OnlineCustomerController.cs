using BikesData.Entities;
using BikesData.Entities.Security;
using BikesSystem.BLL.Security;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class OnlineCustomerController
    {
        internal OnlineCustomer GetOnlineCustomer(IPrincipal user, EBikesContext context)
        {
            ApplicationUser appUser = new UserManager().FindByNameAsync(user.Identity.Name).Result;
            
            if (appUser != null)
            {
                return context.OnlineCustomers.Where((customer) =>
                    customer.OnlineCustomerID == appUser.OnlineCustomerId).FirstOrDefault();
            }
            else
            {
                return null;
            }
        }

        internal OnlineCustomer CreateOnlineCustomer(string userName, EBikesContext context)
        {
            OnlineCustomer customer = new OnlineCustomer
            {
                UserName = userName,
                TrackingCookie = Guid.NewGuid(),
                CreatedOn = DateTime.Now
            };
            context.OnlineCustomers.Add(customer);
            return customer;
        }
    }
}
