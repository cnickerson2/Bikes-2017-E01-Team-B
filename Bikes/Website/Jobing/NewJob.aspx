<%@ Page Title="Create New Job" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="NewJob.aspx.cs" Inherits="Jobing_NewJob" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Create New Job</h2>
    
    <p>Please fill in all fields, then click the "Create New Job" Button.</p>

    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <asp:Label ID="CustomerLabel" runat="server" Text="Customer:"></asp:Label>
    <asp:DropDownList ID="CustomerDDL" runat="server" AppendDataBoundItems="true" DataSourceID="CustomerDDLODS" DataTextField="FormalName" DataValueField="CustomerID">
        <asp:ListItem Text="Select..." Value="0"></asp:ListItem>
    </asp:DropDownList>

    <br />

    <asp:Label ID="EmployeeLabel" runat="server" Text="Employee:"></asp:Label>
    <asp:DropDownList ID="EmployeeDDL" runat="server" AppendDataBoundItems="true" DataSourceID="EmployeeDDLODS" DataTextField="FormalName" DataValueField="EmployeeID">
        <asp:ListItem Text="Select..." Value="0"></asp:ListItem>
    </asp:DropDownList>

    <br />

    <asp:Label ID="VehicleIDLabel" runat="server" Text="Vehicle ID:"></asp:Label>
    <asp:TextBox ID="VehicleIDTextbox" runat="server"></asp:TextBox>

    <br />

    <asp:Label ID="ShopRateLabel" runat="server" Text="Shop Rate: "></asp:Label>
    <asp:TextBox ID="ShopRateTextbox" runat="server" TextMode="Number"></asp:TextBox>

    <br />

    <asp:Button ID="CreateJobBtn" runat="server" Text="Create New Job" OnClick="CreateJobBtn_Click" />

    <asp:ObjectDataSource ID="CustomerDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Customer_List" TypeName="BikesSystem.BLL.JobCustomerController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="EmployeeDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Employee_List" TypeName="BikesSystem.BLL.EmployeeController"></asp:ObjectDataSource>

</asp:Content>

