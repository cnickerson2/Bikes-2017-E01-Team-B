using BikesData.DTOs;
using BikesData.Entities;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Receiving_Receiving : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!User.IsInRole("WebsiteAdmins") && !User.IsInRole("Receiving")) Response.Redirect("../Account/Login.aspx");

        if (!IsPostBack)
        {
            OutstandingDetailsGridView.Enabled = true;
            OutstandingDetailsGridView.Visible = true;
        }
    }


    protected void OutstandingOrderGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectedOrderODS.DataBind();

        SelectedOrderFormView.Enabled = true;
        SelectedOrderFormView.Visible = true;
        OutstandingDetailsGridView.Enabled = true;
        OutstandingDetailsGridView.Visible = true;
    }

    protected void ReceiveBtn_Command(object sender, CommandEventArgs e)
    {
        
        try
        {
            List<OutstandingPurchaseOrderDetails> outDetails = new List<OutstandingPurchaseOrderDetails>();
            foreach (GridViewRow row in OutstandingDetailsGridView.Rows)
            {
                OutstandingPurchaseOrderDetails outDetail = new OutstandingPurchaseOrderDetails
                {
                    PurchaseOrderDetailID = int.Parse((row.FindControl("PurchaseOrderDetailID") as Label).Text),
                    PurchaseOrderID = int.Parse((row.FindControl("PurchaseOrderID") as Label).Text),
                    PartID = int.Parse((row.FindControl("PartID") as Label).Text),
                    PartDescription = (row.FindControl("PurchaseOrderDetailID") as Label).Text,
                    QuantityOnOrder = int.Parse((row.FindControl("QuantityOnOrder") as Label).Text),
                    QuantityOutstanding = int.Parse((row.FindControl("QuantityOutstanding") as Label).Text),
                    ReceivingAmount = int.Parse((row.FindControl("ReceivingAmount") as TextBox).Text),
                    ReturningAmount = int.Parse((row.FindControl("ReturningAmount") as TextBox).Text),
                    ReturningReason = (row.FindControl("ReturningReason") as TextBox).Text,
                    VendorPartNumber = (row.FindControl("VendorPartNumber") as Label).Text
                };
                outDetails.Add(outDetail);
            }
            PurchaseOrderController sysmgr = new PurchaseOrderController();
            sysmgr.PurchaseOrder_ReceiveOrder(outDetails);

            DataBind();
        }
        catch (Exception ex)
        {
            Message.Text = ex.Message;
        }
    }



    protected void ReturningAmount_TextChanged(object sender, EventArgs e)
    {
        UnorderedCartListView.Visible = true;
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }
}