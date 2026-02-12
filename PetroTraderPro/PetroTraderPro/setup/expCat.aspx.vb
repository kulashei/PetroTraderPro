Imports System.Data.SqlClient
Imports DevExpress.Web

Public Class expCat
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

        '   Expenditure Category
        'Session("TempUserRole") = New DataTable
        'Session("AllUserRoles").DefaultView.RowFilter = "RoleID=32"
        'Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        'Session("RoleID32Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        'Session("RoleID32Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        'Session("RoleID32Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        'Session("RoleID32View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID32Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False

    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next

        txtCategoryDescriptionAdd.Text = ""
        chkExternalAdd.CheckState = DevExpress.Web.CheckState.Unchecked
        SqlDataSourceCategory.DataBind()
        GridViewCategory.DataBind()
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtCategoryIDEdit.Text = 0
        txtCategoryDescriptionEdit.Text = ""
        chkExternalEdit.CheckState = DevExpress.Web.CheckState.Unchecked
        SqlDataSourceCategory.DataBind()
        GridViewCategory.DataBind()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Category name Already Exist") : txtCategoryDescriptionAdd.Focus() : Exit Sub

        Dim intExternalID As Integer = 0


        Try

            If chkExternalAdd.CheckState = DevExpress.Web.CheckState.Checked Then intExternalID = 1

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_ExpenditureCategory_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@CategoryDescription", txtCategoryDescriptionAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ExternalCategory", intExternalID))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Category Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()

        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim NameExist As Boolean = CheckItenNameEdit()
        If NameExist = True Then lblErrMsgEdit.ClientVisible = True : lblErrMsgEdit.Text = ("Please Category name Already Exist") : txtCategoryDescriptionEdit.Focus() : Exit Sub

        Dim intCategoryID As Integer = 0, intExternalID As Integer = 0


        Try

            If chkExternalEdit.CheckState = DevExpress.Web.CheckState.Checked Then intExternalID = 1


            intCategoryID = CInt(Val(txtCategoryIDEdit.Text))
            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_ExpenditureCategory_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@CategoryID", intCategoryID))
                .Add(New SqlParameter("@CategoryDescription", txtCategoryDescriptionEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ExternalCategory", intExternalID))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
            lblSuccessMsgEdit.ClientVisible = True
            lblSuccessMsgEdit.Text = "Category Successfully Registered"
            popupEdit.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM ExpenditureCategory Where CategoryDescription='" & txtCategoryDescriptionAdd.Text.Trim.ToUpper & "'"
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
        Dim STRQ = "SELECT * FROM ExpenditureCategory Where CategoryDescription='" & txtCategoryDescriptionEdit.Text.Trim.ToUpper & "' AND CategoryID<>" & CLng(Val(txtCategoryIDEdit.Text))
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
        lblErrMsgDelete.ClientVisible = False
        lblSuccessMsgDelete.ClientVisible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewCategory.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from ExpenditureCategory Where CategoryID={0}", CLng(Val(txtCategoryIDDelete.Text))))
            EmptyFields()
            lblErrMsgDelete.ClientVisible = False
            lblSuccessMsgDelete.ClientVisible = True
            lblSuccessMsgDelete.Text = "Category Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.ClientVisible = False
            lblErrMsgDelete.ClientVisible = True
            lblErrMsgDelete.Text = ("Categorys Can Not Be Deleted")
        End Try


    End Sub


    Private Sub GridViewCategory_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewCategory.CustomButtonInitialize
        'Session("TempUserRole") = New DataTable
        'Session("AllUserRoles").DefaultView.RowFilter = "RoleID=32"
        'Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        'Session("RoleID32Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        'Session("RoleID32Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        'Session("RoleID32Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        'Session("RoleID32View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID32Edit") = False Then
            If e.ButtonID = "cmdEdit" Then e.Enabled = False
        End If
        If Session("RoleID32Edit") = False Then
            If e.ButtonID = "cmdDelete" Then e.Enabled = False
        End If

    End Sub

    Private Sub expCat_Init(sender As Object, e As EventArgs) Handles Me.Init

        '   Expenditure Category
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=32"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID32Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID32Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID32Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID32View") = Session("TempUserRole").Rows(0).Item("CanView")

    End Sub
End Class