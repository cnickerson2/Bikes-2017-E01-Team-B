<%@ Page Title="Sales" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Sales.aspx.cs" Inherits="Sales_Sales" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style type="text/css">
        .logo {
            width: 2em;
        }

        .category {
            width: 100%;
            text-decoration: none;
            text-align: left;
            color: #000;
        }

        .category:hover {
            color: #000;
        }

        .categoryDescription {
            padding-left: 1em;
        }

        .numberBox {
            border: solid 1px #9e9e9e;
            text-align: center;
            width: 2em;
            border-radius: 4px;
        }

        .categoryPart {
            float: right;
        }

        .categorySelected {
            background-color: #eaeaea;
            border-radius: 4px;
        }

        .categorySelected:hover {
            background-color: #dedede;
        }

        .categoryDescriptionSelected {
            padding-left: 0px;
        }
    </style>

    <h1>Part Catalog
        <img src="../Content/Images/catalogLogo.svg" class="logo" />
        Available online and in-stores</h1>

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <div class="row">
        <h2 class="col-md-3">Categories</h2>
        <h2 class="col-md-9">Parts</h2>
    </div>
    <div class="row">
        <div class="col-md-2">
            <asp:ListView ID="CategoriesList" runat="server" DataSourceID="CategoriesListODS"
                SelectedIndex="0" OnDataBound="CategoriesList_DataBound">
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="CategoryButton" runat="server"
                        CssClass="btn btn-link category" CommandName="Select">
                        <asp:Label ID="Description" runat="server" Text='<%# Eval("Description") %>'
                            CssClass="categoryDescription" />
                        <asp:Label ID="Parts" runat="server" Text='<%# Eval("Parts") %>'
                            CssClass="categoryPart numberBox" />
                    </asp:LinkButton><br />
                </ItemTemplate>
                <SelectedItemTemplate>
                    <asp:HiddenField ID="CategoryIdValue" runat="server"
                        Value='<%# Eval("CategoryId") %>' />
                    <asp:LinkButton ID="CategoryButton" runat="server"
                        CssClass="btn btn-link category categorySelected" Enabled="false">
                        <asp:Label ID="Description" runat="server" Text='<%# Eval("Description") %>'
                            CssClass="categoryDescription categoryDescriptionSelected" />
                        <asp:Label ID="Parts" runat="server" Text='<%# Eval("Parts") %>'
                            CssClass="categoryPart numberBox" />
                    </asp:LinkButton><br />
                </SelectedItemTemplate>
            </asp:ListView>
            <br /><br />
            <asp:HyperLink ID="CheckoutLink" runat="server"
                NavigateUrl="~/Sales/Checkout.aspx">Checkout</asp:HyperLink>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-9">
            <asp:ListView ID="PartsList" runat="server">
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer"><span runat="server" id="itemPlaceholder" /></div>
                    <div>
                        <asp:DataPager runat="server" ID="DataPager1">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                <asp:NumericPagerField></asp:NumericPagerField>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <span>
                        <asp:HiddenField runat="server" ID="PartIdLabel"
                            Value='<%# Eval("PartId") %>'/>
                        <asp:LoginView ID="LoginView" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Staff">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                            <LoggedInTemplate>
                                <asp:LinkButton ID="AddButton" runat="server"
                                    CssClass="btn btn-primary">
                                    <%# GetAddContents(int.Parse(Eval("Added").ToString())) %>
                                </asp:LinkButton>
                                <asp:TextBox ID="AddAmount" runat="server" Text="1"
                                    CssClass="numberBox"></asp:TextBox>
                            </LoggedInTemplate>
                        </asp:LoginView>
                        <asp:Label Text='<%# Eval("Price", "{0:C}") %>' runat="server" ID="PriceLabel" />
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" />
                        <asp:Label Text='<%# Eval("Quantity", "{0} in stock.") %>' runat="server" ID="QuantityLabel" />
                        <br />
                    </span>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>

    <asp:ObjectDataSource ID="CategoriesListODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCategories"
        TypeName="BikesSystem.BLL.CategoryController"></asp:ObjectDataSource>
</asp:Content>
