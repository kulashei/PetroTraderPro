Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class AccountDrCr
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
        dtpTransactionDateAdd.MaxDate = CDate(StrCurrentDate)
        dtpTransactionDateAdd.Value = CDate(StrCurrentDate)

        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpSearchDateFrom.Value = CDate(StrCurrentDate)
        dtpSearchDateTo.Value = CDate(StrCurrentDate)
        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)

        'dtpAccountsDebitCreditCanceledDate.Value = CDate(StrCurrentDate)
        'dtpAccountsDebitCreditCanceledDate.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        EmptyAdd()

        'cboAccount.SelectedIndex = 0
        'SqlDataSourceAccount.SelectParameters(0) = cboAccount.Value
        SqlDataSourceAccount.DataBind()
        cboAccountAdd.DataBind()

        'If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        'If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        '  Account Debit/Credit
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=30"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID30Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID30Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID30Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID30View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID30Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        'If Session("RoleID30Edit") = False Then cmdEdit.ClientEnabled = False
        'If Session("RoleID30Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID30View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID30View") = False Then cmdPrintReport.ClientEnabled = False

    End Sub


    Private Sub EmptyAdd()

        dtpTransactionDateAdd.Value = CDate(StrCurrentDate)
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboTransactionTypeAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0

        txtTransactionCode.Text = GenerateTransactionCode()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""


    End Sub
    Private Sub EmptyAdd1()
        dtpTransactionDateAdd.Value = CDate(StrCurrentDate)
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboTransactionTypeAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0

    End Sub


    Private Sub EmptyRec()
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboTransactionTypeAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0

        txtTransactionCode.Text = GenerateTransactionCode()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()

    End Sub

    Private Sub EmptyView()

        txtAccountView.Text = ""
        txtDetailsView.Text = ""
        txtTransactionTypeView.Text = ""
        txtAmountView.Value = 0

        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.Visible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""

    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intAccountID As Integer = 0, intTransactionTypeID As Integer = 0


        Try

            If cboAccountAdd.Text <> "" Then intAccountID = cboAccountAdd.Value
            If cboTransactionTypeAdd.Text <> "" Then intTransactionTypeID = cboTransactionTypeAdd.Value

            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountsDebitCredit_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@TransactionTypeID", intTransactionTypeID))
                .Add(New SqlParameter("@Details", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "AccountsDebitCredit Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdViewTransaction_Click()
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransaction.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransaction
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountsDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtAccountView.Text = .Item("AccountCode").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtAccountView.Text = .Item("AccountCode").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtTransactionTypeView.Text = .Item("TransactionType").ToString
                txtAmountView.Value = .Item("Amount").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()
    End Sub

    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub


    Protected Sub cmdPrintReport_Click(sender As Object, e As EventArgs) Handles cmdPrintReport.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountsDebitCredit
        Dim intSiteID = 0

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountsDebitCredit_RPTByDate @DateFrom='{0}',@DateTo='{1}'", txtSearchDateFrom.Text, txtSearchDateTo.Text)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountsDebitCredit.pdf")
        End Using

    End Sub

    Private Sub GridViewTransaction_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTransaction.CustomButtonCallback
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransaction.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransaction
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountsDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtAccountView.Text = .Item("AccountCode").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtAccountView.Text = .Item("AccountCode").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtTransactionTypeView.Text = .Item("TransactionType").ToString
                txtAmountView.Value = .Item("Amount").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If

    End Sub
End Class