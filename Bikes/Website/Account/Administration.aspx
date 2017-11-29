<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Administration.aspx.cs" Inherits="Account_Administration" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <link href="../Content/administration.css" rel="stylesheet" />

    <h1 class="text-center">Security</h1>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
    <asp:ValidationSummary ID="ValidationSummary" runat="server" />
    <div class="row">
        <div class="col-md-9">
            <div class="container">
                <asp:ListView ID="MembersList" runat="server"
                    DataSourceID="MembersODS"
                    InsertItemPosition="LastItem">
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" border="0">
                                        <tr runat="server">
                                            <th runat="server">Actions</th>
                                            <th runat="server">Username</th>
                                            <th runat="server">Profile</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server">
                                    <asp:DataPager runat="server" ID="DataPager1">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button"
                                                ButtonCssClass="btn"
                                                ShowFirstPageButton="True" ShowNextPageButton="False"
                                                ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                            <asp:NumericPagerField></asp:NumericPagerField>
                                            <asp:NextPreviousPagerField ButtonType="Button"
                                                ButtonCssClass="btn"
                                                ShowLastPageButton="True" ShowNextPageButton="False"
                                                ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="RowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                    Remove</asp:LinkButton>
                                <asp:RadioButton ID="SelectRadio" runat="server"
                                    AutoPostBack="True"
                                    OnCheckedChanged="SelectRadio_CheckedChanged" />
                                <asp:LinkButton ID="SelectButton" runat="server"
                                    CommandName="Select">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="RowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                    Remove</asp:LinkButton>
                                <asp:RadioButton ID="SelectRadio" runat="server"
                                    AutoPostBack="True"
                                    OnCheckedChanged="SelectRadio_CheckedChanged" />
                                <asp:LinkButton ID="SelectButton" runat="server"
                                    CommandName="Select">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <SelectedItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                    Remove</asp:LinkButton>
                                <asp:RadioButton ID="SelectRadio" runat="server"
                                    Enabled="false" Checked="true" />
                                <asp:LinkButton ID="SelectButton" runat="server"
                                    Enabled="false">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                    <InsertItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/pageIcon.svg" alt="remove" width="16" height="16" />
                                    Insert</asp:LinkButton>
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/xIcon.svg" alt="cancel" width="16" height="16" />
                                    Cancel</asp:LinkButton>
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("UserName") %>' runat="server" ID="UserNameBox"
                                    Placeholder="preferred username" />
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("Email") %>' type="email"
                                    runat="server" ID="EmailTextBox"
                                    Placeholder="valid email address"
                                    AutoCompleteType="Email" />
                                <div>
                                    <asp:DropDownList ID="MemberTypesDropDown" runat="server"
                                        style="width: 100%;"></asp:DropDownList><br />
                                    <asp:TextBox type="number"
                                        ID="TypeIdTextBox" runat="server"
                                        Placeholder="Employee ID"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server">
                            <tr>
                                <td>No member's could be found.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
        <div class="col-md-3">
            <h2>Context Selection</h2>
            <%--<asp:ListView ID="ContextList" runat="server"></asp:ListView>--%>
        </div>
    </div>
    <h1 class="text-center">Roles</h1>
    <%--<asp:ListView ID="RolesList" runat="server"
        DataSourceID="RolesODS"></asp:ListView>--%>

    <asp:ObjectDataSource ID="MembersODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="ListAllUsers"
        TypeName="BikesSystem.BLL.Security.UserManager"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="RolesODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="ListAllRoles"
        TypeName="BikesSystem.BLL.Security.RoleManager"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ContextODS" runat="server"></asp:ObjectDataSource>
</asp:Content>

