Imports System.Data.SqlClient
Imports System.Data
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Imports System.Drawing
Imports DevExpress.XtraReports.UI
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraReports.Expressions
Public Class attendAccDrCr
    Inherits System.Web.UI.Page
    Private intTransactionID As Long

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
        Dim DateCurrendDate As Date
        DateCurrendDate = CDate(StrCurrentDate)

        If Session("RoleID42") = True Then
            DateCurrendDate = DateAdd(DateInterval.Day, -1, DateCurrendDate)
        End If

        dtpTransactionDate.MaxDate = DateCurrendDate
        dtpTransactionDate.Value = DateCurrendDate

        'dtpSalesDateEdit.MaxDate = DateCurrendDate
        'dtpSalesDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        cboSiteAdd.SelectedIndex = -1
        cboTransactionType.SelectedIndex = -1
        cboAttendantAdd.Text = ""
        txtDetails.Text = ""
        txtAmountAdd.Text = 0
        txtAmountAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        intGenReceiptType = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceTransaction.DataBind()
        cboAttendantAdd.DataBind()


        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteAddEdit.Items.Count = 1 Then cboSiteAddEdit.SelectedIndex = 0

        If Session("RoleID1") = False Then dtpTransactionDate.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        ' Fuel Consumption
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=16"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID16Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID16Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID16Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID16View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID16Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        'If Session("RoleID16Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID16Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID16View") = False Then cmdSearcByDate.ClientEnabled = False

    End Sub

    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intAttendantID As Integer = 0, intTransactionTypeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboAttendantAdd.Text <> "" Then intAttendantID = cboAttendantAdd.Value
            If cboTransactionType.Text <> "" Then intTransactionTypeID = cboTransactionType.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendantAccountDebitCredit_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@Details", txtDetails.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionTypeID", intTransactionTypeID))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Transaction Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub






    Protected Sub cmdViewTransaction_Click()
        'On Error Resume Next
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransaction.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransaction
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantAccountDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("TransactionCode").ToString
                txtViewTransactionID.Text = .Item("TransactionID").ToString
                txtViewDate.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewAttendant.Text = .Item("AttendantName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewTransactionType.Text = .Item("TransactionType").ToString
                If CInt(.Item("TransactionTypeID").ToString) = 1 Then
                    txtViewAmountPaid.Value = .Item("Debit").ToString
                ElseIf CInt(.Item("TransactionTypeID").ToString) = 2 Then
                    txtViewAmountPaid.Value = .Item("Credit").ToString
                End If

                'txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("TransactionReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtViewTransactionID.Text = 0
        txtViewTransactionCode.Text = ""
        txtViewDate.Text = ""
        txtViewAttendant.Text = ""
        txtViewDetails.Text = ""
        txtViewTransactionType.Text = ""
        txtViewAmountPaid.Text = 0
    End Sub



    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        'On Error Resume Next
        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""


        Try
            Dim intTransactionID = 0
            intTransactionID = 0
            intTransactionID = CInt(Val(txtViewTransactionID.Text))
            If intTransactionID = 0 Then Exit Sub

            Dim strQuery As String = String.Format("DELETE FROM FuelAttendantAccountDebitCredit WHERE TransactionID={0}", intTransactionID)
            ExecuteMyQuery(strQuery)


            EmptyView()
            SqlDataSourceTransaction.DataBind()
            GridViewTransaction.DataBind()
            popupView.ShowOnPageLoad = False
        Catch ex As Exception
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = True
            lblErrMsgView.Text = (ex.Message)
        End Try
    End Sub


    Private Sub GridViewTransaction_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTransaction.CustomButtonCallback
        'On Error Resume Next
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransaction.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransaction
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantAccountDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("TransactionCode").ToString
                txtViewTransactionID.Text = .Item("TransactionID").ToString
                txtViewDate.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewAttendant.Text = .Item("AttendantName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewTransactionType.Text = .Item("TransactionType").ToString
                If CInt(.Item("TransactionTypeID").ToString) = 1 Then
                    txtViewAmountPaid.Value = .Item("Debit").ToString
                ElseIf CInt(.Item("TransactionTypeID").ToString) = 2 Then
                    txtViewAmountPaid.Value = .Item("Credit").ToString
                End If

                'txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("TransactionReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If


    End Sub
End Class