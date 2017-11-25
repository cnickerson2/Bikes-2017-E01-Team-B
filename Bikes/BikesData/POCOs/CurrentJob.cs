using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class CurrentJob
    {
        public int JobID { get; set; }
        public DateTime InDate { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? DoneDate { get; set; }
        public string CustomerName { get; set; }
        public string Phone { get; set; }
    }
}
