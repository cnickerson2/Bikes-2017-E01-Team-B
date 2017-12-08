using BikesData.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.DTOs
{
    public class OnlineShoppingCart
    {
        public decimal Total { get; set; }
        public DateTime LastUpdated { get; set; }
        public List<OnlineShoppingCartItem> Parts { get; set; }
    }
}
