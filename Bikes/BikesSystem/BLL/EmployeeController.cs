using BikesData.Entities;
using BikesSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikesSystem.BLL
{
    public class EmployeeController
    {
        public Employee Employee_Get(int employeeID)
        {
            using (var context = new EBikesContext())
            {
                return context.Employees.Find(employeeID);
            }
        }
    }
}
