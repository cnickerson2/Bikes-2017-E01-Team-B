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
       try
        {
            Message.Text = "";
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


                if (!int.TryParse((row.FindControl("PurchaseOrderDetailID") as Label).Text,out purchaseOrderDetailID))
                {
                    Message.Text += partDescription+"'s Purchase Order Detail ID must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("PurchaseOrderID") as Label).Text, out purchaseOrderID))
                {
                    Message.Text += partDescription + "'s Purchase Order ID must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("PartID") as Label).Text, out partID))
                {
                    Message.Text += partDescription + "'s Part ID must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("QuantityOnOrder") as Label).Text, out quantityOnOrder))
                {
                    Message.Text += partDescription + "'s Quantity On Order must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("QuantityOutstanding") as Label).Text, out quantityOutstanding))
                {
                    Message.Text += partDescription + "'s Quantity Outstanding must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("ReceivingAmount") as TextBox).Text, out receivingAmount))
                {
                    Message.Text += partDescription + "'s Receiving Amount must be an integer. <br />";
                    noErrors = false;
                }
                if (!int.TryParse((row.FindControl("ReturningAmount") as TextBox).Text, out returningAmount))
                {
                    Message.Text += partDescription + "'s Returning Amount must be an integer. <br />";
                    noErrors = false;
                }
                if (string.IsNullOrWhiteSpace(partDescription))
                {
                    Message.Text += "Part Description cannot be blank <br />";
                    noErrors = false;
                }
                if (returningAmount > 0 && string.IsNullOrWhiteSpace(returningReason))
                {
                    Message.Text += partDescription + "'s returning reason cannot be blank when returning items <br />";
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
                    Message.Text = (item.FindControl("DescriptionLabel") as Label).Text + "'s quantity is invalid";
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
               
                PurchaseOrderController sysmgr = new PurchaseOrderController();
                sysmgr.PurchaseOrder_ReceiveOrder(outDetails,cartItems);
            }
            else
            {
                Message.Text += "No change was made.";
            }

            DataBind();
        }
        catch (Exception ex)
        {
            Message.Text = ex.Message;
        }
    }


    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void ForceCloseBtn_Click(object sender, EventArgs e)
    {
        try
        {
            Message.Text = "";
            int purchaseOrderID = 0;
            if (!int.TryParse((SelectedOrderFormView.FindControl("PurchaseOrderID_FormView") as Label).Text, out purchaseOrderID))
            {
                Message.Text = "Please enter a valid purchase order id";
            }
            else if (string.IsNullOrWhiteSpace(ForceCloseTextBox.Text))
            {
                Message.Text = "Please enter a reason for closing the Purchase Order";
            }
            else
            {
                PurchaseOrderController sysmgr = new PurchaseOrderController();
                sysmgr.PurchaseOrder_ForceClose(purchaseOrderID, ForceCloseTextBox.Text);

                DataBind();
            }
        }
        catch(Exception ex)
        {
            Message.Text = ex.InnerException.InnerException.Message;
        }     
        
    }
}