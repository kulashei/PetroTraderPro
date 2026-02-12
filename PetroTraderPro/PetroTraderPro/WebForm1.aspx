<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebForm1.aspx.vb" Inherits="PetroTraderPro.WebForm1" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v24.2, Version=24.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dx:BootstrapPieChart runat="server"></dx:BootstrapPieChart>
            <dx:BootstrapChart ID="BootstrapChart1" runat="server"></dx:BootstrapChart>
        </div>
    </form>
</body>
</html>
