Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Public Class siteSetup
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
        Dim STR(0) As String
        STR(0) = "Exec Usp_GetCurrentDate"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        dsCurrentDate = dsMany(0)

        StrCurrentDate = dsCurrentDate.Tables(0).Rows(0).Item("CurrentDate")

        Call EmptyAdd()
        Call EmptyEdit()

        'If Session("RoleID1") = False Then dtpBalanceDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpBalanceDateedit.ClientEnabled = False

        '  Site Registration
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=40"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID40Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID40Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID40Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID40View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID40Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID40Edit") = False Then MainMenu.Items.FindByName("Edit").ClientEnabled = False
        If Session("RoleID40Delete") = False Then MainMenu.Items.FindByName("Delete").ClientEnabled = False


    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next
        dtpRegDateAdd.Text = ""
        dtpRegDateAdd.MaxDate = CDate(StrCurrentDate)
        dtpRegDateAdd.Value = CDate(StrCurrentDate)

        txtSiteCodeAdd.Text = ""
        txtSiteNameAdd.Text = ""
        txtAddressAdd.Text = ""
        txtCompanyAdd.Text = ""
        txtBusinessInfoAdd.Text = ""

        SqlDataSourceSites.DataBind()
        GridViewSites.DataBind()
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtSiteIDEdit.Text = 0
        dtpRegDateEdit.Text = ""
        dtpRegDateEdit.MaxDate = CDate(StrCurrentDate)
        dtpRegDateEdit.Value = CDate(StrCurrentDate)

        txtSiteCodeEdit.Text = ""
        txtSiteNameEdit.Text = ""
        txtAddressEdit.Text = ""
        txtCompanyEdit.Text = ""
        txtBusinessInfoEdit.Text = ""

        SqlDataSourceSites.DataBind()
        GridViewSites.DataBind()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Site name Already Exist") : txtSiteNameAdd.Focus() : Exit Sub
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
            objCommand.CommandText = "usp_Sites_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@RegDate", VB6.Format(dtpRegDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteCode", txtSiteCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SiteName", txtSiteNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CompanyName", txtCompanyAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CompanyAddress", txtAddressAdd.Text.Trim))
                .Add(New SqlParameter("@BusinessInfo", txtBusinessInfoAdd.Text.Trim))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Site Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameEdit()
        If NameExist = True Then lblErrMsgEdit.ClientVisible = true : lblErrMsgEdit.Text = ("Please Site name Already Exist") : txtSiteNameEdit.Focus() : Exit Sub

        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSiteID As Integer = 0


        Try

            intSiteID = CInt(Val(txtSiteIDEdit.Text))
            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Sites_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@RegDate", VB6.Format(dtpRegDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteCode", txtSiteCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SiteName", txtSiteNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CompanyName", txtCompanyEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CompanyAddress", txtAddressEdit.Text.Trim))
                .Add(New SqlParameter("@BusinessInfo", txtBusinessInfoEdit.Text.Trim))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
           lblErrMsgedit.ClientVisible = true
            lblSuccessMsgEdit.Text = "Site Successfully Registered"
            popupEdit.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Sites Where SiteName='" & txtSiteNameAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Function CheckItenNameEdit() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Sites Where SiteName='" & txtSiteNameEdit.Text.Trim.ToUpper & "' AND SiteID<>" & CLng(Val(txtSiteIDEdit.Text))
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Protected Sub cmdDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdDeleteYes.Click
        Call CheckUserSession()
        lblErrMsgDelete.Visible = False
        lblSuccessMsgDelete.Visible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewSites.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from Sites Where SiteID={0}", CLng(Val(txtSiteIDDelete.Text))))
            EmptyFields()
            lblErrMsgDelete.Visible = False
            lblSuccessMsgDelete.Visible = True
            lblSuccessMsgDelete.Text = "Site Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.Visible = False
            lblErrMsgDelete.Visible = True
            lblErrMsgDelete.Text = ("Sites Can Not Be Deleted")
        End Try


    End Sub


End Class