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
    public class JobDetailsController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobDetail> List_CurrentServices(int jobid)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.JobDetails
                              where x.JobID == jobid
                              select new JobDetail
                              {
                                  Description = x.Description,
                                  JobHours = x.JobHours,
                                  Coupon = x.Coupon,
                                  Comments = x.Comments,
                                  JobDetailID = x.JobDetailID,
                                  CouponID = x.CouponID,
                                  Completed = x.Completed,
                                  JobID = x.JobID
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
        public int Remove_Service(JobDetail service)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.JobDetails.Find(service);
                context.JobDetails.Remove(existingItem);
                return context.SaveChanges();
            }
        }

        public void StartService(JobDetail service)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.JobDetails.Find(service);
                existingItem.Completed = false;
                context.SaveChanges();
            }
        }
    }
}
