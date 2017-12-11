using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class CurrentServicePart
    {
        public int JobDetailPartID { get; set; }

        public int JobDetailID { get; set; }

        public int PartID { get; set; }

        public short Quantity { get; set; }

        public decimal SellingPrice { get; set; }

        public string Description { get; set; }
    }
}
