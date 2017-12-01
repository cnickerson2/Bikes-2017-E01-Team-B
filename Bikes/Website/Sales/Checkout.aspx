<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Sales_Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row container steps">
        <div class="col-md-4">
            <h1 class="stepNumber">1</h1>
            <ul class="stepSublist">
                <li>
                    <a href="#view" data-toggle="tab">View Cart</a></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <div class="col-md-4">
            <h1 class="stepNumber">2</h1>
            <ul class="stepSublist">
                <li>
                    <a href="#info" data-toggle="tab">Purchase Info</a></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <div class="col-md-4">
            <h1 class="stepNumber">1</h1>
            <ul class="stepSublist">
                <li>
                    <a href="#order" data-toggle="tab">Place Order</a></li>
                <li></li>
                <li></li>
            </ul>
        </div>
    </div>
    <div class="tab-content">
        <div class="tab-pane fade in active" id="view">
            <p>View cart</p>
        </div>
        <div class="tab-pane fade" id="info">
            <p>Purchase info</p>
        </div>
        <div class="tab-pane fade" id="order">
            <p>Place order</p>
        </div>
    </div>
</asp:Content>

