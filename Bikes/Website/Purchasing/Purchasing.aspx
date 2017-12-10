<%@ Page Title="Purchasing" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Purchasing.aspx.cs" Inherits="Purchasing_Purchasing" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Purchasing</h1>
    <br>

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <asp:Label ID="LoggedInUserDisplay" runat="server" Text="Label"></asp:Label>
    <br>
    <br>

    <asp:Label ID="VendorDDLLabel" runat="server" Text="Label">Vendor</asp:Label>
    <asp:DropDownList ID="VendorDDL" runat="server" DataSourceID="VendorDDL_ODS" DataTextField="VendorName" DataValueField="VendorID" AppendDataBoundItems="true">
        <asp:ListItem Value="0">[Select a Vendor]</asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="GetCreatePOButton" runat="server" Text="Get / Create PO" style="display: inline-block; margin-left: 12px;" OnClick="GetCreatePOButton_Click"/>
    <br>
    <br>

    <asp:GridView ID="VendorInfoView" runat="server" AutoGenerateColumns="False" DataSourceID="VendorInfoODS">
        <Columns>
            <asp:BoundField DataField="VendorName" HeaderText="VendorName" SortExpression="VendorName"></asp:BoundField>
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
        </Columns>
    </asp:GridView>

    <h1>Current Purchase Order</h1>
    <br>

    <asp:ListView ID="PurchaseOrderView" runat="server" DataSourceID="PurchaseOrderView_ODS" OnItemCommand="PurchaseOrderView_ItemCommand" >
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <asp:HiddenField ID="PurchaseOrderDetailIDHidden" runat="server" Value='<%# Eval("PurchaseOrderDetailID") %>'/>
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                <td>
                    <asp:TextBox ID="QuantityBox" runat="server" Text='<%# Eval("Quantity") %>' style="margin: 4px;" type="number"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="PurchasePriceBox" runat="server" Text='<%# ((decimal)Eval("PurchasePrice")).ToString("F2") %>' style="margin: 4px;"></asp:TextBox>
                    </td>
                <td>
                    <asp:LinkButton ID="RemoveItem" runat="server" CommandName="Remove" CommandArgument='<%# Eval("PartID") %>'>Remove</asp:LinkButton></td>
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
            <tr style="background-color: #E0FFFF; color: #333333;">
                <asp:HiddenField ID="PurchaseOrderDetailIDHidden" runat="server" Value='<%# Eval("PurchaseOrderDetailID") %>'/>
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                <td>
                    <asp:TextBox ID="QuantityBox" runat="server" Text='<%# Eval("Quantity") %>' style="margin: 4px;" type="number"></asp:TextBox>
                </td>
                 <td>
                    <asp:TextBox ID="PurchasePriceBox" runat="server" Text='<%# ((decimal)Eval("PurchasePrice")).ToString("F2") %>' style="margin: 4px;"></asp:TextBox>
                <td>
                    <asp:LinkButton ID="RemoveItem" runat="server" CommandName="Remove" CommandArgument='<%# Eval("PartID") %>'>Remove</asp:LinkButton></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                <th runat="server">PartID</th>
                                <th runat="server">Description</th>
                                <th runat="server">QuantityOnHand</th>
                                <th runat="server">QuantityOnOrder</th>
                                <th runat="server">ReorderLevel</th>
                                <th runat="server">Quantity</th>
                                <th runat="server">PurchasePrice</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF"></td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
    <br>

    <asp:Button ID="Update_Button" runat="server" Text="Update" OnClick="Update_Button_Click" />
    <asp:Button style="margin-left: 12px;" ID="Place_Button" runat="server" Text="Place" OnClick="Place_Button_Click"/>
    <asp:Button style="margin-left: 12px;" ID="Delete_Button" runat="server" Text="Delete" OnClick="Delete_Button_Click"/>
    <asp:Button style="margin-left: 12px;" ID="Clear_Button" runat="server" Text="Clear" OnClick="Clear_Button_Click" />
    <br>
    <br>

    <asp:GridView ID="PurchaseOrderTotalsView" runat="server" AutoGenerateColumns="False" DataSourceID="PurchaseOrderTotalsView_ODS">
        <Columns>
            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" SortExpression="Subtotal" DataFormatString="{0:C}"></asp:BoundField>
            <asp:BoundField DataField="GST" HeaderText="GST" SortExpression="GST" DataFormatString="{0:C}"></asp:BoundField>
            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:C}"></asp:BoundField>
        </Columns>
    </asp:GridView>

    <h1>Current Inventory</h1>
    <br>

    <asp:ListView ID="CurrentInventoryView" runat="server" DataSourceID="CurrentInventoryView_ODS" OnItemCommand="CurrentInventoryView_ItemCommand">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFF8DC;">
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnorder") %>' runat="server" ID="QuantityOnorderLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                <td>
                    <asp:Label Text='<%# ((decimal)Eval("SellingPrice")).ToString("C") %>' runat="server" ID="SellingPriceLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel" /></td>
                <td>
                    <asp:LinkButton ID="AddItem" runat="server" CommandName="Add" CommandArgument='<%# Eval("PartID") %>'>Add</asp:LinkButton></td>
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
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QuantityOnorder") %>' runat="server" ID="QuantityOnorderLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                <td>
                    <asp:Label Text='<%# ((decimal)Eval("SellingPrice")).ToString("C") %>' runat="server" ID="SellingPriceLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel" /></td>
                <td>
                    <asp:LinkButton ID="AddItem" runat="server" CommandName="Add" CommandArgument='<%# Eval("PartID") %>'>Add</asp:LinkButton></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                <th runat="server">PartID</th>
                                <th runat="server">Description</th>
                                <th runat="server">QuantityOnHand</th>
                                <th runat="server">QuantityOnorder</th>
                                <th runat="server">ReorderLevel</th>
                                <th runat="server">SellingPrice</th>
                                <th runat="server">Buffer</th>
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

    <asp:ObjectDataSource ID="VendorDDL_ODS" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetVendorIdentifications"
        TypeName="BikesSystem.BLL.VendorController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PurchaseOrderView_ODS" runat="server" OldValuesParameterFormatString="original_{0}"  SelectMethod="GetPurchaseOrderDetails" TypeName="BikesSystem.BLL.PurchaseOrderController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" DefaultValue="0" Name="vendorID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CurrentInventoryView_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPartInfoNotOnOrder" TypeName="BikesSystem.BLL.PartController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" DefaultValue="0" Name="vendorID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="VendorInfoODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetVendorInfo" TypeName="BikesSystem.BLL.VendorController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" DefaultValue="0" Name="vendorID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="PurchaseOrderTotalsView_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPurchaseOrderTotals" TypeName="BikesSystem.BLL.PurchaseOrderController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" DefaultValue="0" Name="vendorID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>