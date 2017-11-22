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
                        <asp:CommandField ShowSelectButton="True" SelectText="View Order" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Results Found
                    </EmptyDataTemplate>
                </asp:GridView>
               <%-- <asp:FormView ID="FormView1" runat="server" DataSourceID="SelectedOrderODS">
                    <EmptyDataTemplate>
                        <asp:Label ID="Label1" runat="server" Text="Error Loading Data"></asp:Label>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        PO:
                        <asp:Label ID="PO" runat="server" Text='<%# Eval("PurchaseOrderNumber", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; Vendor:<asp:Label ID="Vendor" runat="server" Text='<%# Eval("VendorName", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; Contact:<asp:Label ID="Contact" runat="server" Text='<%# Eval("VendorContactPhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:FormView>--%>
            </div>
        </div>
    </div>
    
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController"></asp:ObjectDataSource>
    <%--<asp:ObjectDataSource ID="SelectedOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrder_GetOutstandingOrder" TypeName="BikesSystem.BLL.PurchaseOrderDetailsController">
        <SelectParameters>
            <asp:ControlParameter ControlID="OutstandingOrderGridView" PropertyName="SelectedValue" Name="purchaseOrderID" Type="Int32" DefaultValue="0"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>--%>
    
</asp:Content>

