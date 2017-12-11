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

        
        
    }


    protected void OutstandingOrderGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectedOrderODS.DataBind();

        SelectedOrderFormView.Enabled = true;
        SelectedOrderFormView.Visible = true;
        OutstandingDetailsGridView.Enabled = true;
        OutstandingDetailsGridView.Visible = true;
        ReceiveBtn.Visible = true;
        ForceCloseBtn.Visible = true;
        ForceCloseTextBox.Visible = true;
        UnorderedCartListView.Visible = true;
    }

    protected void ReceiveBtn_Command(object sender, CommandEventArgs e)
    {

        string warningMessage = "<ul>";
        bool noErrors = true;
        List<OutstandingPurchaseOrderDetails> outDetails = new List<OutstandingPurchaseOrderDetails>();
        foreach (GridViewRow row in OutstandingDetailsGridView.Rows)
        {
            int purchaseOrderDetailID = 0;
            int purchaseOrderID = 0;
            int partID = 0;
            int quantityOnOrder = 0;
            int quantityOutstanding = 0;
            int receivingAmount = 0;
            int returningAmount = 0;
            string partDescription = (row.FindControl("PartDescription") as Label).Text;
            string returningReason = (row.FindControl("ReturningReason") as TextBox).Text;
            string vendorPartNumber = (row.FindControl("VendorPartNumber") as Label).Text;


            if (!int.TryParse((row.FindControl("PurchaseOrderDetailID") as Label).Text, out purchaseOrderDetailID))
            {
                warningMessage += "<li>" +partDescription + "'s Purchase Order Detail ID must be an integer. </li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("PurchaseOrderID") as Label).Text, out purchaseOrderID))
            {
                warningMessage += "<li>" + partDescription + "'s Purchase Order ID must be an integer. </li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("PartID") as Label).Text, out partID))
            {
                warningMessage += "<li>" + partDescription + "'s Part ID must be an integer.</li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("QuantityOnOrder") as Label).Text, out quantityOnOrder))
            {
                warningMessage += "<li>" + partDescription + "'s Quantity On Order must be an integer.</li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("QuantityOutstanding") as Label).Text, out quantityOutstanding))
            {
                warningMessage += "<li>" + partDescription + "'s Quantity Outstanding must be an integer.</li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("ReceivingAmount") as TextBox).Text, out receivingAmount))
            {
                warningMessage += "<li>" + partDescription + "'s Receiving Amount must be an integer.</li>";
                noErrors = false;
            }
            if (!int.TryParse((row.FindControl("ReturningAmount") as TextBox).Text, out returningAmount))
            {
                warningMessage += "<li>" + partDescription + "'s Returning Amount must be an integer.</li>";
                noErrors = false;
            }
            if (string.IsNullOrWhiteSpace(partDescription))
            {
                warningMessage += "<li>" + "Part Description cannot be blank</li>";
                noErrors = false;
            }
            if (returningAmount > 0 && string.IsNullOrWhiteSpace(returningReason))
            {
                warningMessage += "<li>" + partDescription + "'s returning reason cannot be blank when returning items</li>";
                noErrors = false;
            }
            OutstandingPurchaseOrderDetails outDetail = new OutstandingPurchaseOrderDetails
            {
                PurchaseOrderDetailID = purchaseOrderDetailID,
                PurchaseOrderID = purchaseOrderID,
                PartID = partID,
                PartDescription = partDescription,
                QuantityOnOrder = quantityOnOrder,
                QuantityOutstanding = quantityOutstanding,
                ReceivingAmount = receivingAmount,
                ReturningAmount = returningAmount,
                ReturningReason = returningReason,
                VendorPartNumber = string.IsNullOrWhiteSpace(vendorPartNumber) ? "N/A" : vendorPartNumber,
                PurchaseOrderNumber = string.IsNullOrWhiteSpace((row.FindControl("PurchaseOrderNumber") as Label).Text) ? 0 : int.Parse((row.FindControl("PurchaseOrderNumber") as Label).Text)
            };

            outDetails.Add(outDetail);


        }
        List<UnorderedPurchaseItemCart> cartItems = new List<UnorderedPurchaseItemCart>();
        foreach (ListViewItem item in UnorderedCartListView.Items)
        {
            int quantity = 0;
            if (!int.TryParse((item.FindControl("QuantityLabel") as Label).Text, out quantity))
            {
                warningMessage += "<li>" + (item.FindControl("DescriptionLabel") as Label).Text + "'s quantity is invalid</li>";
                noErrors = false;
            }
            else
            {
                UnorderedPurchaseItemCart cartItem = new UnorderedPurchaseItemCart
                {
                    VendorPartNumber = (item.FindControl("VendorPartNumberLabel") as Label).Text,
                    Description = (item.FindControl("DescriptionLabel") as Label).Text,
                    Quantity = quantity,
                    PurchaseOrderNumber = int.Parse((SelectedOrderFormView.FindControl("PO") as Label).Text),
                    CartID = int.Parse((item.FindControl("CartIDLabel") as Label).Text)
                };
                cartItems.Add(cartItem);
            }

        }
        if (noErrors)
        {
            MessageUserControl.TryRun(() =>
            {
                PurchaseOrderController sysmgr = new PurchaseOrderController();
                sysmgr.PurchaseOrder_ReceiveOrder(outDetails, cartItems);
                DataBind();
            }, "Success", "Your order has been received.");
        }
        else
        {
            MessageUserControl.ShowInfo("Warning:", "No change was made.<br /> " + warningMessage + "</ul>");
        }

        

    }


    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void ForceCloseBtn_Click(object sender, EventArgs e)
    {
        int purchaseOrderID = 0;
        if (!int.TryParse((SelectedOrderFormView.FindControl("PurchaseOrderID_FormView") as Label).Text, out purchaseOrderID))
        {
            MessageUserControl.ShowInfo("Warning:", "Please enter a valid purchase order id");
        }
        else if (string.IsNullOrWhiteSpace(ForceCloseTextBox.Text))
        {
            MessageUserControl.ShowInfo("Warning:", "Please enter a reason for closing the Purchase Order");
        }
        else
        {
            MessageUserControl.TryRun(() =>
            {
                PurchaseOrderController sysmgr = new PurchaseOrderController();
                sysmgr.PurchaseOrder_ForceClose(purchaseOrderID, ForceCloseTextBox.Text);

                DataBind();
            }, "Success", "Successfully closed Purchase Order ID: " + purchaseOrderID);
                
        }    
        
    }
}