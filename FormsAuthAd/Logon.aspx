<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logon.aspx.cs" Inherits="FormsAuthAd.Logon" %>
<%@ Import Namespace="FormsAuthAd" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="Login" method="post" runat="server">
       <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
      <asp:Label ID="Label1" runat="server" >Domain:</asp:Label>
      <asp:TextBox ID="txtDomain" runat="server" ></asp:TextBox><br>    
      <asp:Label ID="Label2" runat="server" >Username:</asp:Label>
      <asp:TextBox ID=txtUsername runat="server" ></asp:TextBox><br>
      <asp:Label ID="Label3" runat="server" >Password:</asp:Label>
      <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox><br>
      <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="Login_Click"></asp:Button><br>
      <asp:Label ID="errorLabel" runat="server" ForeColor=#ff3300></asp:Label><br>
      <asp:CheckBox ID=chkPersist runat="server" Text="Persist Cookie" />
    </form>
</body>
</html>

<script runat="server">
    void Login_Click(Object sender, EventArgs e)
    {
        String adPath = "LDAP://corp.com"; //Fully-qualified Domain Name
     

        LdapAuthentication adAuth = new LdapAuthentication(adPath);
        try
        {
            if(true == adAuth.IsAuthenticated(txtDomain.Text, txtUsername.Text, txtPassword.Text))
            {
                String groups = adAuth.GetGroups();

                //Create the ticket, and add the groups.
                bool isCookiePersistent = chkPersist.Checked;
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1,  txtUsername.Text,
          DateTime.Now, DateTime.Now.AddMinutes(60), isCookiePersistent, groups);

                //Encrypt the ticket.
                String encryptedTicket = FormsAuthentication.Encrypt(authTicket);

                //Create a cookie, and then add the encrypted ticket to the cookie as data.
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                if(true == isCookiePersistent)
                    authCookie.Expires = authTicket.Expiration;

                //Add the cookie to the outgoing cookies collection.
                Response.Cookies.Add(authCookie);

                //You can redirect now.
                Response.Redirect(FormsAuthentication.GetRedirectUrl(txtUsername.Text, false));
            }
            else
            {
                errorLabel.Text = "Authentication did not succeed. Check user name and password.";
            }
        }
        catch(Exception ex)
        {
            errorLabel.Text = "Error authenticating. " + ex.Message;
        }
    }
</script>
