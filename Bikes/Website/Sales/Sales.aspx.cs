using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Sales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("Employee"))
        {
            // Warn the user, use the EMPLOYEE_ERROR in Checkout.
        }

        if (!IsPostBack)
        {
            CategoriesList.SelectedIndex = 0;
        }
    }
}