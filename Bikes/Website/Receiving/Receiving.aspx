<%@ Page Title="Receiving" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Receiving_Receiving" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Receiving</h1>
    <div class="row">
        <div class="col-md-12">
            <div class="tab-content">
                <asp:ListView ID="OustandingOrdersListView" runat="server" DataSourceID="OutstandingOrderODS" DataKeyNames="PurchaseOrderID">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #FFF8DC;">
                            <td align="right" width ="50px">
                                <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("OrderDate","{0:MMM dd, yyyy}") %>' runat="server" ID="OrderDateLabel" Width="125%" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneLabel" /></td>
                            <td>
                                <asp:LinkButton ID="ViewOrderTextLink" runat="server" OnCommand="ViewOrderTextLink_Click"  CommandArgument='<%# Eval("PurchaseOrderID") %>'>View Order</asp:LinkButton></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #DCDCDC; color: #000000;">
                            <td align="right" width ="50px">
                                <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("OrderDate","{0:MMM dd, yyyy}") %>' runat="server" ID="OrderDateLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneLabel" /></td>
                            <td>
                                <asp:LinkButton ID="ViewOrderTextLink" runat="server" OnCommand="ViewOrderTextLink_Click"  CommandArgument='<%# Eval("PurchaseOrderID") %>'>View Order</asp:LinkButton></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                        <tr runat="server" style="background-color: #DCDCDC; color: #000000;">

                                            <th runat="server" width ="50px">Order</th>
                                            <th runat="server">Order Date</th>
                                            <th runat="server">Vendor</th>
                                            <th runat="server">Contact</th>
                                            <th runat="server"></th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;"></td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
            
        </div>
    </div>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController"></asp:ObjectDataSource>
</asp:Content>

