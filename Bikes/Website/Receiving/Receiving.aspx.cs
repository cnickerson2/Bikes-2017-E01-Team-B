using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Receiving_Receiving : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ViewOrderTextLink_Click(object sender, CommandEventArgs e)
    {
        Label1.Text = e.CommandArgument.ToString();
    }
    
}