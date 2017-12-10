using BikesData.Entities;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Jobing_NewJob : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void CreateJobBtn_Click(object sender, EventArgs e)
    {
        if (int.Parse(CustomerDDL.SelectedValue) == 0)
        {
            MessageUserControl.ShowInfo("Warning", "You must choose a Customer.");
        }
        else
        {
            if (int.Parse(EmployeeDDL.SelectedValue) == 0)
            {
                MessageUserControl.ShowInfo("Warning", "You must choose an Employee.");
            }
            else
            {
                if (VehicleIDTextbox.Text == "")
                {
                    MessageUserControl.ShowInfo("Warning", "You must enter Vehicle Identification.");
                }
                else
                {
                    if (ShopRateTextbox.Text == "")
                    {
                        MessageUserControl.ShowInfo("Warning", "You must enter the Shop Rate for the job.");
                    }
                    else
                    {
                        JobController sysmgr = new JobController();
                        Job newJob = new Job();
                        newJob.CustomerID = int.Parse(CustomerDDL.SelectedValue);
                        newJob.EmployeeID = int.Parse(EmployeeDDL.SelectedValue);
                        newJob.JobDateIn = DateTime.Now;
                        newJob.ShopRate = decimal.Parse(ShopRateTextbox.Text);
                        newJob.StatusCode = "I";
                        newJob.VehicleIdentification = VehicleIDTextbox.Text;

                        sysmgr.Job_Add(newJob);

                        Response.Redirect("JobDetails.aspx");
                    }
                }
            }
        }
    }
}