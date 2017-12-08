using BikesData.Entities.Security;
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
        }
    }

    protected void Delete_Button_Click(object sender, EventArgs e)
    {
        if (VendorDDL.SelectedValue != "0")
        {
            (new PurchaseOrderController()).DeleteCurrentPurchaseOrder(int.Parse(VendorDDL.SelectedValue));
            VendorDDL.SelectedValue = "0";
        } else
        {
            //error message
        }
    }

    protected void Clear_Button_Click(object sender, EventArgs e)
    {
        VendorDDL.SelectedValue = "0";
    }
}