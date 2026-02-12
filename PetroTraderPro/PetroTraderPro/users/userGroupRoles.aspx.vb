Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Public Class userGroupRoles
    Inherits System.Web.UI.Page
    Private dtNew As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CheckUserSession()
            EmptyFields()
        End If
    End Sub

    Private Sub CheckUserSession()
        'Session("UserID") = 0
        If IsNothing(Session("UserID")) Then
            Session.RemoveAll()
            Response.Redirect("~/SignIn.aspx", True)
        End If
    End Sub

    Private Sub EmptyFields()
        On Error Resume Next

        Call EmptyAdd()
        Call EmptyEdit()

        'If Session("RoleID1") = False Then dtpBalanceDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpBalanceDateedit.ClientEnabled = False

        '  Site Registration
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=44"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID44Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID44Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID44Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID44View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID44Add") = False Then cmdAddUserGroup.ClientEnabled = False
        'If Session("RoleID44Edit") = False Then MainMenu.Items.FindByName("Edit").ClientEnabled = False
        'If Session("RoleID40Delete") = False Then MainMenu.Items.FindByName("Delete").ClientEnabled = False


    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next

        txtUserGroupAdd.Text = ""

        SqlDataSourceUserGroups.DataBind()
        cboUserGroupRole.DataBind()
        SqlDataSourceUserGroupRole.DataBind()
        GridViewGroupRoles.DataBind()

    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        'txtSiteIDEdit.Text = 0
        'dtpRegDateEdit.Text = ""
        'dtpRegDateEdit.MaxDate = CDate(StrCurrentDate)
        'dtpRegDateEdit.Value = CDate(StrCurrentDate)

        'txtUserGroupEdit.Text = ""
        'txtSiteNameEdit.Text = ""
        'txtAddressEdit.Text = ""
        'txtCompanyEdit.Text = ""
        'txtBusinessInfoEdit.Text = ""

        'SqlDataSourceSites.DataBind()
        'GridViewSites.DataBind()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please User Group Already Exist") : txtUserGroupAdd.Focus() : Exit Sub
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteTypeID As Integer = 0, intSiteID As Integer = 0, intBalanceType As Integer = 0


        Try

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_UserGroups_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@UserGroup", txtUserGroupAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "User Group Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub


    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM UserGroups Where UserGroup='" & txtUserGroupAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Sub userGroupRoles_Init(sender As Object, e As EventArgs) Handles Me.Init
        '  Manager User Roles
        Call CheckUserSession()

        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=45"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID45Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID45Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID45Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID45View") = Session("TempUserRole").Rows(0).Item("CanView")

    End Sub

    Private Sub GridViewGroupRoles_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles GridViewGroupRoles.CommandButtonInitialize
        Call CheckUserSession()

        If Session("RoleID45Edit") = False Then
            If e.ButtonType = ColumnCommandButtonType.Edit Then e.Enabled = False
        End If
    End Sub
End Class