Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Public Class accountSetup
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
        fLoad = True
        Dim STR(1) As String
        STR(0) = "Exec Usp_GetCurrentDate"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        dsCurrentDate = dsMany(0)



        StrCurrentDate = dsCurrentDate.Tables(0).Rows(0).Item("CurrentDate")
        Dim DateCurrendDate As Date
        DateCurrendDate = CDate(StrCurrentDate)

        Call EmptyAdd()
        Call EmptyEdit()


        dtpBalanceDateAdd.MaxDate = DateCurrendDate
        dtpBalanceDateAdd.Value = DateCurrendDate



        'New Account
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=26"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID26Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID26Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID26Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID26View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID26Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID26Edit") = False Then cmdEditAccount.ClientEnabled = False
        If Session("RoleID26Delete") = False Then cmdDeleteAccount.ClientEnabled = False


    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next
        'cboSiteAdd.SelectedIndex = -1
        cboAccountTypeAdd.SelectedIndex = -1
        txtAccountCodeAdd.Text = ""
        txtAccountNameAdd.Text = ""
        txtAccountDescriptionAdd.Text = ""

        FormLayoutAdd.FindItemOrGroupByName("bankGroupAdd").ClientVisible = False
        FormLayoutAdd.FindItemOrGroupByName("MobileGroupAdd").ClientVisible = False
        'FormLayoutAdd.GetItemByName('bankGroup').SetVisible(false);
        '    FormLayoutAdd.GetItemByName('MobileGroup').SetVisible(false);

        cboBankAdd.SelectedIndex = -1
        txtBankAccountNumberAdd.Text = ""
        txtBankBranchAdd.Text = ""

        cboMobileOperatorAdd.SelectedIndex = -1
        txtMobileNumberAdd.Text = ""

        dtpBalanceDateAdd.Text = ""
        cboBalanceTypeAdd.SelectedIndex = -1
        txtBalanceAmountAdd.Value = 0


        dtpBalanceDateAdd.Text = ""
        dtpBalanceDateAdd.MaxDate = CDate(StrCurrentDate)
        dtpBalanceDateAdd.Value = CDate(StrCurrentDate)

        txtTransactionCode.Text = GenerateTransactionCode()

        SqlDataSourceAccounts.DataBind()
        GridViewAccounts.DataBind()
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtAccountIDEdit.Text = 0
        On Error Resume Next
        cboAccountTypeEdit.SelectedIndex = -1
        txtAccountCodeEdit.Text = ""
        txtAccountNameEdit.Text = ""
        txtAccountDescriptionEdit.Text = ""
        FormLayoutEdit.FindItemOrGroupByName("bankGroupEdit").ClientVisible = False
        FormLayoutEdit.FindItemOrGroupByName("MobileGroupEdit").ClientVisible = False
        cboBankEdit.SelectedIndex = -1
        txtBankAccountNumberEdit.Text = ""
        txtBankBranchEdit.Text = ""

        cboMobileOperatorEdit.SelectedIndex = -1
        txtMobileNumberEdit.Text = ""

        SqlDataSourceAccounts.DataBind()
        GridViewAccounts.DataBind()

    End Sub
    Private Sub EmptyView()
        On Error Resume Next
        txtAccountIDView.Text = 0
        On Error Resume Next
        lblAccountTypeView.Text = ""
        lblAccountCodeView.Text = ""
        lblAccountNameView.Text = ""
        lblAccountDescriptionView.Text = ""
        FormLayoutView.FindItemOrGroupByName("bankGroupView").ClientVisible = False
        FormLayoutView.FindItemOrGroupByName("MobileGroupView").ClientVisible = False
        lblBankView.Text = ""
        lblBankAccountNumberView.Text = ""
        lblBankBranchView.Text = ""

        lblMobileOperatorView.Text = ""
        lblMobileNumberView.Text = ""

        SqlDataSourceAccounts.DataBind()
        GridViewAccounts.DataBind()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""
        Dim Codexist As Boolean = CheckAccountCodeAdd()
        If Codexist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Account Code Already Exist") : txtAccountCodeAdd.Focus() : Exit Sub

        Dim intAccountTypeID As Integer = 0, intBankID As Integer = 0, intBalanceType As Integer = 0
        Dim strBankAccount = "", strBankBranch = ""

        Try
            'If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboAccountTypeAdd.Text <> "" Then intAccountTypeID = cboAccountTypeAdd.Value

            If intAccountTypeID = 1 Then
                intBankID = 0
            ElseIf intAccountTypeID = 2 Then
                If cboBankAdd.Text <> "" Then intBankID = cboBankAdd.Value
                strBankAccount = txtBankAccountNumberAdd.Text.Trim.ToUpper
                strBankBranch = txtBankBranchAdd.Text.Trim.ToUpper

            ElseIf intAccountTypeID = 3 Then
                If cboMobileOperatorAdd.Text <> "" Then intBankID = cboMobileOperatorAdd.Value
                strBankAccount = txtMobileNumberAdd.Text.Trim.ToUpper
                strBankBranch = ""
            End If
            If cboBalanceTypeAdd.Text <> "" Then intBalanceType = cboBalanceTypeAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Accounts_Insert"
            objCommand.CommandType = CommandType.StoredProcedure


            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@AccountTypeID", intAccountTypeID))
                .Add(New SqlParameter("@AccountCode", txtAccountCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@AccountName", txtAccountNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Description", txtAccountDescriptionAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@BankID", intBankID))
                .Add(New SqlParameter("@BankAccountNumber", strBankAccount))
                .Add(New SqlParameter("@BankBranch", strBankBranch))
                .Add(New SqlParameter("@BalanceDate", VB6.Format(dtpBalanceDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@BalanceTypeID", intBalanceType))
                .Add(New SqlParameter("@OpeningBalance", txtBalanceAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            Dim ItmSiteID As Integer = 0
            Dim ItmItemID As Long = 0
            Dim strQuery = ""
            If GridViewAccountSiteAdd.VisibleRowCount > 0 Then

                With GridViewAccountSiteAdd

                    For i = 0 To .VisibleRowCount - 1
                        If .Selection.IsRowSelected(i) = True Then
                            ItmSiteID = .GetRowValues(i, "SiteID").ToString

                            strQuery = strQuery & " EXEC usp_AccountSite_Insert " &
                            "@TransactionCode='" & txtTransactionCode.Text.Trim.ToUpper & "'," &
                            "@SiteID=" & ItmSiteID & "," &
                            "@UserID=" & Session("UserID")
                        End If
                    Next
                End With
                ExecuteMyQuery(strQuery)
            End If

            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Account Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()

        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim CodeExist As Boolean = CheckAccountCodeEdit()
        If CodeExist = True Then lblErrMsgEdit.ClientVisible = True : lblErrMsgEdit.Text = ("Please Account Code Already Exist") : txtAccountCodeEdit.Focus() : Exit Sub



        Dim intAccountID As Integer = 0, intAccountTypeID As Integer = 0, intBankID As Integer = 0, intBalanceType As Integer = 0
        Dim strBankAccount = "", strBankBranch = ""


        Try
            If cboAccountTypeEdit.Text <> "" Then intAccountTypeID = cboAccountTypeEdit.Value

            If intAccountTypeID = 1 Then
                intBankID = 0
            ElseIf intAccountTypeID = 2 Then
                If cboBankEdit.Text <> "" Then intBankID = cboBankEdit.Value
                strBankAccount = txtBankAccountNumberEdit.Text.Trim.ToUpper
                strBankBranch = txtBankBranchEdit.Text.Trim.ToUpper

            ElseIf intAccountTypeID = 3 Then
                If cboMobileOperatorEdit.Text <> "" Then intBankID = cboMobileOperatorEdit.Value
                strBankAccount = txtMobileNumberEdit.Text.Trim.ToUpper
                strBankBranch = ""

            End If

            intAccountID = CInt(Val(txtAccountIDEdit.Text))

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Accounts_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@AccountTypeID", intAccountTypeID))
                .Add(New SqlParameter("@AccountCode", txtAccountCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@AccountName", txtAccountNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Description", txtAccountDescriptionEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@BankID", intBankID))
                .Add(New SqlParameter("@BankAccountNumber", strBankAccount))
                .Add(New SqlParameter("@BankBranch", strBankBranch))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
            lblSuccessMsgEdit.ClientVisible = True
            lblSuccessMsgEdit.Text = "Account Successfully Registered"
            popupEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblErrMsgEdit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub


    Private Function CheckAccountCodeAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Accounts Where AccountCode='" & txtAccountCodeAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Function CheckAccountCodeEdit() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Accounts Where AccountCode='" & txtAccountCodeEdit.Text.Trim.ToUpper & "' AND AccountID<>" & CLng(Val(txtAccountIDEdit.Text))
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function
    Protected Sub cmdView_Click()
        Call CheckUserSession()
        Dim intAccountID = 0
        Dim intAccountIDTypeID = 0
        If GridViewAccounts.VisibleRowCount = 0 Then Exit Sub

        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""

        With GridViewAccounts
            Dim rowIndex As Integer = .FocusedRowIndex

            intAccountID = CLng(.GetRowValues(rowIndex, "AccountID").ToString)
        End With
        If intAccountID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Accounts WHERE AccountID='{0}'", intAccountID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtAccountIDView.Text = .Item("AccountID").ToString
                lblAccountCodeView.Text = .Item("AccountCode").ToString
                lblAccountNameView.Text = .Item("AccountName").ToString
                lblAccountTypeView.Text = .Item("AccountType").ToString
                lblAccountDescriptionView.Text = .Item("Description").ToString
                lblBankView.Text = .Item("BankName").ToString
                lblBankAccountNumberView.Text = .Item("BankAccountNumber").ToString
                lblBankBranchView.Text = .Item("BankBranch").ToString

                lblMobileOperatorView.Text = CInt(Val(.Item("BankName").ToString))
                lblMobileNumberView.Text = .Item("BankAccountNumber").ToString

                Dim intAccountType As Integer = .Item("AccountTypeID").ToString
                If intAccountType = 1 Then
                    FormLayoutView.FindItemOrGroupByName("bankGroupView").ClientVisible = False
                    FormLayoutView.FindItemOrGroupByName("MobileGroupView").ClientVisible = False

                ElseIf intAccountType = 2 Then
                    FormLayoutView.FindItemOrGroupByName("bankGroupView").ClientVisible = True
                    FormLayoutView.FindItemOrGroupByName("MobileGroupView").ClientVisible = False
                ElseIf intAccountType = 3 Then
                    FormLayoutView.FindItemOrGroupByName("bankGroupView").ClientVisible = False
                    FormLayoutView.FindItemOrGroupByName("MobileGroupView").ClientVisible = True
                End If
            End With


            popupView.ShowOnPageLoad = True
        End If



    End Sub

    Protected Sub cmdDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdDeleteYes.Click
        Call CheckUserSession()
        lblErrMsgDelete.ClientVisible = False
        lblSuccessMsgDelete.ClientVisible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewAccounts.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from Accounts Where AccountID={0}", CLng(Val(txtAccountIDDelete.Text))))
            EmptyFields()
            lblErrMsgDelete.ClientVisible = False
            lblSuccessMsgDelete.ClientVisible = True
            lblSuccessMsgDelete.Text = "Account Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.ClientVisible = False
            lblErrMsgDelete.ClientVisible = True
            lblErrMsgDelete.Text = ("Accounts Can Not Be Deleted")
        End Try


    End Sub


    Private Sub cmdEditAccount_Click(sender As Object, e As EventArgs) Handles cmdEditAccount.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intAccountID = 0

        lblErrMsgEdit.ClientVisible = False
        lblSuccessMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        intAccountID = CLng(Val(txtAccountIDView.Text))
        If intAccountID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Accounts WHERE AccountID='{0}'", intAccountID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtAccountIDEdit.Text = .Item("AccountID").ToString
                txtAccountCodeEdit.Text = .Item("AccountCode").ToString
                txtAccountNameEdit.Text = .Item("AccountName").ToString
                cboAccountTypeEdit.Value = CInt(Val(.Item("AccountTypeID").ToString))
                txtAccountDescriptionEdit.Text = .Item("Description").ToString
                cboBankEdit.Value = CInt(Val(.Item("BankID").ToString))
                txtBankAccountNumberEdit.Text = .Item("BankAccountNumber").ToString
                txtBankBranchEdit.Text = .Item("BankBranch").ToString

                cboMobileOperatorEdit.SelectedIndex = CInt(Val(.Item("BankID").ToString))
                txtMobileNumberEdit.Text = .Item("BankAccountNumber").ToString


                Dim intAccountType As Integer = .Item("AccountTypeID").ToString
                If intAccountType = 1 Then
                    FormLayoutEdit.FindItemOrGroupByName("bankGroupEdit").ClientVisible = False
                    FormLayoutEdit.FindItemOrGroupByName("MobileGroupEdit").ClientVisible = False

                ElseIf intAccountType = 2 Then
                    FormLayoutEdit.FindItemOrGroupByName("bankGroupEdit").ClientVisible = True
                    FormLayoutEdit.FindItemOrGroupByName("MobileGroupEdit").ClientVisible = False
                ElseIf intAccountType = 3 Then
                    FormLayoutEdit.FindItemOrGroupByName("bankGroupEdit").ClientVisible = False
                    FormLayoutEdit.FindItemOrGroupByName("MobileGroupEdit").ClientVisible = True
                End If
            End With

            popupEdit.ShowOnPageLoad = True
        End If


    End Sub

    Protected Sub cmdAssignSite_Click()

        Call CheckUserSession()
        'lblMsgPopup.Text = ""
        Try

            Dim intSiteID = 0
            If GridViewSiteUnassigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewSiteUnassigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intAccountID As Integer = -1
            intAccountID = CInt(Val(txtAccountIDView.Text))

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountSite_Insert1"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewSiteUnassigned.DataBind()
            GridViewSiteAssigned.DataBind()
            GridViewAccountSiteView.DataBind()

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
            If GridViewSiteAssigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewSiteAssigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intAccountID As Integer = -1
            intAccountID = CInt(Val(txtAccountIDView.Text))

            Dim strQ As String = "DELETE FROM  AccountSite WHERE AccountID =" & intAccountID & " And SiteID= " & intSiteID
            ExecuteMyQuery(strQ)

            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewSiteUnassigned.DataBind()
            GridViewSiteAssigned.DataBind()
            GridViewAccountSiteView.DataBind()

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = True
            lblSuccessMsgAssign.Text = "Successfully Removed"


        Catch ex As Exception
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Visible = True
            lblErrMsgAssign.Text = (ex.Message)
        End Try


    End Sub

End Class