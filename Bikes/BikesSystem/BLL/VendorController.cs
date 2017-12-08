using BikesData.POCOs;
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
    public class VendorController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<VendorIdentification> GetVendorIdentifications()
        {
            using (EBikesContext context = new EBikesContext())
            {
                var results = from x in context.Vendors
                select new VendorIdentification
                {
                    VendorID = x.VendorID,
                    VendorName = x.VendorName
                };

                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public VendorInfoPOCO GetVendorInfo(int vendorID)
        {
            using (var context = new EBikesContext())
            {
                var results = from x in context.Vendors
                                where x.VendorID == vendorID
                                select new VendorInfoPOCO
                                {
                                    VendorName = x.VendorName,
                                    City = x.City,
                                    Phone = x.Phone
                                };

                return results.FirstOrDefault();
            }
        }
    }
}
