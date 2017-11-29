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
                    OnSelectedIndexChanged="MembersList_SelectedIndexChanged"
                    OnItemCanceling="MembersList_ItemCanceling"
                    InsertItemPosition="LastItem">
                    <LayoutTemplate>
                        <table runat="server"
                            ClientIDMode="Static" ID="MembersListTable">
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
                                <asp:HiddenField ID="UserId" Value='<%# Eval("UserId") %>' runat="server" />
                                <asp:HiddenField ID="RowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary right-separator">
                                    <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                    Remove</asp:LinkButton>
                                <asp:RadioButton ID="SelectRadio" runat="server"
                                    AutoPostBack="True"
                                    OnCheckedChanged="SelectRadio_CheckedChanged" />
                                <asp:LinkButton ID="SelectButton" runat="server"
                                    CausesValidation="false"
                                    CommandName="Select">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel"
                                    CssClass="right-separator" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="UserId" Value='<%# Eval("UserId") %>' runat="server" />
                                <asp:HiddenField ID="RowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary right-separator">
                                    <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                    Remove</asp:LinkButton>
                                <asp:RadioButton ID="SelectRadio" runat="server"
                                    AutoPostBack="True"
                                    OnCheckedChanged="SelectRadio_CheckedChanged" />
                                <asp:LinkButton ID="SelectButton" runat="server"
                                    CausesValidation="false"
                                    CommandName="Select">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel"
                                    CssClass="right-separator" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <SelectedItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="UserId" Value='<%# Eval("UserId") %>' runat="server" />
                                <asp:LinkButton ID="RemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary right-separator">
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
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel"
                                    CssClass="right-separator" />
                                <asp:Label Text='<%# Eval("FormalName") ?? "" %>' runat="server" ID="FirstNameLabel" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                    <InsertItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert"
                                    CssClass="btn btn-primary right-separator">
                                    <img src="../Content/Images/pageIcon.svg" alt="remove" width="16" height="16" />
                                    Insert</asp:LinkButton>
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel"
                                    CausesValidation="false"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/xIcon.svg" alt="cancel" width="16" height="16" />
                                    Cancel</asp:LinkButton>
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("UserName") %>' runat="server" ID="UserNameBox"
                                    Placeholder="preferred username" />
                                <asp:RequiredFieldValidator ID="UserNameRequiredValidator" runat="server"
                                    ErrorMessage="A username is required"
                                    ControlToValidate="UserNameBox"
                                    Display="None"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="UserNameRegularExpressionValidator" runat="server"
                                    ErrorMessage="The username must contain 2-20 alphabetic or numeric characters (letters and numbers)."
                                    ControlToValidate="UserNameBox"
                                    ValidationExpression="^[a-zA-Z0-9]{2,20}$"
                                    Display="None"></asp:RegularExpressionValidator>
                            </td>
                            <td class="row">
                                <div class="col extending">
                                    <asp:TextBox Text='<%# Bind("Email") %>' type="email"
                                        runat="server" ID="EmailTextBox"
                                        Placeholder="valid email address"
                                        AutoCompleteType="Email"
                                        CssClass="bottom-padded" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionEmailValidator" runat="server"
                                        ErrorMessage="The email address must be valid."
                                        ControlToValidate="EmailTextBox"
                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        Display="None"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col extending">
                                    <asp:Label ID="Label1" runat="server" Text="Member Type:"
                                        AssociatedControlId="MemberTypesDropDown"></asp:Label><br />
                                    <asp:DropDownList ID="MemberTypesDropDown" runat="server"
                                        AutoPostBack="True"
                                        DataSourceID="MemberTypesDropDownODS"
                                        DataTextField="Value" DataValueField="Key"
                                        CssClass="bottom-padded">
                                    </asp:DropDownList><br />
                                    <asp:TextBox type="number"
                                        ID="TypeIdTextBox" runat="server"
                                        Placeholder="Employee ID"></asp:TextBox>
                                    <asp:CompareValidator ID="NumberTypeIdValidator" runat="server"
                                        ErrorMessage="The ID must be a whole number."
                                        ControlToValidate="TypeIdTextBox"
                                        Operator="DataTypeCheck" Type="Integer"
                                        Display="None"></asp:CompareValidator>
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
            <p class="alert alert-info">
                When you select a member type
                to insert, all registered
                users of that type will appear
                below. Selecting a user will
                add their ID to the new member.
            </p>
            <asp:ListView ID="ContextList" runat="server"
                DataSourceID="ContextListODS"
                OnItemCommand="ContextList_ItemCommand">
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" class="contextList"><span runat="server" id="itemPlaceholder" /></div>
                    <div>
                        <asp:DataPager runat="server" ID="DataPager2">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button"
                                    ShowFirstPageButton="True"
                                    ShowLastPageButton="True"
                                    ButtonCssClass="btn"></asp:NextPreviousPagerField>
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <asp:LinkButton Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel"
                        CommandName="Select" CommandArgument='<%# Eval("Key") %>'
                        CausesValidation="False"
                        CssClass="btn btn-primary bottom-padded user-button" />
                    <br />
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <asp:LinkButton Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel"
                        CommandName="Select" CommandArgument='<%# Eval("Key") %>'
                        CausesValidation="False"
                        CssClass="btn btn-primary bottom-padded user-button" />
                    <br />
                </AlternatingItemTemplate>
                <SelectedItemTemplate>
                    <asp:LinkButton Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel"
                        CausesValidation="False" Enabled="false"
                        CssClass="btn btn-outline-primary bottom-padded user-button" />
                    <br />
                </SelectedItemTemplate>
                <EmptyDataTemplate>
                    <span>There are no users of this type.</span>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </div>

    <h1 class="text-center">Roles</h1>
    <asp:ValidationSummary ID="ValidationSummaryRoles" runat="server" ValidationGroup="Role" CssClass="alert alert-danger" />
    <div class="row">
        <div class="col-md-6">
            <div class="container">
                <asp:ListView ID="RolesList" runat="server" DataSourceID="RolesODS" InsertItemPosition="LastItem">
                    <LayoutTemplate>
                        <table runat="server" id="itemPlaceholderContainer" border="0">
                            <tr runat="server">
                                <th runat="server">Actions</th>
                                <th runat="server">Role</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                            <tr runat="server">
                                <td runat="server">
                                    <asp:DataPager runat="server" ID="RoleDataPager">
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
                                <asp:HiddenField ID="RoleRowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RoleRemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary">
                                <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                Remove</asp:LinkButton>
                                <asp:CheckBox ID="RoleSelectCheckbox" runat="server"
                                    AutoPostBack="True" />
                                <asp:LinkButton ID="RoleSelectButton" runat="server"
                                    CommandName="Select">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("RoleName") %>' runat="server" ID="RoleLabel" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <SelectedItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="RoleRowIndex" Value="<%# Container.DataItemIndex %>" runat="server" />
                                <asp:LinkButton ID="RoleRemoveButton" runat="server" CommandName="Delete"
                                    CssClass="btn btn-primary">
                                <img src="../Content/Images/trashcanIcon.svg" alt="remove" width="16" height="16" />
                                Remove</asp:LinkButton>
                                <asp:CheckBox ID="RoleSelectCheckbox" runat="server"
                                    AutoPostBack="True"
                                    Enabled="false" />
                                <asp:LinkButton ID="RoleSelectButton" runat="server"
                                    CommandName="Select"
                                    Enabled="false">Select</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("RoleName") %>' runat="server" ID="RoleLabel" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                    <InsertItemTemplate>
                        <tr>
                            <td>
                                <asp:LinkButton ID="RoleInsertButton" runat="server" CommandName="Insert"
                                    CssClass="btn btn-primary"
                                    ValidationGroup="Role">
                                    <img src="../Content/Images/pageIcon.svg" alt="remove" width="16" height="16" />
                                    Insert</asp:LinkButton>
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel"
                                    CssClass="btn btn-primary">
                                    <img src="../Content/Images/xIcon.svg" alt="cancel" width="16" height="16" />
                                    Cancel</asp:LinkButton>
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("RoleName") %>' runat="server" ID="RoleNameTxtBox"
                                    Placeholder="Role Name" />
                                <asp:RequiredFieldValidator ID="RoleNameRequiredValidator" runat="server"
                                    ErrorMessage="A role name is required."
                                    ControlToValidate="RoleNameTxtBox"
                                    Display="None"
                                    ValidationGroup="Role"></asp:RequiredFieldValidator>
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
    </div>

    <asp:ObjectDataSource ID="MembersODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="ListAllUsers"
        TypeName="BikesSystem.BLL.Security.UserManager"
        DataObjectTypeName="BikesData.Entities.Security.UserProfile"
        DeleteMethod="ForceRemoveUser"
        InsertMethod="AddUser"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="MemberTypesDropDownODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetMemberTypes"
        TypeName="BikesSystem.BLL.Security.UserManager"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ContextListODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetPeopleByType"
        TypeName="BikesSystem.BLL.Security.UserManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$MainContent$MembersList$ctrl10$MemberTypesDropDown"
                PropertyName="SelectedValue" DefaultValue=" "
                Name="userType" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="RolesODS" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="ListAllRoles"
        TypeName="BikesSystem.BLL.Security.RoleManager" DataObjectTypeName="BikesData.Entities.Security.RoleProfile" InsertMethod="AddRole"></asp:ObjectDataSource>
</asp:Content>

