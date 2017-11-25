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
    public class JobDetailsController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobDetail> JobDetails_Get(int jobid)
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
        public void JobDetail_Add(JobDetail item)
        {
            using (var context = new EBikesContext())
            {
                item = context.JobDetails.Add(item);
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public int JobDetail_Delete(int jobdetailid)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.JobDetails.Find(jobdetailid);
                context.JobDetails.Remove(existingItem);
                return context.SaveChanges();
            }
        }
    }
}
