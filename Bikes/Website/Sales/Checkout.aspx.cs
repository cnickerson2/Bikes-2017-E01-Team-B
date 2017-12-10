using BikesData.DTOs;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_Checkout : System.Web.UI.Page
{
    private const string EMPLOYEE_ERROR = "You are unable to use your employee account to shop online.";
    private const string CHECKOUT_AUTH_ERROR = "Please login before checking out.";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated)
        {
            Response.Redirect("../Account/Login.aspx?message=" +
                HttpUtility.UrlEncode(CHECKOUT_AUTH_ERROR));
        }
        else if (User.IsInRole("Staff"))
        {
            Response.Redirect("../Account/Login.aspx?message=" +
                HttpUtility.UrlEncode(EMPLOYEE_ERROR));
        }
    }

    protected void View_PreRender(object sender, EventArgs e)
    {
        if (sender == ViewPartsList || sender == ReviewPartsList || !IsPostBack)
        {
            MessageUserControl.TryRun(() =>
            {
                ShoppingCartController controller = new ShoppingCartController();
                OnlineShoppingCart cart = controller.GetOnlineShoppingCart(User);
                if (cart == null)
                {
                    ViewEmpty.Visible = true;
                    ReviewEmpty.Visible = true;
                }
                else
                {
                    ViewPartsList.DataSource = cart.Parts;
                    ReviewPartsList.DataSource = cart.Parts;
                    ViewPartsList.DataBind();
                    ReviewPartsList.DataBind();
                    ViewTotalLabel.Text = cart.Total.ToString("C");
                    ViewOverviewLabel.Text = string.Format(
                        "There are {0} items in your shopping cart{1}.",
                        cart.Parts.Count,
                        FormatUpdate(cart.LastUpdated));
                    View.Visible = true;
                    Review.Visible = true;
                }
            });
        }
    }

    protected string FormatUpdate(DateTime? Date)
    {
        if (Date.HasValue)
        {
            return string.Format(" (last updated on {0})", Date.Value.Date.ToString());
        }
        else
        {
            return "";
        }
    }

    protected void PartsList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            ListView view;
            int itemId;
            int quantity;

            view = (ListView)sender;
            itemId = int.Parse(e.CommandArgument.ToString());
            if (e.CommandName == "Refresh")
            {
                quantity = GetQuantity(view, itemId);

                if (quantity < 1)
                {
                    throw new Exception("The item quantity must be a positive whole number (please do not include + or - symbols).");
                }
            }
            else
            {
                quantity = 0;
            }
            
            new ShoppingCartItemController().ChangeShoppingCartItemQuantity(User, itemId, quantity);
            View_PreRender(sender, e);
        }, "Changed item amount", "The item has been updated successfully.");
    }

    private int GetQuantity(ListView view, int itemId)
    {
        string itemIdStr = itemId.ToString();
        foreach (ListViewDataItem item in view.Items)
        {
            if ((item.FindControl("ItemIdValue") as HiddenField).Value == itemIdStr)
            {
                int quantity;
                if (int.TryParse((item.FindControl("QuantityBox") as TextBox).Text, out quantity))
                {
                    return quantity;
                }
                else
                {
                    throw new Exception("The amount is not a valid whole number.");
                }
            }
        }
        throw new Exception("Unable to locate the item.");
    }
}