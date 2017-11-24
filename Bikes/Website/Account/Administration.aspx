<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Administration.aspx.cs" Inherits="Account_Administration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1 class="text-center">Security</h1>
    <div class="row">
        <div class="col-md-9">
            <div class="container">
                <asp:ListView ID="MembersList" runat="server"></asp:ListView>
            </div>
        </div>
        <div class="col-md-3">
            <h2>Context Selection</h2>
            <asp:ListView ID="ContextList" runat="server"></asp:ListView>
        </div>
    </div>
    <h1 class="text-center">Roles</h1>
    <asp:ListView ID="RolesList" runat="server"></asp:ListView>
</asp:Content>

