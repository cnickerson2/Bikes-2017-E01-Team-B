using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class UpdatePurchaseOrderDetailPOCO
    {
        public int DetailID { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }

        public UpdatePurchaseOrderDetailPOCO(int id, int quantity, decimal price)
        {
            DetailID = id;
            Quantity = quantity;
            Price = price;
        }
    }
}
