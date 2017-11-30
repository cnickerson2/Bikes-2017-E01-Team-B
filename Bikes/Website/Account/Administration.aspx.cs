using BikesData.Entities.Security;
using BikesSystem.BLL.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_Administration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("WebsiteAdmins")) Response.Redirect("../Account/Login.aspx");
    }

    protected void MembersList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Add")
        {
            if (IsValid)
            {
                MessageUserControl.TryRun(() =>
                {
                    UserManager controller = new UserManager();
                    UserProfile user = new UserProfile();
                    ListViewItem insert = MembersList.InsertItem;
                    user.UserName = (insert.FindControl("UserNameBox") as TextBox).Text;
                    user.Email = (insert.FindControl("EmailTextBox") as TextBox).Text;
                    string type = (insert.FindControl("MemberTypesDropDown")
                        as DropDownList).SelectedValue;
                    int value = int.Parse((insert.FindControl("TypeIdTextBox")
                                as TextBox).Text);
                    typeof(UserProfile).GetProperty(type).SetValue(user,
                            value);
                    user.RoleMemberships = RolesList.Items.Where((item) =>
                        (item.FindControl("RoleSelectCheckbox") as CheckBox).Checked).Select((item) =>
                            (item.FindControl("RoleLabel") as Label).Text);
                    controller.AddUser(user);
                    MembersList.DataBind();
                });
            }
        }
    }

    protected void MembersList_SelectedIndexChanged(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            UserManager controller = new UserManager();
            List<string> inRoles = controller.GetUserRoles((
                MembersList.Items[MembersList.SelectedIndex].FindControl("UserId")
                    as HiddenField).Value);
            foreach (ListViewDataItem item in RolesList.Items)
            {
                (item.FindControl("RoleSelectCheckbox") as CheckBox).Checked =
                    inRoles.Any((role) =>
                        role == (item.FindControl("RoleLabel")
                            as Label).Text);
            }
        });
    }

    protected void MembersList_ItemCanceling(object sender, ListViewCancelEventArgs e)
    {
        foreach (ListViewDataItem item in RolesList.Items)
        {
            (item.FindControl("RoleSelectCheckbox") as CheckBox).Checked = false;
        }
    }

    protected void SelectRadio_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton radio = sender as RadioButton;
        MembersList.SelectItem(int.Parse((radio.Parent.FindControl("RowIndex")
            as HiddenField).Value));
        radio.Checked = false;
    }

    protected void ContextList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            (MembersList.InsertItem.FindControl("TypeIdTextBox") as TextBox).Text = e.CommandArgument.ToString();
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void RoleSelectCheckbox_CheckedChanged(object sender, EventArgs e)
    {
        if (MembersList.SelectedIndex == -1)
        {
            // nothing
        } else
        {
            CheckBox cb = sender as CheckBox;
            string userID = (MembersList.Items[MembersList.SelectedIndex].FindControl("UserId") as HiddenField).Value;
            string roleName = (cb.Parent.FindControl("RoleLabel") as Label).Text;
            if (cb.Checked)
            {
                (new UserManager()).AddUserToRole(userID, roleName);
            } else
            {
                (new UserManager()).RemoveUserFromRole(userID, roleName);
            }
            
        }
    }
}