using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Checkout : System.Web.UI.Page
{
    private const string EMPLOYEE_ERROR = "You are unable to use your employee account to shop online.";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("Employee")) Response.Redirect("../Account/Login.aspx?message=" +
            HttpUtility.UrlEncode(EMPLOYEE_ERROR));
    }
}