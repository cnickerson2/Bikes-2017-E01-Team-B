using BikesData.Entities;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Jobing_JobDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        JobIDHidden.Value = Request.QueryString["id"];
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        if (JobIDHidden.Value == "")
        {
            MessageUserControl.ShowInfo("Information", "Note: If you click Add Service, you will be taken to the New Job page. Alternatively, <a href='Jobs.aspx'>Click Here to go back to the Current Jobs List</a>");
        }
    }

    protected void AddServiceButton_Click(object sender, EventArgs e)
    {
        if (JobIDHidden.Value == "")
        {
            Response.Redirect("NewJob.aspx");
        }
        else
        {
            if (DescriptionTextbox.Text == "")
            {
                MessageUserControl.ShowInfo("Warning", "You must enter a description about the service.");
            }
            else
            {
                if (DescriptionTextbox.Text.Count() > 100)
                {
                    MessageUserControl.ShowInfo("Warning", "Description cannot be longer than 100 characters");
                }
                else
                {
                    if (HoursTextbox.Text == "")
                    {
                        MessageUserControl.ShowInfo("Warning", "You must enter the amount of hours the service took to complete.");
                    }
                    else
                    {
                        decimal hours;
                        if (decimal.TryParse(HoursTextbox.Text, out hours))
                        {
                            JobDetailsController sysmgr = new JobDetailsController();
                            JobDetail newService = new JobDetail();
                            newService.Comments = CommentsTextbox.Text;
                            newService.Description = DescriptionTextbox.Text;
                            newService.JobHours = decimal.Parse(HoursTextbox.Text);
                            newService.JobID = int.Parse(JobIDHidden.Value);

                            if (CouponDropdownList.SelectedValue == "")
                            {
                                //do nothing
                            }
                            else
                            {
                                newService.CouponID = int.Parse(CouponDropdownList.SelectedValue);
                            }

                            sysmgr.Add_Service(newService);
                            CurrentServicesListView.DataBind();
                            MessageUserControl.ShowInfo("Information", "Service successfully added.");
                        }
                        else
                        {
                            MessageUserControl.ShowInfo("Warning", "Hours cannot contain letters or multiple decimal points.");
                        }
                    }
                }
            }
        }
    }

    protected void PresetButton_Click(object sender, EventArgs e)
    {
        if (PresetDropdownList.SelectedValue == "")
        {
            MessageUserControl.ShowInfo("Information", "You must select a preset from the Dropdown List to get information for a preset job.");
        }
        else
        {
            StandardJobController sysmgr = new StandardJobController();
            int standardID = int.Parse(PresetDropdownList.SelectedValue);
            DescriptionTextbox.Text = sysmgr.StandardJobInformation_Get(standardID).Description;
            HoursTextbox.Text = sysmgr.StandardJobInformation_Get(int.Parse(PresetDropdownList.SelectedValue)).StandardHours.ToString();
            MessageUserControl.ShowInfo("Information", "Preset Job Information applied.");
        }
    }

    protected void Remove_Command(object sender, CommandEventArgs e)
    {
        JobDetailsController sysmgr = new JobDetailsController();
        sysmgr.Remove_Service(int.Parse(e.CommandArgument.ToString()));
        CurrentServicesListView.DataBind();
        MessageUserControl.ShowInfo("Information", "Service removed.");
    }
}