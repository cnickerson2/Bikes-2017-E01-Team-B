<%@ Page Title="Sales" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Sales.aspx.cs" Inherits="Sales_Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style type="text/css">
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

        .categoryParts {
            border: solid 1px #9e9e9e;
            text-align: center;
            width: 2em;
            float: right;
            border-radius: 4px;
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
        <!-- Placeholder image: Need Sales logo. -->
        <img src="../Content/Images/logo.png" />
        Available online and in-stores</h1>

    <div class="row">
        <h2 class="col-md-3">Categories</h2>
        <h2 class="col-md-9">Parts</h2>
    </div>
    <div class="row">
        <div class="col-md-2">
            <asp:ListView ID="CategoriesList" runat="server" DataSourceID="CategoriesListODS">
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="CategoryButton" runat="server"
                        CssClass="btn btn-link category" CommandName="Select">
                        <asp:Label ID="Description" runat="server" Text='<%# Eval("Description") %>'
                            CssClass="categoryDescription" />
                        <asp:Label ID="Parts" runat="server" Text='<%# Eval("Parts") %>'
                            CssClass="categoryParts" />
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
                            CssClass="categoryParts" />
                    </asp:LinkButton><br />
                </SelectedItemTemplate>
            </asp:ListView>
            <br /><br />
            <asp:HyperLink ID="CheckoutLink" runat="server"
                NavigateUrl="~/Sales/Checkout.aspx">Checkout</asp:HyperLink>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-9">
            <asp:ListView ID="PartsList" runat="server"></asp:ListView>
        </div>
    </div>

    <asp:ObjectDataSource ID="CategoriesListODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCategories"
        TypeName="BikesSystem.BLL.CategoryController"></asp:ObjectDataSource>
</asp:Content>
