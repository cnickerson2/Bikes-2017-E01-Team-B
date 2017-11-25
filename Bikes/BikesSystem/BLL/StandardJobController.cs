using BikesData.Entities;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class StandardJobController
    {
        public StandardJob StandardJobInformation_Get(int standardjobid)
        {
            using (var context = new EBikesContext())
            {
                return context.StandardJobs.Find(standardjobid);
            }
        }
    }
}
