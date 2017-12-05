<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Jobs.aspx.cs" Inherits="Jobing_Jobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:Button ID="NewJobButton" runat="server" Text="Button" /> <!--This needs to go to JobDetails...I think-->
    <asp:ListView ID="JobListListView" runat="server"></asp:ListView>

</asp:Content>

