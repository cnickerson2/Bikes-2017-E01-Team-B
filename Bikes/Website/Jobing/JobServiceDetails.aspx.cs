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
        JobDetailsController sysmgr = new JobDetailsController();
        sysmgr.Service_Update(int.Parse(e.CommandArgument.ToString()), 1);
        CurrentJobServicesListView.DataBind();
    }

    protected void Remove_Command(object sender, CommandEventArgs e)
    {
        JobDetailsController sysmgr = new JobDetailsController();
        sysmgr.Remove_Service(int.Parse(e.CommandArgument.ToString()));
        if (Request.QueryString["select"] != null)
        {
            if (Request.QueryString["select"] == e.CommandArgument.ToString())
            {
                Response.Redirect("JobServiceDetails.aspx?id=" + JobIDHidden.Value);
            }
            else
            {
                Response.Redirect("JobServiceDetails.aspx?id=" + JobIDHidden.Value + "&select=" + Request.QueryString["select"]);
            }
        }
        MessageUserControl.ShowInfo("Service removed.");
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
            JobDetailsController sysmgr = new JobDetailsController();
            sysmgr.Service_Update(int.Parse(Request.QueryString["select"]), 0);
            CurrentJobServicesListView.DataBind();
        }
    }

    protected void AddCommentButton_Click(object sender, EventArgs e)
    {
        if (selectedID == 0)
        {
            MessageUserControl.ShowInfo("Warning", "You must select a Service first.");
        }
        else
        {
            if (CommentTextbox.Text == "")
            {
                MessageUserControl.ShowInfo("Warning", "You must enter a comment first.");
            }
            else
            {
                JobDetailsController sysmgr = new JobDetailsController();
                sysmgr.Comment_Update(int.Parse(Request.QueryString["select"]), CommentTextbox.Text);
                Response.Redirect("JobServiceDetails.aspx?id=" + JobIDHidden.Value + "&select=" + Request.QueryString["select"]);
                MessageUserControl.ShowInfo("Information", "Comment has been added.");
            }
        }
    }
}