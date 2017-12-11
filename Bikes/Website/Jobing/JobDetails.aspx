<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="JobDetails.aspx.cs" Inherits="Jobing_JobDetails" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <asp:HiddenField ID="JobIDHidden" runat="server"/>
    
    <h2>Current Job Services</h2>

    <p>Please enter all fields with Service Data, then click the "Add Service" Button.</p>

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <!--Top Row Controls-->
    <asp:Label ID="PresetLabel" runat="server" Text="Presets:"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="PresetDropdownList" runat="server" AppendDataBoundItems="true" DataSourceID="PresetDDLODS" DataTextField="Description" DataValueField="StandardJobID">
        <asp:ListItem Text="Select..." Value=""></asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="PresetButton" runat="server" Text="Select" OnClick="PresetButton_Click" /><!--This needs to update the fields necessary based on the ddl-->
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="CouponLabel" runat="server" Text="Coupon:"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="CouponDropdownList" runat="server" AppendDataBoundItems="true" DataSourceID="CouponDDLODS" DataTextField="CouponIDValue" DataValueField="CouponID">
        <asp:ListItem Text="Select..." Value=""></asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="AddServiceButton" runat="server" Text="Add Service" OnClick="AddServiceButton_Click" />
    <br />
    <br />

    <!--Second Row Controls-->
    <asp:Label ID="DescriptionLabel" runat="server" Text="Description"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="DescriptionTextbox" runat="server" Width="314px"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="HoursLabel" runat="server" Text="Hours"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="HoursTextbox" runat="server" Width="60px"></asp:TextBox>

    <br />

    <br />

    <!--Third Row Controls-->
    <asp:Label ID="CommentsLabel" runat="server" Text="Comments"></asp:Label>
    &nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="CommentsTextbox" runat="server" Height="86px" Width="472px"></asp:TextBox>

    <br />
    <br />

    <!--ListView Controls-->
    <asp:ListView ID="CurrentServicesListView" runat="server" DataSourceID="CurrentServicesODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <td>
                    <asp:LinkButton ID="Remove" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Remove_Command" >
                            <span aria-hidden="true" >Remove</span>
                        </asp:LinkButton></td>
                <%--<td>
                    <asp:Label Text='<%# Eval("JobDetailID") %>' runat="server" ID="JobDetailIDLabel" /></td>--%>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("JobHours") %>' runat="server" ID="JobHoursLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Comments") %>' runat="server" ID="CommentsLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("CouponID") %>' runat="server" ID="CouponIDLabel" /></td>
                <!--<td>
                    <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>-->
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
                    <asp:LinkButton ID="Remove" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("JobDetailID") %>' OnCommand="Remove_Command" >
                            <span aria-hidden="true" >Remove</span>
                        </asp:LinkButton></td>
                <%--<td>
                    <asp:Label Text='<%# Eval("JobDetailID") %>' runat="server" ID="JobDetailIDLabel" /></td>--%>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("JobHours") %>' runat="server" ID="JobHoursLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Comments") %>' runat="server" ID="CommentsLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("CouponID") %>' runat="server" ID="CouponIDLabel" /></td>
                <!--<td>
                    <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>-->
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                <th runat="server"></th>
                                <%--<th runat="server">JobDetailID</th>--%>
                                <th runat="server">Description</th>
                                <th runat="server">Hours</th>
                                <th runat="server">Comments</th>
                                <th runat="server">CouponID</th>
                                <%--<th runat="server">JobID</th>--%>
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
                <%--<td>
                    <asp:Label Text='<%# Eval("JobDetailID") %>' runat="server" ID="JobDetailIDLabel" /></td>--%>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("JobHours") %>' runat="server" ID="JobHoursLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Comments") %>' runat="server" ID="CommentsLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("CouponID") %>' runat="server" ID="CouponIDLabel" /></td>
                <%--<td>
                    <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>--%>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>

    <asp:ObjectDataSource ID="CurrentServicesODS" runat="server" DataObjectTypeName="BikesData.Entities.JobDetail" DeleteMethod="Remove_Service" OldValuesParameterFormatString="original_{0}" SelectMethod="List_CurrentServices" TypeName="BikesSystem.BLL.JobDetailsController">
        <SelectParameters>
            <asp:ControlParameter ControlID="JobIDHidden" PropertyName="Value" Name="jobid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="PresetDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="StandardJob_List" TypeName="BikesSystem.BLL.StandardJobController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="CouponDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Coupon_List" TypeName="BikesSystem.BLL.CouponController"></asp:ObjectDataSource>

    <!--
        USE THIS CODE FOR THE VIEW, REMOVE, DELETE, ETC LINKS
                    <td>
                        <asp:LinkButton ID="AddtoPlaylist" runat="server"
                             CssClass="btn" CommandArgument='<%# Eval("TrackID") %>'>
                            <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                        </asp:LinkButton>
                        </td>
                    <td>    
    -->
</asp:Content>

