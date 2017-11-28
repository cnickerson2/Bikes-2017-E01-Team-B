<%@ Page Title="Receiving" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Receiving_Receiving" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .paddingCell
        {
            padding-right:10px;
            padding-left:10px;
        }
        .modalBackground{
            background-color:black;
            filter:alpha(opacity=90) !important;
            opacity:0.6 !important;
            z-index:20;
        }
        .modalpopup
        {
            padding: 20px 0px 24px 10px;
            position: relative;
            background-color:white;
            border: 1px solid black;
        }
    </style>
    <h1>Receiving</h1>
    <div class="row">
        <div class="col-md-12">
            <asp:Panel ID="PopupPanel" runat="server" CssClass="modalpopup">
                <asp:ListView ID="CartListView" runat="server" DataSourceID="UnorderedCartODS" InsertItemPosition="FirstItem" DataKeyNames="CartID">
                    <AlternatingItemTemplate>
                        <tr style="background-color:#FFF8DC;">
                            <td>
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Remove" />
                            </td>
                            <td>
                                <asp:Label ID="VendorPartNumberLabel" runat="server" Text='<%# Eval("VendorPartNumber") %>' />
                            </td>
                            <td>
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                            <tr>
                                <td>No items in Cart.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <tr style="">
                            <td>
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                            </td>
                            <td>
                                <asp:TextBox ID="VendorPartNumberTextBox" runat="server" Text='<%# Bind("VendorPartNumber") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="background-color:#DCDCDC;color: #000000;">
                            <td>
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Remove" />
                            </td>
                            <td>
                                <asp:Label ID="VendorPartNumberLabel" runat="server" Text='<%# Eval("VendorPartNumber") %>' />
                            </td>
                            <td>
                                <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                            </td>
                            <td>
                                <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                            <th runat="server"></th>
                                            <th runat="server">Vendor Part #</th>
                                            <th runat="server">Description</th>
                                            <th runat="server">Qty</th>
                                        </tr>
                                        <tr id="itemPlaceholder" runat="server">
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                            <asp:NumericPagerField />
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
                

                <br />
                <asp:Button ID="SubmitCart" runat="server" Text="Submit" />
                

            </asp:Panel>
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
                <br />
                <asp:Button ID="ReceiveBtn" runat="server" Text="Receive" /> &nbsp; &nbsp; &nbsp;
                <asp:Button ID="ForceCloseBtn" runat="server" Text="Force Closure" />
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" OkControlID="SubmitCart" PopupControlID="PopupPanel" TargetControlID="ReceiveBtn" BackgroundCssClass="modalBackground" ></ajaxToolkit:ModalPopupExtender>
            </div>
        </div>
    </div>
    
    <asp:ObjectDataSource ID="OutstandingOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrders_ListOutstandingOrders" TypeName="BikesSystem.BLL.PurchaseOrderController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SelectedOrderODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrderDetails_GetOutstandingOrdersByPurchaseOrder" TypeName="BikesSystem.BLL.PurchaseOrderDetailsController">
        <SelectParameters>
            <asp:ControlParameter ControlID="OutstandingOrderGridView" PropertyName="SelectedValue" Name="purchaseOrderID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="UnorderedCartODS" runat="server" DataObjectTypeName="BikesData.Entities.UnorderedPurchaseItemCart" DeleteMethod="UnorderedCartItems_Delete" InsertMethod="UnorderedCartItems_Add" OldValuesParameterFormatString="original_{0}" SelectMethod="UnorderedCartItems_List" TypeName="BikesSystem.BLL.UnorderedPurchaseItemCartController"></asp:ObjectDataSource>
</asp:Content>

