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
    protected const string ADD_EXTRA = @"<img src='../Content/Images/shoppingCart.svg' />
                                         <span runat='server' ID='AddedAmount'>{0}</span>";

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
            }, "Added to shopping cart", "The part has been added to your shopping cart.");
        }
    }

    private int GetQuantity(int partId)
    {
        // Temporary, until the LKoginView bug can be resolved.
        return 1;
        //string partIdStr = partId.ToString();
        //foreach (ListViewDataItem item in PartsList.Items)
        //{
        //    if ((item.FindControl("PartIdLabel") as HiddenField).Value == partIdStr)
        //    {
        //        int quantity;
        //        if (int.TryParse((item.FindControl("AddAmount") as TextBox).Text, out quantity))
        //        {
        //            return quantity;
        //        }
        //        else
        //        {
        //            throw new Exception("The amount is not a valid whole number.");
        //        }
        //    }
        //}
        //throw new Exception("Unable to locate the part.");
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void Test3_Click(object sender, EventArgs e)
    {
        PartsList_ItemCommand(sender, new ListViewCommandEventArgs(null, sender,
            new CommandEventArgs("Add", int.Parse(Test2.Text))));
    }
}