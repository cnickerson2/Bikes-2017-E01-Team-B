﻿<%@ Page Title="Receiving" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Receiving_Receiving" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Receiving</h1>
    <asp:ListView ID="OustandingOrdersListView" runat="server" DataSourceID="OutstandingOrderODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFF8DC;">
                <td></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate","{0:MMM dd, yyyy}") %>' runat="server" ID="OrderDateLabel" Width="125%" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneLabel" /></td>
                <td>
                    <asp:LinkButton ID="ViewOrderTextLink" runat="server" OnClick="ViewOrderTextLink_Click">View Order</asp:LinkButton></td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color: #008A8C; color: #FFFFFF;">
                <td>
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("OrderDate") %>' runat="server" ID="OrderDateTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("VendorName") %>' runat="server" ID="VendorNameTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneTextBox" /></td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("OrderDate") %>' runat="server" ID="OrderDateTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("VendorName") %>' runat="server" ID="VendorNameTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneTextBox" /></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #DCDCDC; color: #000000;">
                <td></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate","{0:MMM dd, yyyy}") %>' runat="server" ID="OrderDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneLabel" /></td>
                <td>
                    <asp:LinkButton ID="ViewOrderTextLink" runat="server" OnClick="ViewOrderTextLink_Click">View Order</asp:LinkButton></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                <th runat="server"></th>
                                <th runat="server">Order</th>
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
        <SelectedItemTemplate>
            <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                <td></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate","{0:MMM dd, yyyy}") %>' runat="server" ID="OrderDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorName") %>' runat="server" ID="VendorNameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("VendorContactPhone") %>' runat="server" ID="VendorContactPhoneLabel" /></td>
                <td>
                    <asp:LinkButton ID="ViewOrderTextLink" runat="server" OnClick="ViewOrderTextLink_Click">View Order</asp:LinkButton></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController"></asp:ObjectDataSource>
</asp:Content>
