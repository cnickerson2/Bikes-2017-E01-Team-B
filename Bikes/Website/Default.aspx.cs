using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void TaskList_Load(object sender, EventArgs e)
    {
        foreach(ListItem li in TaskList.Items)
        {
            if(li.Selected)
            {
                li.Attributes["style"] = "color:green";
            }
        }
    }
}