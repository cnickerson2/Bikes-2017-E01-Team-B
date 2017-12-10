using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Jobing_Jobs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void NewJobButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewJob.aspx");
    }



    protected void ManageServices_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("JobDetails.aspx?id=" + e.CommandArgument);
    }

    protected void ManageDetails_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("JobServiceDetails.aspx?id=" + e.CommandArgument);
    }
}