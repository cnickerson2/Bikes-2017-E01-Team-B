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
    public class StandardJobController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public StandardJob StandardJobInformation_Get(int standardjobid)
        {
            using (var context = new EBikesContext())
            {
                return context.StandardJobs.Find(standardjobid);
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<StandardJob> StandardJob_List()
        {
            using (var context = new EBikesContext())
            {
                return context.StandardJobs.ToList();
            }
        }
    }
}
