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
                        <asp:BoundField DataField="PurchaseOrderID" HeaderText="PurchaseOrderID" ItemStyle-Width="75px" SortExpression="PurchaseOrderID" ItemStyle-HorizontalAlign="Right" ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" Visible="False" />
                        <asp:BoundField DataField="PurchaseOrderNumber" HeaderText="Order" SortExpression="PurchaseOrderNumber" ItemStyle-CssClass="paddingCell" ItemStyle-Width="150px" HeaderStyle-CssClass="text-center">
                            <ItemStyle HorizontalAlign="Right" CssClass="paddingCell" Width="75px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" DataFormatString="{0:MMM dd, yyyy}">
                            <ItemStyle CssClass="paddingCell" Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" ItemStyle-CssClass="paddingCell" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="VendorContactPhone" HeaderText="Contact" SortExpression="VendorContactPhone">
                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle CssClass="paddingCell"></ItemStyle>
                        </asp:BoundField>
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
                        <asp:Label ID="PurchaseOrderID_FormView" runat="server" Text='<%# Eval("PurchaseOrderID", "{0}") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <br />
                <asp:GridView ID="OutstandingDetailsGridView" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SelectedOrderODS" Enabled="False" Visible="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" Width="80%">
                    <Columns>
                        <asp:TemplateField HeaderText="PurchaseOrderDetailID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="PurchaseOrderDetailID" runat="server" Text='<%# Bind("PurchaseOrderDetailID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PurchaseOrderID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="PurchaseOrderID" runat="server" Text='<%# Bind("PurchaseOrderID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Part #" ItemStyle-Width="75px" SortExpression="PartID" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:Label ID="PartID" runat="server" Text='<%# Bind("PartID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Right" CssClass="paddingCell" Width="75px"></ItemStyle>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" ItemStyle-Width="250px" SortExpression="PartDescription" ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:Label ID="PartDescription" runat="server" Text='<%# Bind("PartDescription") %>'></asp:Label>
                            </ItemTemplate>

<HeaderStyle CssClass="text-center"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" CssClass="paddingCell" Width="250px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ordered" SortExpression="QuantityOnOrder">
                            <ItemTemplate>
                                <asp:Label ID="QuantityOnOrder" runat="server" Text='<%# Bind("QuantityOnOrder") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Right" CssClass="paddingCell" Width="75px"></ItemStyle>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Outstanding" SortExpression="QuantityOutstanding">
                            <ItemTemplate>
                                <asp:Label ID="QuantityOutstanding" runat="server" Text='<%# Bind("QuantityOutstanding") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Right" CssClass="paddingCell" Width="75px"></ItemStyle>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Receiving" HeaderStyle-CssClass="text-center" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:TextBox ID="ReceivingAmount" runat="server" Height="16px" TextMode="Number" ToolTip="Receiving #" Width="50px" min="0" max="9999" CssClass="text-right" Text='<%# Bind("ReceivingAmount") %>'></asp:TextBox>
                            </ItemTemplate>

                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Center" CssClass="paddingCell" Width="75px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Returning" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ItemStyle-CssClass="paddingCell">
                            <ItemTemplate>
                                <asp:TextBox ID="ReturningAmount" runat="server" Height="16px" TextMode="Number" ToolTip="Return #" Width="50px" min="0" max="9999" CssClass="text-right" Text='<%# Bind("ReturningAmount") %>'></asp:TextBox>
                            </ItemTemplate>

                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle HorizontalAlign="Center" CssClass="paddingCell" Width="75px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="paddingCell" ItemStyle-Width="300px" HeaderStyle-CssClass="text-center">
                            <ItemTemplate>
                                <asp:TextBox ID="ReturningReason" runat="server" Height="16px" ToolTip="Reason for Returning" Width="100%" Text='<%# Bind("ReturningReason") %>'></asp:TextBox>
                            </ItemTemplate>

                            <HeaderStyle CssClass="text-center"></HeaderStyle>

                            <ItemStyle CssClass="paddingCell" Width="300px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VendorPartNumber" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="VendorPartNumber" runat="server" Text='<%# Bind("VendorPartNumber") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" HorizontalAlign="Left" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#487575" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#275353" />
                </asp:GridView>
                <br />
                <asp:Button ID="ReceiveBtn" runat="server" Text="Receive" OnCommand="ReceiveBtn_Command" /> &nbsp; &nbsp; &nbsp;
                <asp:Button ID="ForceCloseBtn" runat="server" Text="Force Closure" />
            </div>
        </div>
    </div>
    
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController" ViewStateMode="Enabled"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SelectedOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrderDetails_GetOutstandingOrdersByPurchaseOrder" TypeName="BikesSystem.BLL.PurchaseOrderDetailsController" ViewStateMode="Enabled">
        <SelectParameters>
            <asp:ControlParameter ControlID="OutstandingOrderGridView" PropertyName="SelectedValue" Name="purchaseOrderID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    
</asp:Content>