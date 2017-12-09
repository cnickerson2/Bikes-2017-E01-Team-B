<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Sales_Checkout" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <link href="../Content/equal-height-columns.css" rel="stylesheet" />
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

        #info div div {
            margin: 5px;
        }

        .paymentMethodList tbody tr td {
            padding: 0px 5px;
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

                    <asp:Panel ID="ViewEmpty" runat="server" Visible="false">
                        <p>You don't have a shopping cart.
                           Please add some items before checking out.</p>
                    </asp:Panel>
                    <asp:Panel ID="View" runat="server"
                        OnLoad="View_PreRender" Visible="false">
                        <%--<asp:ListView ID="ViewPartsList" runat="server"></asp:ListView>--%>
                        <br /><br />
                        <span>Total: <asp:Label runat="server" ID="ViewTotalLabel" /><br />
                            <asp:Label ID="ViewOverviewLabel" runat="server"></asp:Label><br />
                            <a href="#info" data-toggle="tab"
                                class="btn btn-primary">Continue</a>
                        </span>
                    </asp:Panel>
                </div>
                <div class="tab-pane fade" id="info">
                    <h2>Your Purchase Info
                        <a href="Sales.aspx" class="shoppingLink">
                            <img src="../Content/Images/shoppingCart.svg" /><br />
                            shop
                        </a></h2>
                    <hr class="tabHr" />

                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <span class="glyphicon glyphicon-info-sign"></span> Instructions
                        </div>
                        <div class="panel-body">
                            [Instructions about paying here...]
                         </div>
                    </div>

                    <h3>Billing Details</h3>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label1" runat="server" Text="Name"
                                AssociatedControlID="TextBox1"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox1" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label2" runat="server" Text="Email"
                                AssociatedControlID="TextBox2"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox2" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label3" runat="server" Text="Address"
                                AssociatedControlID="TextBox3"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox3" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label4" runat="server" Text="Phone"
                                AssociatedControlID="TextBox4"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox4" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label5" runat="server" Text="Payment Method"
                                AssociatedControlID="PaymentMethodList"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:RadioButtonList ID="PaymentMethodList" runat="server"
                                RepeatDirection="Horizontal" CssClass="paymentMethodList">
                                <asp:ListItem Text="Credit" Value="C"></asp:ListItem>
                                <asp:ListItem Text="Debit" Value="D"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>

                    <h3>Shipping Details</h3>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label6" runat="server" Text="Name"
                                AssociatedControlID="TextBox1"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox5" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label7" runat="server" Text="Email"
                                AssociatedControlID="TextBox2"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox6" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label8" runat="server" Text="Address"
                                AssociatedControlID="TextBox3"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox7" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row-eq-height">
                        <div class="col-md-2">
                            <asp:Label ID="Label9" runat="server" Text="Phone"
                                AssociatedControlID="TextBox4"></asp:Label>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBox8" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row-eq-height">
                        <div class="col-md-2">
                            
                        </div>
                        <div class="col">
                            <span><a href="#view" data-toggle="tab"
                                    class="btn btn-primary">Back</a>&nbsp;&nbsp;

                            <a href="#order" data-toggle="tab"
                                    class="btn btn-primary">Continue</a></span>
                        </div>
                    </div>
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

