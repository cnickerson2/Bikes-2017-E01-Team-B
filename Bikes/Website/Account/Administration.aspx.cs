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