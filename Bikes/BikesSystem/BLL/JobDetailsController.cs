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
    public class JobDetailsController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CurrentService> List_CurrentServices(int jobid)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.JobDetails
                              where x.JobID == jobid
                              select new CurrentService
                              {
                                  Description = x.Description,
                                  JobHours = x.JobHours,
                                  Comments = x.Comments,
                                  CouponID = x.CouponID,
                                  JobID = x.JobID,
                                  Completed = x.Completed,
                                  JobDetailID = x.JobDetailID
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void Add_Service(JobDetail service)
        {
            using (var context = new EBikesContext())
            {
                service = context.JobDetails.Add(service);
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public int Remove_Service(int service)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.JobDetails.Find(service);
                context.JobDetails.Remove(existingItem);
                return context.SaveChanges();
            }
        }

        public JobDetail ServiceDetails_Get(int serviceid)
        {
            using (var context = new EBikesContext())
            {
                JobDetail service = context.JobDetails.Find(serviceid);
                return service;
            }
        }

        //note that the int, progress, is meant to be handled by 0 (started) and 1 (done)
        public void Service_Update(int serviceid, int progress)
        {
            using (var context = new EBikesContext())
            {
                JobDetail temp = context.JobDetails.Find(serviceid);

                if (progress == 0)
                {
                    temp.Completed = false;
                }
                if (progress == 1)
                {
                    temp.Completed = true;
                }
                context.Entry(temp).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();

            }
        }
    }
}
