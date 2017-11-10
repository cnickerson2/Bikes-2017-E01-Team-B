<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        
        <h1><img src="Content/Images/logo.png" width="133px" height="124px" />&nbsp; eBikes - Team B</h1>
        <p class="lead">TC<sup>3</sup> Application Development will be converting Bikes R Us&trade; Inc.'s Management System into a set of computerized subsystems that will allow employees to manage various aspect of the business via the Internet.</p> 
        <p><a href="http://dmit-2018.github.io/docs/project/eBike/jan2017/index.html#?q=1" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Team Members</h2>
            <ul>
                <li>
                    <b>Chris Nickerson</b>: Chris is responsible for...
                    <ul>
                        <li>Setting up the Default.aspx page</li>
                    </ul>
                </li>
                <li><b>Colton Loewan</b>: Colton is responsible for...
                    <ul>
                        <li>Initializing the solution in GitHub</li>
                        <li>Creating the Entity classes and the Context class</li>
                        <li>Adding validation to the entities</li>
                    </ul>
                </li>
                <li><b>Craig Chayka</b>: Craig is responsible for...
                    <ul>
                        <li>Adding a Message User Control</li>
                        <li>Setting up the About.aspx page</li>
                    </ul>
                </li>
                <li><b>TJ Blakely</b>: TJ is responsible for...
                    <ul>
                        <li>Adding navigation and setting up the folders for pages</li>
                        <li>Setting up the connection strings</li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Known Bugs</h2>
            <ul>
                <li><b>Version 0.1</b> - Shared Components Setup
                    <ul>
                        <li>No known issues at this time</li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-md-4">
            <h2>Task List</h2>
            <h4>Shared Components</h4>
            <asp:CheckBoxList runat="server" ID="TaskList" OnLoad="TaskList_Load">
                <asp:ListItem Enabled="false" Selected="True" Text="Create the Solution">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Update NuGet Packages">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Force-Add Bin Files">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add References">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add Navigation on Site.master">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Replace default application name">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Set up Web Connection Strings">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Create folders for each subsystem, with one page per folder">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Create the entity classes">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Create the context classes">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add correct validation to entity classes">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add common user controls">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add information to the About.aspx page">
                </asp:ListItem>
                <asp:ListItem Enabled="false" Selected="true" Text="Add information to the Default.aspx page">
                </asp:ListItem>
            </asp:CheckBoxList>
                
                
                        
                       
                    
            
        </div>
    </div>
</asp:Content>
