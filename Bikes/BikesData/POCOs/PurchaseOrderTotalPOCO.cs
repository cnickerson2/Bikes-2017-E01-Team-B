﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesData.POCOs
{
    public class PurchaseOrderTotalPOCO
    {
        public decimal Subtotal { get; set; }
        public decimal GST { get; set; }
        public decimal Total { get; set; }
    }
}