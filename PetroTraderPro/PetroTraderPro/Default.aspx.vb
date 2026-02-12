Imports Microsoft.VisualBasic
Imports System
Imports System.IO

Partial Public Class [Default]
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CheckUserSession()
            txtUserID.Text = Session("UserID")
            Call EmptyFields()

            'LoadSupplierInfo()
        End If
    End Sub

    Private Sub CheckUserSession()
        ''Session("UserID") = 0
        If IsNothing(Session("UserID")) Then
            Session.RemoveAll()
            Response.Redirect("~/SignIn.aspx", True)
        End If
    End Sub

    Private Sub EmptyFields()

        Dim dtSMSAccount As DataTable
        Const n As Integer = 0
        Dim STR(n) As String
        STR(0) = "SELECT TOP(1) * FROM SMSAccount WHERE DefaultVendor=1"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, n)
        dtSMSAccount = dsMany(0).Tables(0)
        If dtSMSAccount.Rows.Count > 0 Then
            Session("SMSAPI") = dtSMSAccount.Rows(0).Item("SMSAPI")
            Session("SMSSender") = dtSMSAccount.Rows(0).Item("SMSSenderID")
        End If

        Session("RoleID1") = False

        'Change Fuel Sales Dates
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=1"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID1") = Session("TempUserRole").Rows(0).Item("CanAdd")



        'Transactions for the Previous Day
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=42"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID42") = Session("TempUserRole").Rows(0).Item("CanAdd")



    End Sub

End Class