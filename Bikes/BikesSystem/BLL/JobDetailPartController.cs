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
    public class JobDetailPartController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobDetailPart> JobDetailParts_Get(int jobdetailid)
        {
            if (jobdetailid == 0)
            {
                //do nothing or it blows up on init
                List<JobDetailPart> fake = new List<JobDetailPart>();
                return fake;
            }
            else
            {
                using (var context = new EBikesContext())
                {
                    var results = from x in context.JobDetailParts
                                  where x.JobDetailID == jobdetailid
                                  select new JobDetailPart
                                  {
                                      JobDetailID = x.JobDetailID,
                                      JobDetailPartID = x.JobDetailPartID,
                                      PartID = x.PartID,
                                      Quantity = x.Quantity,
                                      SellingPrice = x.SellingPrice,
                                      JobDetail = x.JobDetail,
                                      Part = x.Part
                                  };
                    return results.ToList();
                }
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void JobDetailPart_Add(CurrentServicePart item, int jobdetailid)
        {
            using (var context = new EBikesContext())
            {
                JobDetailPart temp = new JobDetailPart();
                temp.JobDetailID = jobdetailid;
                temp.PartID = item.PartID;
                temp.Quantity = item.Quantity;
                temp.SellingPrice = item.SellingPrice;
                context.JobDetailParts.Add(temp);
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public int JobDetailPart_Update(JobDetailPart item)
        {
            using (var context = new EBikesContext())
            {
                context.Entry(item).State = System.Data.Entity.EntityState.Modified;
                return context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public int JobDetailPart_Delete(int jobdetailpartid)
        {
            using (var context = new EBikesContext())
            {
                var existingItem = context.JobDetailParts.Find(jobdetailpartid);
                context.JobDetailParts.Remove(existingItem);
                return context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CurrentServicePart> CurrentParts_List(int jobserviceid)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.JobDetailParts
                              where x.JobDetailID == jobserviceid
                              select new CurrentServicePart
                              {
                                  JobDetailPartID = x.JobDetailPartID,
                                  PartID = x.PartID,
                                  Quantity = x.Quantity,
                                  Description = x.Part.Description
                              };
                return results.ToList();
            }
        }
    }
}
