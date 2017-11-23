<%@ Page Title="Receiving" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Receiving_Receiving" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .paddingCell
        {
            padding-right:10px;
            padding-left:10px;
        }
    </style>
    <h1>Receiving</h1>
    <div class="row">
        <div class="col-md-12">
            
        </div>
    </div>
    <div class="row" id="SelectedInfo">
        <div class="col-md-12">
            <div class="tab-content">
                <asp:GridView ID="OutstandingOrderGridView" runat="server" DataSourceID="OutstandingOrderODS" AutoGenerateColumns="False" AllowPaging="True" OnSelectedIndexChanged="OutstandingOrderGridView_SelectedIndexChanged" DataKeyNames="PurchaseOrderID" CellPadding="4" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" Width="80%">
                    <Columns>
                        <asp:BoundField DataField="PurchaseOrderNumber" HeaderText="Order" ItemStyle-Width="75px" SortExpression="PurchaseOrderNumber" ItemStyle-HorizontalAlign="Right"  ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-CssClass="paddingCell" ItemStyle-Width="150px" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="VendorContactPhone" HeaderText="Contact" SortExpression="VendorContactPhone" ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" />
                        <asp:CommandField ShowSelectButton="True" SelectText="View Order" ItemStyle-CssClass="paddingCell" ItemStyle-Width="100px" HeaderStyle-CssClass="text-center">
                        </asp:CommandField>
                    </Columns>
                    <EmptyDataTemplate>
                        No Results Found
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="White" ForeColor="#333333"></FooterStyle>

                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"></HeaderStyle>

                    <PagerStyle HorizontalAlign="Center" BackColor="#336666" ForeColor="White"></PagerStyle>

                    <RowStyle BackColor="White" ForeColor="#333333"></RowStyle>

                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                    <SortedAscendingCellStyle BackColor="#F7F7F7"></SortedAscendingCellStyle>

                    <SortedAscendingHeaderStyle BackColor="#487575"></SortedAscendingHeaderStyle>

                    <SortedDescendingCellStyle BackColor="#E5E5E5"></SortedDescendingCellStyle>

                    <SortedDescendingHeaderStyle BackColor="#275353"></SortedDescendingHeaderStyle>
                </asp:GridView>
                <br />
                <asp:FormView ID="SelectedOrderFormView" runat="server" DataSourceID="SelectedOrderODS" Enabled="False" Visible="False" Width="80%">
                    <EmptyDataTemplate>
                        No data was returned.
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <b>PO:</b>&nbsp;<asp:Label ID="PO" runat="server" Text='<%# Eval("PurchaseOrderNumber", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; <b>Vendor:</b>&nbsp;<asp:Label ID="Vendor" runat="server" Text='<%# Eval("VendorName", "{0}") %>'></asp:Label>
                        &nbsp;&nbsp;&nbsp; <b>Contact:</b>&nbsp;<asp:Label ID="Contact" runat="server" Text='<%# Eval("VendorContactPhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <br />
                <asp:GridView ID="OutstandingDetailsGridView" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SelectedOrderODS" Enabled="False" Visible="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" Width="80%">
                    <Columns>
                        <asp:BoundField DataField="PartID" HeaderText="Part #" ItemStyle-Width="75px" SortExpression="PartID" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                        </asp:BoundField>
                        <asp:BoundField DataField="PartDescription" HeaderText="Description" ItemStyle-Width="250px" SortExpression="PartDescription" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                        </asp:BoundField>
                        <asp:BoundField DataField="QuantityOnOrder" HeaderText="Ordered" ItemStyle-Width="75px" SortExpression="QuantityOnOrder" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                        </asp:BoundField>
                        <asp:BoundField DataField="QuantityOutstanding" HeaderText="Outstanding" ItemStyle-Width="75px" SortExpression="QuantityOutstanding" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Receiving" HeaderStyle-CssClass="text-center" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:TextBox ID="ReceivingTextBox" runat="server" Height="16px" TextMode="Number" ToolTip="Receiving #" Width="50px" min="0" max="9999" CssClass="text-right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Returning" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:TextBox ID="ReturningTextBox" runat="server" Height="16px" TextMode="Number" ToolTip="Return #" Width="50px" min="0" max="9999" CssClass="text-right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="paddingCell" ItemStyle-Width="300px" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:TextBox ID="ReasonTextBox" runat="server" Height="16px" ToolTip="Reason for Returning" Width="100%"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#487575" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#275353" />
                </asp:GridView>
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

