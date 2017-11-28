using BikesData.DTOs;
using BikesData.Entities;
using BikesSystem.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Receiving_Receiving : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
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
        //Create a new Receive Order
        ReceiveOrderController receiveordersysmgr = new ReceiveOrderController();
        ReceiveOrder newReceiveOrder = new ReceiveOrder
        {
            PurchaseOrderID = int.Parse((SelectedOrderFormView.FindControl("PurchaseOrderID_FormView") as Label).Text),
            ReceiveDate = DateTime.UtcNow
        };        
        int receiveOrderID = receiveordersysmgr.ReceiveOrder_ReceiveNewOrder(newReceiveOrder);
        bool isOrderCompleted = true;
        foreach (GridViewRow row in OutstandingDetailsGridView.Rows)
        {
            OutstandingPurchaseOrderDetails outDetails = new OutstandingPurchaseOrderDetails();

            outDetails.PurchaseOrderDetailID = int.Parse((row.FindControl("PurchaseOrderDetailID") as Label).Text);
            outDetails.PurchaseOrderID = int.Parse((row.FindControl("PurchaseOrderID") as Label).Text);
            outDetails.PartID = int.Parse((row.FindControl("PartID") as Label).Text);
            outDetails.PartDescription = (row.FindControl("PurchaseOrderDetailID") as Label).Text;
            outDetails.QuantityOnOrder = int.Parse((row.FindControl("QuantityOnOrder") as Label).Text);
            outDetails.QuantityOutstanding = int.Parse((row.FindControl("QuantityOutstanding") as Label).Text);
            outDetails.ReceivingAmount = int.Parse((row.FindControl("ReceivingAmount") as TextBox).Text);
            outDetails.ReturningAmount = int.Parse((row.FindControl("ReturningAmount") as TextBox).Text);
            outDetails.ReturningReason = (row.FindControl("ReturningReason") as TextBox).Text;
            outDetails.VendorPartNumber = (row.FindControl("VendorPartNumber") as Label).Text;
            if(outDetails.ReceivingAmount > 0)
            {
                //New ReceiveOrderDetail made for each part received
                ReceiveOrderDetailController receiveorderdetailsysmgr = new ReceiveOrderDetailController();
                ReceiveOrderDetail newReceiveOrderDetail = new ReceiveOrderDetail();
                newReceiveOrderDetail.ReceiveOrderID = receiveOrderID;
                newReceiveOrderDetail.PurchaseOrderDetailID = outDetails.PurchaseOrderDetailID;
                newReceiveOrderDetail.QuantityReceived = outDetails.ReceivingAmount;
                receiveorderdetailsysmgr.ReceiveOrderDetail_ReceiveNewOrderItem(newReceiveOrderDetail);

                //Increase QuantityOnHand of Part
                PartController partsysmgr = new PartController();
                Part receivedPart = partsysmgr.Part_Get(outDetails.PartID);
                receivedPart.QuantityOnHand += outDetails.ReceivingAmount;
                //Reduce QuantityOnOrder of Part
                receivedPart.QuantityOnOrder -= outDetails.ReceivingAmount;
                //Update the Part
                partsysmgr.Part_Update(receivedPart);
            }
            if(outDetails.ReturningAmount > 0)
            {
                PartController partsysmgr = new PartController();
                Part receivedPart = partsysmgr.Part_Get(outDetails.PartID);

                //ReturnOrderDetail made for each returning item
                ReturnOrderDetailController returnorderdetailsysmgr = new ReturnOrderDetailController();
                ReturnedOrderDetail newReturnOrderDetail = new ReturnedOrderDetail
                {
                    ReceiveOrderID = receiveOrderID,
                    PurchaseOrderDetailID = outDetails.PurchaseOrderDetailID,
                    ItemDescription = outDetails.PartDescription,
                    Quantity = outDetails.ReturningAmount,
                    Reason = outDetails.ReturningReason,
                    VendorPartNumber = outDetails.VendorPartNumber
                };
            }
            if(outDetails.QuantityOutstanding - outDetails.ReceivingAmount > 0)
            {
                isOrderCompleted = false;
            }
        }

        //Check to see if there's anything in the Cart
        //TODO: Add the cart

        //Complete the order
        if(isOrderCompleted)
        {
            PurchaseOrderController purchaseordersysmgr = new PurchaseOrderController();
            purchaseordersysmgr.PurchaseOrder_CloseOrder((int.Parse((SelectedOrderFormView.FindControl("PurchaseOrderID_FormView") as Label).Text)));
        }

        DataBind();
    }

   
}