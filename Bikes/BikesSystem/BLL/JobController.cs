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
        public int Job_Add(Job item)
        {
            using (var context = new EBikesContext())
            {
                item = context.Jobs.Add(item);
                context.SaveChanges();
                return item.JobID;
            }
        }

        public void JobStatus_Update(int jobid, string codeChar)
        {
            using (var context = new EBikesContext())
            {
                Job temp = context.Jobs.Find(jobid);
                temp.StatusCode = codeChar;

                if (codeChar == "S")
                {
                    temp.JobDateStarted = DateTime.Now;
                }
                if (codeChar == "D")
                {
                    temp.JobDateDone = DateTime.Now;
                }
                if (codeChar == "O")
                {
                    temp.JobDateOut = DateTime.Now;
                }
                context.Entry(temp).State = System.Data.Entity.EntityState.Modified;
                context.SaveChanges();

            }
        }
    }
}
