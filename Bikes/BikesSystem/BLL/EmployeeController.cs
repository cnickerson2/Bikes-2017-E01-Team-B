using BikesData.Entities;
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
    public class EmployeeController
    {
        public Employee Employee_Get(int employeeID)
        {
            using (var context = new EBikesContext())
            {
                return context.Employees.Find(employeeID);
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Employee> Employee_List()
        {
            using (var context = new EBikesContext())
            {
                return context.Employees.ToList();
            }
        }
    }
}
