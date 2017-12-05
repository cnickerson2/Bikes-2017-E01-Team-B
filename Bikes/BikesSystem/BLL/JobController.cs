using BikesData.Entities;
using BikesData.POCOs;
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
    public class JobController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<Job> Job_List()
        {
            using (var context = new EBikesContext())
            {
                return context.Jobs.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CurrentJob> List_CurrentJobs()
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

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public void Job_Add(Job item)
        {
            using (var context = new EBikesContext())
            {
                item = context.Jobs.Add(item);
                context.SaveChanges();
                //I don't think I need a return unless I need to return jobid to forward the user to the services page?
            }
        }
    }
}
