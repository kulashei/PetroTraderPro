Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class supDrCr
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

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate

        EmptyAdd()

        'If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        'If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        '  Debit/Credit Supplier Account
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=23"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID23Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID23Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID23Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID23View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID23Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID23Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID23Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID23View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID23View") = False Then cmdViewReport.ClientEnabled = False

    End Sub

    Private Sub EmptyAdd()
        On Error Resume Next


        cboSupplierAdd.SelectedIndex = -1
        cboTransactionTypeAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        txtTransactionNumberAdd.Text = ""
        txtAmountPaidAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()

        SqlDataSourceTransaction.DataBind()
        cboSupplierAdd.DataBind()


    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next


        txtTransactionIDEdit.Text = 0
        cboSupplierEdit.SelectedIndex = -1
        cboTransactionTypeEdit.SelectedIndex = -1
        txtDetailsEdit.Text = ""
        txtTransactionNumberEdit.Text = ""
        txtAmountPaidEdit.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()



        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()

        SqlDataSourceTransaction.DataBind()
        cboSupplierEdit.DataBind()


    End Sub

    Private Sub EmptyEdit1()
        On Error Resume Next


        txtTransactionIDEdit.Text = 0
        cboSupplierEdit.SelectedIndex = -1
        cboTransactionTypeEdit.SelectedIndex = -1
        txtDetailsEdit.Text = ""
        txtTransactionNumberEdit.Text = ""
        txtAmountPaidEdit.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()



        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""


    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSupplierID As Integer = 0, intTransactionTypeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value
            If cboTransactionTypeAdd.Text <> "" Then intTransactionTypeID = cboTransactionTypeAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_SupplierDebitCredit_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SupplierID", intSupplierID))
                .Add(New SqlParameter("@Details", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionTypeID", intTransactionTypeID))
                .Add(New SqlParameter("@TransactionNumber", txtTransactionNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountPaidAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Transaction Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_SupplierDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("TransactionCode").ToString
                txtViewTransactionID.Text = .Item("TransactionID").ToString
                txtViewDate.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtViewReceiptNunber.Text = .Item("TransactionNumber").ToString
                txtViewSupplier.Text = .Item("SupplierName").ToString
                txtViewSupplier.Text = .Item("SupplierName").ToString
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
        txtViewReceiptNunber.Text = ""
        txtViewSupplier.Text = ""
        txtViewDetails.Text = ""
        txtViewTransactionType.Text = ""
        txtViewAmountPaid.Text = 0
    End Sub



    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceTransaction.DataBind()
        GridViewTransaction.DataBind()
    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intTransactionID = 0
        If txtViewTransactionID.Text = 0 Then Exit Sub


        intTransactionID = CLng(Val(txtViewTransactionID.Text))
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_SupplierDebitCredit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit1()
            With dt.Rows(0)
                txtTransactionIDEdit.Text = .Item("TransactionID").ToString
                dtpTransactionDateEdit.Value = CDate(VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy"))
                cboSupplierEdit.Value = CInt(.Item("SupplierID").ToString)
                cboTransactionTypeEdit.Value = CInt(.Item("TransactionTypeID").ToString)
                cboTransactionTypeEdit.Text = (.Item("TransactionType").ToString)
                txtDetailsEdit.Text = .Item("Details").ToString
                txtTransactionNumberEdit.Text = .Item("TransactionNumber").ToString
                If CInt(.Item("TransactionTypeID").ToString) = 1 Then
                    txtAmountPaidEdit.Value = .Item("Debit").ToString
                ElseIf CInt(.Item("TransactionTypeID").ToString) = 2 Then
                    txtAmountPaidEdit.Value = .Item("Credit").ToString

                End If

            End With

            popupEditTransaction.ShowOnPageLoad = True
        End If

    End Sub


    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub

    Private Sub cmdViewReport_Click(sender As Object, e As EventArgs) Handles cmdViewReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierPayments

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierDebitCredit_RPTByDate @DateFrom='{0}',@DateTo='{1}'", txtSearchDateFrom.Text, txtSearchDateTo.Text)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupFuelReceipt.pdf")
        End Using


    End Sub

End Class