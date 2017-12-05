using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Sales : System.Web.UI.Page
{
    private const string EMPLOYEE_ERROR = "You are unable to use your employee account to shop online.";
    private const string ADD_EXTRA = @"<!-- Temporary icon. Need a shopping cart icon. -->
                                    <img src='../Content/Images/xIcon.svg' width='16' height='16' />
                                    <asp:Label runat='server' ID='AddedAmount'
                                        Text='{0}' />";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("Staff"))
        {
            MessageUserControl.ShowInfo("Unable to Purchase", EMPLOYEE_ERROR);
        }
    }
    
    protected void CategoriesList_DataBound(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            PartController controller = new PartController();
            PartsList.DataSource = controller.GetParts(User,
                int.Parse((CategoriesList.Items[CategoriesList.SelectedIndex
                    ].FindControl("CategoryIdValue") as HiddenField).Value));
            PartsList.DataBind();
        });
    }

    protected string GetAddContents(int added)
    {
        if (added > 0)
        {
            return string.Format(ADD_EXTRA, added);
        }
        else
        {
            return "Add";
        }
    }
}