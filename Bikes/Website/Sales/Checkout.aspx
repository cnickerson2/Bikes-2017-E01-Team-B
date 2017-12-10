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

        th, td {
            padding: 5px;
        }

        .input-group-addon {
            background-color: #555;
            color: #ccc;
        }

        .input-group-addon img {
            width: 16px;
            height: 16px;
        }

        a.input-group-addon:hover {
            color: #ccc;
        }

        .summary {
            float: right;
            width: 250px;
            margin: 10px;
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
                        <asp:ListView ID="ViewPartsList" runat="server"
                            OnItemCommand="PartsList_ItemCommand">
                            <LayoutTemplate>
                                <table runat="server" ID="ViewPartsListTable">
                                    <tr runat="server">
                                        <td runat="server">
                                            <table runat="server" id="Table" border="0">
                                                <tr runat="server">
                                                    <th runat="server" style="min-width: 300px">Description</th>
                                                    <th runat="server" style="width: 170px">Count</th>
                                                    <th runat="server">Price</th>
                                                </tr>
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">
                                            <asp:DataPager runat="server" ID="DataPager">
                                                <Fields>
                                                    <asp:NumericPagerField></asp:NumericPagerField>
                                                </Fields>
                                            </asp:DataPager>
                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="ItemIdValue" runat="server"
                                            Value='<%# Eval("ShoppingCartItemId") %>' />
                                        <asp:Label ID="DescriptionLabel" runat="server"
                                            Text='<%# Eval("Description") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <div class="input-group">
                                            <asp:TextBox ID="QuantityBox" runat="server"
                                                CssClass="form-control" Width="4em"
                                                TextMode="Number" MaxLength="3"
                                                text='<%# Eval("Quantity") %>'></asp:TextBox>

                                            <asp:LinkButton ID="RefreshButton" runat="server"
                                                CommandName="Refresh" CommandArgument='<%# Eval("ShoppingCartItemId") %>'
                                                CssClass="input-group-addon">
                                                <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                                                <span class="sr-only">Refresh the amount of the item.</span>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="RemoveButton" runat="server"
                                                CommandName="Remove" CommandArgument='<%# Eval("ShoppingCartItemId") %>'
                                                CssClass="input-group-addon">
                                                <img src="../Content/Images/trashcanIcon.svg"
                                                    alt="Remove the item from your shopping cart." />
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td>
                                        <asp:Label ID="PriceLabel" runat="server"
                                            Text='<%# string.Format("{0:C} ({1:C} each)",
                                                (decimal)Eval("Price")*(int)Eval("Quantity"),
                                                (decimal)Eval("Price")) %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr runat="server" visible='<%# (int)Eval("Quantity") > (int)Eval("QuantityOnHand") %>'>
                                    <td>
                                        <asp:Label ID="OutOfStockLabel" runat="server" Text='<%#
                                            string.Format("Out of stock{0}{1}.",
                                                (int)Eval("Quantity") > (int)Eval("QuantityOnHand") + 1 ?
                                                    string.Format(" by {0} items", (int)Eval("Quantity") - (int)Eval("QuantityOnHand")) : "",
                                                ((DateTime?)Eval("LastUpdated")).HasValue ?
                                                    string.Format(" (updated: {0:d})", ((DateTime?)Eval("LastUpdated")).Value) : "") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                        <br />
                        <div class="summary">Total: <asp:Label runat="server" ID="ViewTotalLabel" /><br />
                            <asp:Label ID="ViewOverviewLabel" runat="server"></asp:Label><br />
                            <a href="#info" data-toggle="tab"
                                class="btn btn-primary">Continue</a>
                        </div>
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

