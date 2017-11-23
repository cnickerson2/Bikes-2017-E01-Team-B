<%@ Page Title="Receiving" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Receiving_Receiving" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Receiving</h1>
    <div class="row">
        <div class="col-md-12">
            
        </div>
    </div>
    <div class="row" id="SelectedInfo">
        <div class="col-md-12">
            <div class="tab-content">
                <asp:GridView ID="OutstandingOrderGridView" runat="server" DataSourceID="OutstandingOrderODS" AutoGenerateColumns="False" AllowPaging="True" OnSelectedIndexChanged="OutstandingOrderGridView_SelectedIndexChanged" DataKeyNames="PurchaseOrderID">
                    <Columns>
                        <asp:BoundField DataField="PurchaseOrderNumber" HeaderText="Order" SortExpression="PurchaseOrderNumber" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" />
                        <asp:BoundField DataField="VendorContactPhone" HeaderText="Contact" SortExpression="VendorContactPhone" />
                        <asp:CommandField ShowSelectButton="True" SelectText="View Order"  />
                    </Columns>
                    <EmptyDataTemplate>
                        No Results Found
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:FormView ID="SelectedOrderFormView" runat="server" DataSourceID="SelectedOrderODS" Enabled="False" Visible="False">
                    <ItemTemplate>
                        PO:
                        <asp:Label ID="PO" runat="server" Text='<%# Eval("PurchaseOrderNumber", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; Vendor:<asp:Label ID="Vendor" runat="server" Text='<%# Eval("VendorName", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; Contact:<asp:Label ID="Contact" runat="server" Text='<%# Eval("VendorContactPhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <asp:ListView ID="OutstandingDetailsListView" runat="server" DataSourceID="SelectedOrderODS" Enabled="False" Visible="False">
                    <AlternatingItemTemplate>
                        <tr style="background-color:#FFF8DC;">
                            <td>
                                <asp:Label ID="PartIDLabel" runat="server" Text='<%# Eval("PartID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="PartDescriptionLabel" runat="server" Text='<%# Eval("PartDescription") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOnOrderLabel" runat="server" Text='<%# Eval("QuantityOnOrder") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOutstandingLabel" runat="server" Text='<%# Eval("QuantityOutstanding") %>' />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color:#008A8C;color: #FFFFFF;">
                            <td>
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                            </td>
                            <td>
                                <asp:TextBox ID="PartIDTextBox" runat="server" Text='<%# Bind("PartID") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="PartDescriptionTextBox" runat="server" Text='<%# Bind("PartDescription") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="QuantityOnOrderTextBox" runat="server" Text='<%# Bind("QuantityOnOrder") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="QuantityOutstandingTextBox" runat="server" Text='<%# Bind("QuantityOutstanding") %>' />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <tr style="">
                            <td>
                                <asp:TextBox ID="PurchaseOrderIDTextBox" runat="server" Text='<%# Bind("PurchaseOrderID") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="PartIDTextBox" runat="server" Text='<%# Bind("PartID") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="PartDescriptionTextBox" runat="server" Text='<%# Bind("PartDescription") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="QuantityOnOrderTextBox" runat="server" Text='<%# Bind("QuantityOnOrder") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="QuantityOutstandingTextBox" runat="server" Text='<%# Bind("QuantityOutstanding") %>' />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="background-color:#DCDCDC;color: #000000;">
                            <td>
                                <asp:Label ID="PartIDLabel" runat="server" Text='<%# Eval("PartID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="PartDescriptionLabel" runat="server" Text='<%# Eval("PartDescription") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOnOrderLabel" runat="server" Text='<%# Eval("QuantityOnOrder") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOutstandingLabel" runat="server" Text='<%# Eval("QuantityOutstanding") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                            <th runat="server">Part#</th>
                                            <th runat="server">Description</th>
                                            <th runat="server">Ordered</th>
                                            <th runat="server">Outstanding</th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;"></td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                            <td>
                                <asp:Label ID="PartIDLabel" runat="server" Text='<%# Eval("PartID") %>' />
                            </td>
                            <td>
                                <asp:Label ID="PartDescriptionLabel" runat="server" Text='<%# Eval("PartDescription") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOnOrderLabel" runat="server" Text='<%# Eval("QuantityOnOrder") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityOutstandingLabel" runat="server" Text='<%# Eval("QuantityOutstanding") %>' />
                            </td>
                        </tr>
                    </SelectedItemTemplate>

                </asp:ListView>
            </div>
        </div>
    </div>
    
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SelectedOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrderDetails_GetOutstandingOrdersByPurchaseOrder" TypeName="BikesSystem.BLL.PurchaseOrderDetailsController">
        <SelectParameters>
            <asp:ControlParameter ControlID="OutstandingOrderGridView" PropertyName="SelectedValue" Name="purchaseOrderID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    
</asp:Content>

