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
                List<OnlineCategory> results = (from category in context.Categories.ToList()
                                   where GetPartsCount(category) > 0
                                   select new OnlineCategory
                                   {
                                       Description = category.Description,
                                       Parts = GetPartsCount(category)
                                   }).ToList();
                results.Insert(0, new OnlineCategory
                {
                    Description = "All",
                    Parts = results.Sum((oCategory) => oCategory.Parts)
                });
                return results;
            }  
        }

        private int GetPartsCount(Category category)
        {
            return category.Parts.Count();
        }
    }
}
