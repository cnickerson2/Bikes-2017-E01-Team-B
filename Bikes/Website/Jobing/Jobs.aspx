<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Jobs.aspx.cs" Inherits="Jobing_Jobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:Button ID="NewJobButton" runat="server" Text="New Job" /> <!--This needs to go to JobDetails...I think-->
    <asp:ListView ID="JobListListView" runat="server" DataSourceID="JobListODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <td>
                    <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}", Eval("InDate")) %>' runat="server" ID="InDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}", Eval("StartDate")) %>' runat="server" ID="StartDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}", Eval("DoneDate")) %>' runat="server" ID="DoneDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("CustomerName") %>' runat="server" ID="CustomerNameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
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
                    <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}",Eval("InDate")) %>' runat="server" ID="InDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}",Eval("StartDate")) %>' runat="server" ID="StartDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# string.Format("{0:MMM d, yyyy}",Eval("DoneDate")) %>' runat="server" ID="DoneDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("CustomerName") %>' runat="server" ID="CustomerNameLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                <th runat="server">Job ID</th>
                                <th runat="server">In</th>
                                <th runat="server">Started</th>
                                <th runat="server">Done</th>
                                <th runat="server">Customer</th>
                                <th runat="server">Contact Number</th>
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

    <asp:ObjectDataSource ID="JobListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="List_CurrentJobs" TypeName="BikesSystem.BLL.JobController"></asp:ObjectDataSource>

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

