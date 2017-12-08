<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Sales_Checkout" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


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
            width: 1.5em;
            height: 1.5em;
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
            <asp:ValidationSummary ID="ValidationSummary" runat="server" />

            <div class="tab-content container">
                <div class="tab-pane fade in active" id="view">
                    <h2>Your Shopping Cart
                        <a href="Sales.aspx" class="shoppingLink">
                            <img src="../Content/Images/shoppingCart.svg" /><br />
                            shop
                        </a></h2>
                    <hr class="tabHr" />

                    <asp:ListView ID="View" runat="server"
                        OnPreRender="View_PreRender">
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <%--<asp:ListView ID="PartsList" runat="server" DataSource='<%# Eval("Parts") %>'></asp:ListView>--%>
                            <br /><br />
                            <span>Total: <asp:Label Text='<%# Eval("Total", "{0:C}") %>' runat="server" ID="TotalLabel" /><br />
                                <asp:Label ID="OverviewLabel" runat="server" Text='<%# string.Format(
                                    "There are {0} items in your shopping cart (last updated on {1}).",
                                    ((IList)Eval("Parts")).Count,
                                    ((DateTime)Eval("LastUpdated")).Date) %>'></asp:Label></span>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <span>There are no items in your cart.
                                Add some items to your cart before checking out.</span>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
                <div class="tab-pane fade" id="info">
                    <h2>Your Purchase Info
                        <a href="Sales.aspx" class="shoppingLink">
                            <img src="../Content/Images/shoppingCart.svg" /><br />
                            shop
                        </a></h2>
                    <hr class="tabHr" />


                </div>
                <div class="tab-pane fade" id="order">
                    <h2>Your Shopping Cart
                        <a href="Sales.aspx" class="shoppingLink">
                            <img src="../Content/Images/shoppingCart.svg" /><br />
                            shop
                        </a></h2>
                    <hr class="tabHr" />

                    
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

