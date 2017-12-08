using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class PartInfoPOCO
    {
        public int PartID { get; set; }
        public string Description { get; set; }
        public int QuantityOnHand { get; set; }
        public int QuantityOnorder { get; set; }
        public int ReorderLevel { get; set; }
        public decimal SellingPrice { get; set; }
        public int Buffer { get; set; }
    }
}
