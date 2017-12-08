using BikesData.POCOs;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Sales : System.Web.UI.Page
{
    private const string EMPLOYEE_ERROR = "You are unable to use your employee account to shop online.";
    protected const string ADD_EXTRA = @"<!-- Temporary icon. Need a shopping cart icon. -->
                                         <img src='../Content/Images/xIcon.svg' width='16' height='16' />
                                         <asp:Label runat='server' ID='AddedAmount'
                                             Text='{0}' />";

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void MessageUserControl_PreRender(object sender, EventArgs e)
    {
        if (User.IsInRole("Staff"))
        {
            MessageUserControl.ShowInfo("Unable to Purchase", EMPLOYEE_ERROR);
        }
    }

    protected void CategoriesList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        CategoryIdValue.Value = e.CommandArgument.ToString();
    }

    protected void PartsList_PreRender(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            PartController controller = new PartController();
            PartsList.DataSource = controller.GetParts(User,
                int.Parse(CategoryIdValue.Value));
            PartsList.DataBind();
        });
    }

    protected void PartsList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            MessageUserControl.TryRun(() =>
            {
                int partId = (int)e.CommandArgument;
                new SalesController().AddToCart(User, partId, GetQuantity(partId));
                PartsList_PreRender(sender, e);
            }, "Added to shopping cart", "The part has been added to your shopping cart.");
        }
    }

    private int GetQuantity(int partId)
    {
        string partIdStr = partId.ToString();
        foreach (ListViewDataItem item in PartsList.Items)
        {
            if ((item.FindControl("PartIdLabel") as HiddenField).Value == partIdStr)
            {
                int quantity;
                if (int.TryParse((item.FindControl("AddAmount") as TextBox).Text, out quantity))
                {
                    return quantity;
                }
                else
                {
                    throw new Exception("The amount is not a valid whole number.");
                }
            }
        }
        throw new Exception("Unable to locate the part.");
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }
}