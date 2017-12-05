<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="JobServiceDetails.aspx.cs" Inherits="Jobing_JobServiceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <!--Top Level Controls-->
    <asp:Button ID="StartServiceButton" runat="server" Text="Start Service" />

    <!--ListView Control-->
    <asp:ListView ID="CurrentJobServicesListView" runat="server"></asp:ListView>

    <!--Third Level Controls-->
    <asp:Label ID="DescriptionLabel" runat="server" Text="Description"></asp:Label>
    <asp:Label ID="DescriptionHolder" runat="server" Text=""></asp:Label> <!--Holds the description of the service-->
    <asp:Label ID="HoursLabel" runat="server" Text="Hours"></asp:Label>
    <asp:Label ID="HoursHolder" runat="server" Text=""></asp:Label> <!--Holds the hours of the service-->

    <!--Fourth Level Controls-->
    <asp:Label ID="CommentsLabel" runat="server" Text="Comments"></asp:Label>
    <asp:Label ID="CommentsHolder" runat="server" Text=""></asp:Label> <!--Holds the comments for the service-->

    <!--Fifth Level Controls-->
    <asp:Button ID="AddCommentButton" runat="server" Text="Add Comment" />
    <asp:TextBox ID="CommentTextbox" runat="server" Text="Add any additional comments discovered while doing the service"></asp:TextBox>

    <!--Sixth Level Controls-->
    <asp:ListView ID="JobDetailPartsListView" runat="server"></asp:ListView>

</asp:Content>

