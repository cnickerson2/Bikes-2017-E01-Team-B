<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="NewJob.aspx.cs" Inherits="Jobing_NewJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Create New Job</h2>


    <asp:DropDownList ID="CustomerDDL" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Text="Select..." Value="0"></asp:ListItem>
    </asp:DropDownList>

    <asp:ObjectDataSource ID="CustomerDDLODS" runat="server"></asp:ObjectDataSource>

</asp:Content>

