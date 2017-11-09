<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <h3>Team Members</h3>
    <ul>
        <li>Craig Chayka</li>
        <li>Christopher Nickerson</li>
        <li>Timothy James Blakely</li>
        <li>Colton Loewen</li>
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
