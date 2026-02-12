Imports System.Data.SqlClient
Imports DevExpress.CodeParser
Imports DevExpress.Pdf.Native.BouncyCastle.Utilities
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Imports System.Drawing.Color
Public Class users
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
        'Call EmptyEdit()
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=43"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID43Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID43Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID43Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID43View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID43Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID43Edit") = False Then cmdResetPassword.ClientEnabled = False
        If Session("RoleID43Edit") = False Then cmdChangeGroup.ClientEnabled = False
        If Session("RoleID43Edit") = False Then cmdChangeSite.ClientEnabled = False
        If Session("RoleID43Edit") = False Then cmdBlockUser.ClientEnabled = False

    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next
        txtFirstNameAdd.Text = ""
        txtOtherNamesAdd.Text = ""
        cboUserGroupAdd.SelectedIndex = -1
        txtPhoneNumberAdd.Text = ""
        txtPasswordAdd.Text = ""
        txtConfirmPasswordAdd.Text = ""
        picPictureAdd.ImageUrl = ""

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()

        SqlDataSourceUsers.DataBind()
        GridViewUsers.DataBind()
    End Sub
    Private Sub EmptyView()
        lblUserIDView.Text = ""
        picPictureView.ImageUrl = ""
        lblFullNameView.Text = ""
        lblUserGroupView.Text = ""
        lblUserGroupIDView.Text = ""
        lblPhoneNumberView.Text = ""
        lblUserStatusView.Text = ""

        lblChangeGroupCurrent.Text = ""
        lblChangeGroupCurrentID.Text = ""
        cboUserGroupChangeGroup.SelectedIndex = -1

    End Sub

    Protected Sub cmdView_Click()
        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""



        Dim intUserID = 0
        If GridViewUsers.VisibleRowCount = 0 Then Exit Sub

        With GridViewUsers
            Dim rowIndex As Integer = .FocusedRowIndex
            intUserID = CInt(.GetRowValues(rowIndex, "UserID").ToString)
        End With

        Call LoadUserInfo(intUserID)

    End Sub

    Private Sub LoadUserInfo(ByVal intUserID As Integer)

        Dim STR(0) As String
        STR(0) = "SELECT * FROM View_Users WHERE UserID=" & intUserID

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        Dim dtTempUser = dsMany(0).Tables(0)

        If dtTempUser.Rows.Count > 0 Then
            Call EmptyView()

            With dtTempUser.Rows(0)
                lblUserIDView.Text = .Item("UserID").ToString
                picPictureView.ImageUrl = "~/users/userpics/" & .Item("UserID") & ".jpg"
                lblFullNameView.Text = .Item("FullName").ToString
                lblUserGroupView.Text = .Item("UserGroup").ToString
                lblUserGroupIDView.Text = .Item("UserGroupID").ToString
                lblPhoneNumberView.Text = .Item("PhoneNumber").ToString

                lblChangeGroupCurrent.Text = .Item("UserGroup").ToString
                lblChangeGroupCurrentID.Text = .Item("UserGroupID").ToString
                lblUserStatusView.Text = .Item("Status_Name").ToString

                If Val(.Item("UserStatusID").ToString) = 1 Then
                    lblUserStatusView.ForeColor = Green

                    cmdBlockUser.Text = "Block User"
                ElseIf Val(.Item("UserStatusID").ToString) = 2 Then
                    cmdBlockUser.Text = "Unblock User"
                    lblUserStatusView.ForeColor = Red
                End If

                If (.Item("UserID").ToString) = Session("UserID").ToString Then
                    cmdBlockUser.ClientEnabled = False

                ElseIf (.Item("UserID").ToString) <> Session("UserID").ToString Then
                    cmdBlockUser.ClientEnabled = True
                End If

                    popupView.ShowOnPageLoad = True

            End With
        End If


        SqlDataSourceUserSite.DataBind()
        GridViewUserSitesView.DataBind()


        SqlDataSourceUsers.DataBind()
        GridViewUsers.DataBind()


    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please User Name Already Exist") : txtPhoneNumberAdd.Focus() : Exit Sub

        Dim intUserGroupID As Integer = 0


        Try
            If cboUserGroupAdd.Text <> "" Then intUserGroupID = cboUserGroupAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            Dim da As New SqlDataAdapter("", strCon)
            da.SelectCommand.CommandText = "usp_Users_Insert"
            da.SelectCommand.CommandType = CommandType.StoredProcedure


            With da.SelectCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserPassword", Encrypt(txtPasswordAdd.Text.Trim)))
                .Add(New SqlParameter("@FirstName", txtFirstNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@LastName", txtOtherNamesAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber", txtPhoneNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserGroupID", intUserGroupID))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            Dim dt As New DataTable
            da.Fill(dt)

            Dim ItmSiteID As Integer = 0
            Dim ItmItemID As Long = 0
            Dim strQuery = ""
            With GridViewUserSitesAdd

                For i = 0 To .VisibleRowCount - 1
                    If .Selection.IsRowSelected(i) = True Then
                        ItmSiteID = .GetRowValues(i, "SiteID").ToString

                        strQuery = strQuery & " EXEC usp_UserSites_Insert " &
                        "@TransactionCode='" & txtTransactionCode.Text.Trim.ToUpper & "'," &
                        "@SiteID=" & ItmSiteID & "," &
                        "@UserID=" & Session("UserID")
                    End If
                Next
            End With
            ExecuteMyQuery(strQuery)

            If dt.Rows.Count > 0 Then
                Dim strPicpath As String = "~/users/userpics/" & dt.Rows(0).Item("UserID") & ".jpg"

                If FileUploadPictureAdd.HasFile Then
                    FileUploadPictureAdd.SaveAs(Server.MapPath(strPicpath))
                End If
            End If


            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "User Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub


    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Users Where PhoneNumber='" & txtPhoneNumberAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Sub cmdSaveYesChangeGroup_Click(sender As Object, e As EventArgs) Handles cmdSaveYesChangeGroup.Click
        Call CheckUserSession()
        lblErrMsgChangeGroup.ClientVisible = False
        lblSuccessMsgChangeGroup.ClientVisible = False
        lblErrMsgChangeGroup.Text = ""
        lblSuccessMsgChangeGroup.Text = ""

        Dim intNewUserGroupID As Integer = -1, intUserID = -1, intOldUserGroupID = -1


        Try
            intUserID = Val(lblUserIDView.Text)
            intOldUserGroupID = Val(lblUserGroupIDView.Text)
            If intUserID = -1 Then Exit Sub
            If cboUserGroupChangeGroup.Text <> "" Then intNewUserGroupID = cboUserGroupChangeGroup.Value
            If intNewUserGroupID = intOldUserGroupID Then lblErrMsgChangeGroup.ClientVisible = True : lblErrMsgChangeGroup.Text = "The New User Group is the same the Old User Group" : Exit Sub


            Dim strQ As String = "UPDATE Users SET UserGroupID=" & intNewUserGroupID & " WHERE UserID=" & intUserID
            ExecuteMyQuery(strQ)
            LoadUserInfo(intUserID)
            popupChangeGroup.ShowOnPageLoad = False
            'lblErrMsgChangeGroup.ClientVisible = False
            'lblSuccessMsgChangeGroup.ClientVisible = True
            'lblSuccessMsgChangeGroup.Text = "User Group Successfully Changed"


        Catch ex As Exception
            lblSuccessMsgChangeGroup.ClientVisible = False
            lblErrMsgChangeGroup.ClientVisible = True
            lblErrMsgChangeGroup.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdAssignSite_Click()

        Call CheckUserSession()
        'lblMsgPopup.Text = ""
        Try

            Dim intSiteID = 0
            If GridViewUnassigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewUnassigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intUserID As Integer = -1
            intUserID = CInt(Val(lblUserIDView.Text))

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_UserSites_Insert1"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@UserID", intUserID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@UserRegID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            LoadUserInfo(intUserID)
            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewUnassigned.DataBind()
            GridViewAssigned.DataBind()

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = True
            lblSuccessMsgAssign.Text = "Successfully Assigned"


        Catch ex As Exception
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Visible = True
            lblErrMsgAssign.Text = (ex.Message)
        End Try


    End Sub

    Protected Sub cmdUnAssignSite_Click()

        Call CheckUserSession()
        'lblMsgPopup.Text = ""
        Try

            Dim intSiteID = 0
            If GridViewAssigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewAssigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intUserID As Integer = -1
            intUserID = CInt(Val(lblUserIDView.Text))

            Dim strQ As String = "DELETE FROM  UserSites WHERE UserID =" & intUserID & " And SiteID= " & intSiteID
            ExecuteMyQuery(strQ)

            LoadUserInfo(intUserID)
            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewUnassigned.DataBind()
            GridViewAssigned.DataBind()

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = True
            lblSuccessMsgAssign.Text = "Successfully Removed"


        Catch ex As Exception
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Visible = True
            lblErrMsgAssign.Text = (ex.Message)
        End Try


    End Sub

    Private Sub cmdConfirmBlockUserYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmBlockUserYes.Click
        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""

        Dim intNewUserGroupID As Integer = -1, intNewStatus = -1, intOldUserGroupID = -1


        Try
            intUserID = Val(lblUserIDView.Text)

            Dim dt = LoadData("SELECT * FROM  Users WHERE UserID=" & intUserID).Tables(0)
            If dt.Rows.Count > 0 Then
                If dt.Rows(0).Item("UserStatusID") = 1 Then
                    intNewStatus = 2
                ElseIf dt.Rows(0).Item("UserStatusID") = 2 Then
                    intNewStatus = 1
                End If
            End If


            Dim strQ As String = "UPDATE Users SET UserStatusID=" & intNewStatus & ", ModifiedBy=" & Session("UserID") & ", ModifiedDate=GETDATE() WHERE UserID=" & intUserID
            ExecuteMyQuery(strQ)
            LoadUserInfo(intUserID)
            popupView.ShowOnPageLoad = False
            lblErrMsgView.ClientVisible = False
            lblSuccessMsgView.ClientVisible = True
            lblSuccessMsgView.Text = "User Status Successfully Changed"


        Catch ex As Exception
            lblSuccessMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = True
            lblErrMsgView.Text = (ex.Message)
        End Try


    End Sub
End Class