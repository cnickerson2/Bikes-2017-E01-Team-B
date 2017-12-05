<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="JobDetails.aspx.cs" Inherits="Jobing_JobDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <!--Top Row Controls-->
    <asp:Label ID="PresetLabel" runat="server" Text="Presets:"></asp:Label>
    <asp:DropDownList ID="PresetDropdownList" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Text="Select..." Value=""></asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="PresetButton" runat="server" Text="Select" /><!--This needs to update the fields necessary based on the ddl-->
    <asp:Label ID="CouponLabel" runat="server" Text="Coupon:"></asp:Label>
    <asp:DropDownList ID="CouponDropdownList" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Text="Select..." Value=""></asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="AddServiceButton" runat="server" Text="Button" /><!--New job created here if it doesn't exist. If job does exist, add service to existing job. TRANSACTION-->

    <!--Second Row Controls-->
    <asp:Label ID="DescriptionLabel" runat="server" Text="Description"></asp:Label>
    <asp:TextBox ID="DescriptionTextbox" runat="server"></asp:TextBox>
    <asp:Label ID="HoursLabel" runat="server" Text="Hours"></asp:Label>
    <asp:TextBox ID="HoursTextbox" runat="server"></asp:TextBox>

    <!--Third Row Controls-->
    <asp:Label ID="CommentsLabel" runat="server" Text="Comments"></asp:Label>
    <asp:TextBox ID="CommentsTextbox" runat="server"></asp:TextBox>

    <!--ListView Controls-->
    <asp:ListView ID="CurrentServicesListView" runat="server"></asp:ListView>

</asp:Content>

