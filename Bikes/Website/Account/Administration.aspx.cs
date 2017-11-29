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

    }

    protected void MembersList_SelectedIndexChanged(object sender, EventArgs e)
    {
        RoleManager controller = new RoleManager();
        List<RoleProfile> inRoles = controller.GetUserRoles((
            MembersList.Items[MembersList.SelectedIndex].FindControl("UserId")
                as HiddenField).Value);
        foreach (ListViewDataItem item in RolesList.Items)
        {
            // TODO: Find a field in the item to identify the role (and set Checked).
            (item.FindControl("RoleSelectCheckbox") as CheckBox).Checked =
                inRoles.Any((role) =>
                    role.RoleId == (item.FindControl("role id field")
                        as HiddenField).Value);
        }
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

    
}