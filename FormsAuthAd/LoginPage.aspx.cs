using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FormsAuthAd
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblName.Text = "Hello " + Context.User.Identity.Name + ".";
            lblAuthType.Text = "You were authenticated using " + Context.User.Identity.AuthenticationType + ".";
        }
    }
}