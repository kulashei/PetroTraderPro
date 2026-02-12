Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Public Class userProfile
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

        Call EmptyView()
        Call LoadUserProfile()
        'Call EmptyEdit()

    End Sub
    Private Sub EmptyView()
        On Error Resume Next
        lblUserIDView.Text = ""
        picPictureView.ImageUrl = ""
        lblFullNameView.Text = ""
        lblUserStatusView.Text = ""
        lblUserGroupView.Text = ""
        lblPhoneNumberView.Text = ""
    End Sub

    'Private Sub EmptyAdd()
    '        On Error Resume Next
    '        txtFirstNameAdd.Text = ""
    '        txtOtherNamesAdd.Text = ""
    '        cboGenderAdd.SelectedIndex = -1
    '        txtUserNameAdd.Text = ""
    '        cboUserGroupAdd.SelectedIndex = -1
    '        txtPhoneNumberAdd.Text = ""
    '        txtPasswordAdd.Text = ""
    '        txtConfirmPasswordAdd.Text = ""
    '        picPictureAdd.ImageUrl = ""

    '        lblErrMsgAdd.ClientVisible = False
    '        lblSuccessMsgAdd.ClientVisible = False
    '        lblErrMsgAdd.Text = ""
    '        lblSuccessMsgAdd.Text = ""

    '        txtTransactionCode.Text = GenerateTransactionCode()

    '        SqlDataSourceUsers.DataBind()
    '        GridViewUsers.DataBind()
    '    End Sub



    Protected Sub LoadUserProfile()
        Call CheckUserSession()


        Dim intUserID = 0


        intUserID = CInt(Session("UserID").ToString)


        Dim STR(0) As String
        STR(0) = "SELECT * FROM View_Users WHERE UserID=" & intUserID

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        Dim dtTempUser = dsMany(0).Tables(0)

        If dtTempUser.Rows.Count > 0 Then

            With dtTempUser.Rows(0)
                lblUserIDView.Text = .Item("UserID").ToString
                picPictureView.ImageUrl = "~/users/userpics/" & .Item("UserID") & ".jpg"
                lblFullNameView.Text = ""
                lblFullNameView.Text = .Item("FullName").ToString
                lblUserStatusView.Text = .Item("Status_Name").ToString
                lblUserGroupView.Text = .Item("UserGroup").ToString
                lblPhoneNumberView.Text = .Item("PhoneNumber").ToString
                lblOldPasswordView.Text = .Item("UserPassword").ToString

            End With
        End If


        SqlDataSourceUserSite.DataBind()
        GridViewUserSitesView.DataBind()



    End Sub

    Private Sub cmdSaveYesChangePicture_Click(sender As Object, e As EventArgs) Handles cmdSaveYesChangePicture.Click
    End Sub

    Private Sub cmdSaveYesPassword_Click(sender As Object, e As EventArgs) Handles cmdSaveYesPassword.Click
        Call CheckUserSession()
        lblErrMsgPassword.ClientVisible = False
        lblSuccessMsgPassword.ClientVisible = False
        lblErrMsgPassword.Text = ""
        lblSuccessMsgPassword.Text = ""

        If Encrypt(txtOldPassword.Text.Trim) <> lblOldPasswordView.Text Then lblErrMsgPassword.ClientVisible = True : lblErrMsgPassword.Text = ("Please Old password is incorrect") : txtOldPassword.Focus() : Exit Sub
        If Encrypt(txtPassword.Text.Trim) <> Encrypt(txtConfirmPassword.Text.Trim) Then lblErrMsgPassword.ClientVisible = True : lblErrMsgPassword.Text = ("Please Old password is incorrect") : txtOldPassword.Focus() : Exit Sub



        Try

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_User_PasswordChange"
            objCommand.CommandType = CommandType.StoredProcedure



            With objCommand.Parameters
                .Add(New SqlParameter("@UserPassword", Encrypt(txtPassword.Text.Trim)))
                .Add(New SqlParameter("@UserID", CInt(Val(lblUserIDView.Text))))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyFields()
            lblErrMsgPassword.ClientVisible = False
            lblSuccessMsgPassword.ClientVisible = True
            lblSuccessMsgPassword.Text = "User Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgPassword.ClientVisible = False
            lblErrMsgPassword.ClientVisible = True
            lblErrMsgPassword.Text = (ex.Message)
        End Try


    End Sub
End Class