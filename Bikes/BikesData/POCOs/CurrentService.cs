using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class CurrentService
    {
        public int JobDetailID { get; set; }

        public string Description { get; set; }

        public decimal JobHours { get; set; }

        public string Comments { get; set; }

        public int? CouponID { get; set; }

        public int JobID { get; set; }

        public bool? Completed { get; set; }
    }
}
