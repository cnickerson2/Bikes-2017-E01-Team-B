using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class OnlineShoppingCartItem
    {
        public int ShoppingCartItemId { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public int QuantityOnHand { get; set; }
        public decimal Price { get; set; }
        public DateTime LastUpdated { get; set; }
    }
}
