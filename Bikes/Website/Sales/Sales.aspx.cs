using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Sales : System.Web.UI.Page
{
    private const string EMPLOYEE_ERROR = "You are unable to use your employee account to shop online.";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("Staff"))
        {
            MessageUserControl.ShowInfo("Unable to Purchase", EMPLOYEE_ERROR);
        }

        if (!IsPostBack)
        {
            CategoriesList.SelectedIndex = 0;
        }
    }
}