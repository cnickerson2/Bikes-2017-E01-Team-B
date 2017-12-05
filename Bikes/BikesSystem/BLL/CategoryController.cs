using BikesData.Entities;
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
    public class CategoryController
    {
        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public List<OnlineCategory> GetCategories()
        {
            using (EBikesContext context = new EBikesContext())
            {
                IEnumerable<OnlineCategory> results = from category in context.Categories.ToList()
                                   where GetPartsCount(category) > 0
                                   select new OnlineCategory
                                   {
                                       Description = category.Description,
                                       Parts = GetPartsCount(category)
                                   };
                // TODO: Find Prepend reference. Need it to Add the All category.
                //results.Prepend(new OnlineCategory
                //{
                //    Description = "All",
                //    Parts = results.Sum((oCategory) => oCategory.Parts)
                //});
                return results.ToList();
            }  
        }

        private int GetPartsCount(Category category)
        {
            return category.Parts.Count();
        }
    }
}
