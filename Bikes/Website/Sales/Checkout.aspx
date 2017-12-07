<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Sales_Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style type="text/css">
        .steps {
            text-align: center;
        }

        .step  {
            display: inline-block;
            border-right: solid 2px #e4e4e4;
            width: 300px;
        }

        .steps :last-child {
            border-right: none;
        }

        .stepNumber {
            display: inline-block;
            margin: 20px;
            vertical-align: middle;
            font-size: 60px;
            font-weight: 700;
            color: #777;
        }

        .stepSublist {
            display: inline-block;
            vertical-align: middle;
            text-align: left;
            margin: 0px;
            margin-right: 20px;
        }

        .stepSublist :first-child {
            list-style: none;
            text-align: center;
            text-decoration: underline;
            font-size: 1.25em;
            font-weight: 500;
        }

        .continueLink {
            display: block;
            text-align: center;
            text-decoration: underline;
            font-size: 1.15em;
            font-weight: 500;
        }

        .shoppingLink {
            float: right;
            margin: 10px;
            text-align: center;
            font-size: .5em;
        }

        .shoppingLink img {
            display: inline-block;
        }

        .tabHr {
            clear: right;
        }
    </style>

    <div class="steps">
        <div class="step">
            <h1 class="stepNumber">1</h1>
            <ul class="stepSublist">
                <li><a href="#view" data-toggle="tab">View Cart</a></li>
                <li>Add items</li>
                <li>Remove items</li>
            </ul>
        </div>
        <div class="step">
            <h1 class="stepNumber">2</h1>
            <ul class="stepSublist">
                <li><a href="#info" data-toggle="tab">Purchase Info</a></li>
                <li>View your purchase info</li>
                <li>Enter your purchase info</li>
            </ul>
        </div>
        <div class="step">
            <h1 class="stepNumber">3</h1>
            <ul class="stepSublist">
                <li>
                    <a href="#order" data-toggle="tab">Place Order</a></li>
                <li>Place your order</li>
                <li>Apply a coupon</li>
            </ul>
        </div>
    </div>
    <a href="Sales.aspx" class="continueLink">Or continue shopping.</a>
    <div class="tab-content container">
        <div class="tab-pane fade in active" id="view">
            <h2>Your Shopping Cart
                <a href="Sales.aspx" class="shoppingLink">
                    <img src="../Content/Images/catalogLogo.svg" width="16" /><br />
                    shopping
                </a></h2>
            <hr class="tabHr" />
        </div>
        <div class="tab-pane fade" id="info">
            <p>Purchase info</p>
        </div>
        <div class="tab-pane fade" id="order">
            <p>Place order</p>
        </div>
    </div>
</asp:Content>

