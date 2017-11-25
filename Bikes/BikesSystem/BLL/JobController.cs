using BikesData.Entities;
using BikesData.POCOs;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class JobController
    {
        public List<Job> Job_List()
        {
            using (var context = new EBikesContext())
            {
                return context.Jobs.ToList();
            }
        }

        public List<CurrentJob> CurrentJob_List()
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.Jobs
                              where x.JobDateOut == null
                              select new CurrentJob
                              {
                                  JobID = x.JobID,
                                  InDate = x.JobDateIn,
                                  StartDate = x.JobDateStarted,
                                  DoneDate = x.JobDateDone,
                                  CustomerName = x.Customer.LastName + ", " + x.Customer.FirstName,
                                  Phone = x.Customer.ContactPhone
                              };
                return results.ToList();
            }
        }
    }
}
