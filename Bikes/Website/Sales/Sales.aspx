<%@ Page Title="Sales" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Sales.aspx.cs" Inherits="Sales_Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Part Catalog
        <!-- Placeholder image: Need Sales logo. -->
        <img src="../Content/Images/logo.png" />
        Available online and in-stores</h1>

    <div class="row">
        <h2 class="col-md-3">Categories</h2>
        <h2 class="col-md-9">Parts</h2>
    </div>
    <div class="row">
        <div class="col-md-3">
            <asp:ListView ID="CategoriesList" runat="server" DataSourceID="CategoriesListODS">
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <span>Description:
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Parts:
                        <asp:Label Text='<%# Eval("Parts") %>' runat="server" ID="PartsLabel" /><br />
                        <br />
                    </span>
                </ItemTemplate>
                <SelectedItemTemplate>
                    <span><asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel"
                        CssClass="btn btn-default" />
                        <asp:Label Text='<%# Eval("Parts") %>' runat="server" ID="PartsLabel" Enabled="false"
                            CssClass="btn" /><br />
                        <br />
                    </span>
                </SelectedItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
            </asp:ListView>
            <br /><br />
            <asp:HyperLink ID="CheckoutLink" runat="server"
                NavigateUrl="~/Sales/Checkout.aspx">Checkout</asp:HyperLink>
        </div>
        <div class="col-md-9">
            <asp:ListView ID="PartsList" runat="server"></asp:ListView>
        </div>
    </div>

    <asp:ObjectDataSource ID="CategoriesListODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCategories"
        TypeName="BikesSystem.BLL.CategoryController"></asp:ObjectDataSource>
</asp:Content>
