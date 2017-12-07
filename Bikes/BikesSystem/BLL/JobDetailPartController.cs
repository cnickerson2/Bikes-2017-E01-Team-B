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
    public class JobDetailPartController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobDetailPart> JobDetailParts_Get(int jobdetailid)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.JobDetailParts
                              where x.JobDetailID == jobdetailid
                              select new JobDetailPart
                              {
                                  JobDetailID = x.JobDetailID,
                                  JobDetailPartID = x.JobDetailPartID,
                                  Part = x.Part,
                                  PartID = x.PartID,
                                  Quantity = x.Quantity,
                                  SellingPrice = x.SellingPrice
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void JobDetailPart_Add(JobDetailPart item)
        {
            using (var context = new EBikesContext())
            {
                item = context.JobDetailParts.Add(item);
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
    }
}
