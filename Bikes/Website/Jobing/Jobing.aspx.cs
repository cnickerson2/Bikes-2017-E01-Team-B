﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Jobing_Jobing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("WebsiteAdmins") && !User.IsInRole("Jobing")) Response.Redirect("../Account/Login.aspx");
    }
}