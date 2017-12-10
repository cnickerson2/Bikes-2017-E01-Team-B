using BikesData.Entities;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Jobing_JobServiceDetails : System.Web.UI.Page
{
    public int selectedID;

    protected void Page_Load(object sender, EventArgs e)
    {
        JobIDHidden.Value = Request.QueryString["id"];
        if (Request.QueryString["select"] != null)
        {
            selectedID = int.Parse(Request.QueryString["select"]);


            JobDetailsController sysmgr = new JobDetailsController();
            JobDetail service = sysmgr.ServiceDetails_Get(int.Parse(Request.QueryString["select"].ToString()));

            DescriptionHolder.Text = service.Description;
            HoursHolder.Text = service.JobHours.ToString();
            CommentsHolder.Text = service.Comments;
        }
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        if (JobIDHidden.Value == "")
        {
            MessageUserControl.ShowInfo("Information", "Note: You are not managing any services because you have not selected a job. <a href='Jobs.aspx'>Click Here to go back</a>");
        }
    }

    protected void Select_Command(object sender, CommandEventArgs e)
    {

        Response.Redirect("JobServiceDetails.aspx?id=" + JobIDHidden.Value + "&select=" + e.CommandArgument); 
    }

    protected void Done_Command(object sender, CommandEventArgs e)
    {
        JobController sysmgr = new JobController();
        sysmgr.JobStatus_Update(int.Parse(e.CommandArgument.ToString()), "D");
        CurrentJobServicesListView.DataBind();
    }

    protected void Remove_Command(object sender, CommandEventArgs e)
    {
        JobDetailsController sysmgr = new JobDetailsController();
        sysmgr.Remove_Service(int.Parse(e.CommandArgument.ToString()));
        CurrentJobServicesListView.DataBind();
    }

    protected void StartServiceButton_Click(object sender, EventArgs e)
    {
        
        if (selectedID == 0)
        {
            MessageUserControl.ShowInfo("Warning", "You can't start a service without selecting a service from the list!");
        }
        else
        {
            JobController sysmgr = new JobController();
            sysmgr.JobStatus_Update(int.Parse(JobIDHidden.Value), "S");
            CurrentJobServicesListView.DataBind();
        }
    }
}