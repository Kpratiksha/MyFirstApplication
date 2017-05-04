<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="FormsAuthAd.LoginPage" %>
<%@ Import Namespace="System.Security.Principal" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="Form1" method="post" runat="server">
      <asp:Label ID="lblName" runat="server" /> <br />
      <asp:Label ID="lblAuthType" Runat="server"/>
    </form>
</body>
</html>
