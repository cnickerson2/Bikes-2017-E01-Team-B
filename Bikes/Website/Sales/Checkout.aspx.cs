using BikesData.DTOs;
using BikesData.Entities;
using BikesSystem.BLL;
using BikesSystem.BLL.Security;
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
            OnlineShoppingCart cart = null;
            bool discountSet = false;
            bool totalsSet = false;

            MessageUserControl.TryRun(() =>
            {
                cart = new ShoppingCartController().GetOnlineShoppingCart(User);

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
                    totalsSet = true;
                }
            });
            MessageUserControl.TryRun(() =>
            {
                int? couponId = new UserManager().GetCoupon(User);
                decimal discount;
                if (couponId.HasValue)
                {
                    CouponsList.SelectedValue = couponId.Value.ToString();
                    discount = cart.Total/(new CouponController().GetDiscount(couponId.Value));
                    ReviewDiscountLabel.Text = string.Format(ReviewDiscountLabel.Text,
                        discount.ToString("C"));
                }
                else
                {
                    discount = 0;
                    ReviewDiscountLabel.Text = string.Format(ReviewDiscountLabel.Text,
                        discount.ToString("C"));
                }
                discountSet = true;
                if (totalsSet && cart != null)
                {
                    ReviewSubtotalLabel.Text = string.Format(ReviewSubtotalLabel.Text,
                        cart.Total.ToString("C"));
                    if (discount > 0)
                    {
                        ReviewTotalLabel.Text = string.Format(ReviewTotalLabel.Text,
                            (cart.Total - discount).ToString("C"));
                    }
                    else
                    {
                        ReviewTotalLabel.Text = string.Format(ReviewTotalLabel.Text,
                            cart.Total.ToString("C"));
                    }
                    
                    totalsSet = true;
                }
            });
            if (!discountSet)
            {
                ReviewDiscountLabel.Text = string.Format(ReviewDiscountLabel.Text,
                    "unknown, try refreshing");
            }
            if (!totalsSet)
            {
                ViewTotalLabel.Text = string.Format(ViewTotalLabel.Text,
                    "unknown, try refreshing");
                ReviewSubtotalLabel.Text = string.Format(ReviewSubtotalLabel.Text,
                    "unknown, try refreshing");
                ReviewTotalLabel.Text = string.Format(ReviewTotalLabel.Text,
                    "unknown, try refreshing");
            }
        }
    }

    protected void ApplyCouponButton_Click(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            int? couponId = int.Parse(CouponsList.SelectedValue);
            if (couponId == 0)
                couponId = null;
            new UserManager().SetCoupon(User, couponId);
        }, "Coupon applied", "The coupon has successfully been applied.");
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