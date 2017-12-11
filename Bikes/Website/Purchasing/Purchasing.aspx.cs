using BikesData.Entities.Security;
using BikesData.POCOs;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Purchasing_Purchasing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("WebsiteAdmins") && !User.IsInRole("Purchasing"))
        {
            Response.Redirect("../Account/Login.aspx");
        } else
        {
            LoggedInUserDisplay.Text = "CURRENTLY LOGGED IN USER: " + User.Identity.Name;
        }

        if (VendorDDL.SelectedValue != "0")
        {
            IsVisible(true);
        } else
        {
            IsVisible(false);
        }
    }

    protected void GetCreatePOButton_Click(object sender, EventArgs e)
    {
        if (VendorDDL.SelectedValue != "0")
        {
            var id = (new PurchaseOrderController()).GetCurrentPurchaseOrderID(int.Parse(VendorDDL.SelectedValue));

            if (id == 0)
            {
                (new PurchaseOrderController()).CreateNewPurchaseOrder(int.Parse(VendorDDL.SelectedValue), 1);
            }
        } else
        {
            MessageUserControl.TryRun(() =>
            {
                throw new Exception("YOU MUST SELECT A VENDOR");
            });
        }
    }

    protected void Delete_Button_Click(object sender, EventArgs e)
    {
        if (VendorDDL.SelectedValue != "0")
        {
            (new PurchaseOrderController()).DeleteCurrentPurchaseOrder(int.Parse(VendorDDL.SelectedValue));
            VendorDDL.SelectedValue = "0";
            IsVisible(false);
            MessageUserControl.ShowInfo("SUCCESS", "YOU DELETED THAT PESKY PURCHASE ORDER");
        }
    }

    protected void Clear_Button_Click(object sender, EventArgs e)
    {
        VendorDDL.SelectedValue = "0";

        IsVisible(false);
    }

    protected void PurchaseOrderView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string commandName = e.CommandName;
        int partID = int.Parse((string)e.CommandArgument);

        if (commandName == "Remove")
        {
            (new PurchaseOrderDetailsController()).RemoveDetail(int.Parse(VendorDDL.SelectedValue), partID);
        }

        Refresh();
    }

    protected void Place_Button_Click(object sender, EventArgs e)
    {
        if (VendorDDL.SelectedValue != "0")
        {
            new PurchaseOrderController().PlaceOrder(int.Parse(VendorDDL.SelectedValue));

            VendorDDL.SelectedValue = "0";
        }

        IsVisible(false);

        MessageUserControl.ShowInfo("SUCCESS", "WOW YOU PLACED THE ORDER GOOD JOB");
    }

    protected void Update_Button_Click(object sender, EventArgs e)
    {
        List<UpdatePurchaseOrderDetailPOCO> list = new List<UpdatePurchaseOrderDetailPOCO>();

        foreach (ListViewDataItem item in PurchaseOrderView.Items)
        {
            var detailID = int.Parse(((HiddenField)item.FindControl("PurchaseOrderDetailIDHidden")).Value);
            var quantity = int.Parse(((TextBox)item.FindControl("QuantityBox")).Text);
            var price = decimal.Parse(((TextBox)item.FindControl("PurchasePriceBox")).Text);

            list.Add(new UpdatePurchaseOrderDetailPOCO(detailID, quantity, price));
        }

        new PurchaseOrderController().UpdatePurchaseOrderDetails(list);
        new PurchaseOrderController().UpdateTotals(int.Parse(VendorDDL.SelectedValue));

        Refresh();
    }

    public void Refresh()
    {
        PurchaseOrderView.DataBind();
        PurchaseOrderTotalsView.DataBind();
        CurrentInventoryView.DataBind();
    }

    protected void CurrentInventoryView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        string commandName = e.CommandName;
        int partID = int.Parse((string)e.CommandArgument);

        if (commandName == "Add")
        {
            (new PurchaseOrderDetailsController()).AddDetail(int.Parse(VendorDDL.SelectedValue), partID);
        }

        Refresh();
    }

    protected void IsVisible(bool visibility)
    {
        PurchaseOrderView.Visible = visibility;
        CurrentInventoryView.Visible = visibility;

        Place_Button.Visible = visibility;
        Delete_Button.Visible = visibility;
        Clear_Button.Visible = visibility;
        Update_Button.Visible = visibility;

        PurchaseOrderTotalsView.Visible = visibility;
        VendorInfoView.Visible = visibility;

        title2.Visible = visibility;
        title1.Visible = visibility;
    }
}