<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="JobServiceDetails.aspx.cs" Inherits="Jobing_JobServiceDetails" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:HiddenField ID="JobIDHidden" runat="server"/>

    <asp:HiddenField ID="JobServiceIDHidden" runat="server"/>

    <h2>Current Job Service Details</h2>

    <p>Click "Select" to select a service from the list.</p>
    
    <p>Once a service is selected, information about the service, including a list of parts used will appear below.</p>

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <!--Top Level Controls-->
    <br />
    <asp:Label ID="ServicesLabel" runat="server" Text="Services" Font-Size="Large"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="StartServiceButton" runat="server"
                              CommandArgument="" OnCommand="StartServiceButton_Click" Text="Start Service" >
                        </asp:Button>

    <!--ListView Control-->
    <asp:ListView ID="CurrentJobServicesListView" runat="server" DataSourceID="CurrentJobServicesODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label runat="server" HeaderText="Active" SortExpression="Active">
                        <ItemTemplate><%# (Eval("Completed") == null ? "" : bool.Parse(Eval("Completed").ToString()) == false ? "Started" : "Done") %></ItemTemplate>
                    </asp:Label></td>
                <td>
                    <asp:LinkButton ID="Select" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Select_Command" >
                            <span aria-hidden="true" >Select</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Done" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Done_Command" >
                            <span aria-hidden="true" >Done</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Remove" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Remove_Command" >
                            <span aria-hidden="true" >Remove</span>
                        </asp:LinkButton></td>
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
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label runat="server" HeaderText="Active" SortExpression="Active">
                        <ItemTemplate><%# (Eval("Completed") == null ? "" : bool.Parse(Eval("Completed").ToString()) == false ? "Started" : "Done") %></ItemTemplate>
                    </asp:Label></td>
                <td>
                    <asp:LinkButton ID="Select" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Select_Command" >
                            <span aria-hidden="true" >Select</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Done" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Done_Command" >
                            <span aria-hidden="true" >Done</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Remove" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Remove_Command" >
                            <span aria-hidden="true" >Remove</span>
                        </asp:LinkButton></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                <th runat="server">Description</th>
                                <th runat="server">Status</th>
                                <th runat="server"></th>
                                <th runat="server"></th>
                                <th runat="server"></th>
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
        <SelectedItemTemplate>
            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label runat="server" HeaderText="Active" SortExpression="Active">
                        <ItemTemplate><%# (Eval("Completed") == null ? "" : bool.Parse(Eval("Completed").ToString()) == false ? "Started" : "Done") %></ItemTemplate>
                    </asp:Label></td>
                <td>
                    <asp:LinkButton ID="Select" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Select_Command" >
                            <span aria-hidden="true" >Select</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Done" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Done_Command" >
                            <span aria-hidden="true" >Done</span>
                        </asp:LinkButton></td>
                <td>
                    <asp:LinkButton ID="Remove" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Remove_Command" >
                            <span aria-hidden="true" >Remove</span>
                        </asp:LinkButton></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>

    <!--Third Level Controls-->
    <br />
    <asp:Label ID="DescriptionLabel" runat="server" Text="Description"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:Label ID="DescriptionHolder" runat="server" Text=""></asp:Label> <!--Holds the description of the service-->
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="HoursLabel" runat="server" Text="Hours"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:Label ID="HoursHolder" runat="server" Text=""></asp:Label> <!--Holds the hours of the service-->

    <!--Fourth Level Controls-->
    <br />
    <asp:Label ID="CommentsLabel" runat="server" Text="Comments"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:Label ID="CommentsHolder" runat="server" Text=""></asp:Label> 
    <br />
    <!--Holds the comments for the service-->

    <!--Fifth Level Controls-->
    <asp:Button ID="AddCommentButton" runat="server" Text="Add" OnClick="AddCommentButton_Click" />
    &nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="CommentTextbox" runat="server" Placeholder="Add any additional comments discovered while doing the service" Width="487px"></asp:TextBox>

    <!--Sixth Level Controls-->
    <br />
    <br />
    <asp:ListView ID="JobServicePartListView" runat="server" DataSourceID="PartsODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFF8DC;">
                <td>
                    <asp:Button runat="server"  Text="Edit" ID="EditButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" Width="100px"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" Width="100px" /></td>
                <td>
                    <asp:Button runat="server"  Text="Delete" ID="DeleteButton" /></td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color: #008A8C; color: #FFFFFF;">
                <td>
                    <asp:Button runat="server"  Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server"  Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" Width="100px"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" Width="100px" /></td>
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
                    <asp:Button runat="server"  Text="Insert" ID="InsertButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" Width="100px"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" Width="100px" /></td>
                <td>
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #DCDCDC; color: #000000;">
                <td>
                    <asp:Button runat="server"  Text="Edit" ID="EditButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" Width="100px"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" Width="100px" /></td>
                <td>
                    <asp:Button runat="server"  Text="Delete" ID="DeleteButton" /></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                <th runat="server"></th>
                                <th runat="server">PartID</th>
                                <th runat="server">Description</th>
                                <th runat="server">Quantity</th>
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
                <td>
                    <asp:Button runat="server"  Text="Edit" ID="EditButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" Width="100px"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                <td>
                    <asp:Button runat="server"  Text="Delete" ID="DeleteButton" /></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>

    <asp:ObjectDataSource ID="CurrentJobServicesODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="List_CurrentServices" TypeName="BikesSystem.BLL.JobDetailsController">
        <SelectParameters>
            <asp:ControlParameter ControlID="JobIDHidden" PropertyName="Value" Name="jobid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="PartsODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="CurrentParts_List" TypeName="BikesSystem.BLL.JobDetailPartController">
        <SelectParameters>
            <asp:ControlParameter ControlID="JobServiceIDHidden" PropertyName="Value" Name="jobserviceid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

