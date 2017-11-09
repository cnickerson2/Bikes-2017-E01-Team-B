<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>Team Members</h3>
    <ul>
        <li><img src="Content/Images/craig_github_logo.png" width="30" height="30"/>Craig Chayka</li>
        <li><img src="Content/Images/chris_github_logo.jpg" width="30" height="30"/>Christopher Nickerson</li>
        <li><img src="Content/Images/tj_github_logo.png" width="30" height="30"/>Timothy James Blakely</li>
        <li><img src="Content/Images/colton_github_logo.png" width="30" height="30"/>Colton Loewen</li>
    </ul>
    <h3>Security Roles</h3>
    <ul>
        <li>
            Webmaster
            <ul>
                <li>Username: webmaster</li>
                <li>Password: Webmaster01</li>
            </ul>
        </li>
        <li>
            Manager
            <ul>
                <li>Username: manager</li>
                <li>Password: Manager01</li>
            </ul>
        </li>
        <li>
            Employee
            <ul>
                <li>Username: employee</li>
                <li>Password: Employee01</li>
            </ul>
        </li>
    </ul>
    <h3>Connection String</h3>
    <p>&lt;add name="eBikesDB" connectionString="Data Source=.;Initial Catalog=eBikes;Integrated Security=true" providerName="System.Data.SqlClient"/&gt;</p>
</asp:Content>
