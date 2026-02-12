Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO

Public Class supPayment
    Inherits System.Web.UI.Page
    Private intPaymentID As Long

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
        dtpPaymentDateAdd.MaxDate = CDate(StrCurrentDate)
        dtpPaymentDateAdd.Value = CDate(StrCurrentDate)

        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpSearchDateFrom.Value = CDate(StrCurrentDate)
        dtpSearchDateTo.Value = CDate(StrCurrentDate)
        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        EmptyAdd()


        'If Session("RoleID1") = False Then dtpPaymentDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpPaymentDateEdit.ClientEnabled = False

        '  Supplier Payments
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=22"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID22Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID22Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID22Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID22View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID22Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID22Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID22Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID22View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID22View") = False Then cmdViewPaymentReport.ClientEnabled = False

    End Sub

    Private Sub EmptyAdd()
        On Error Resume Next


        cboSupplierAdd.SelectedIndex = -1
        cboAccountAdd.SelectedIndex = -1
        cboPaymentModeAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        txtAmountPaidAdd.Text = 0
        cboPaymentModeAdd.SelectedIndex = -1
        txtPaymentDetailsAdd.Text = ""
        txtAmountPaidAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        intGenReceiptType = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourcePayment.DataBind()
        GridViewPayment.DataBind()

        SqlDataSourceAccount.DataBind()
        cboAccountAdd.DataBind()

        SqlDataSourceSuppliers.DataBind()
        cboSupplierAdd.DataBind()


    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next


        cboSupplierEdit.SelectedIndex = -1
        cboAccountEdit.SelectedIndex = -1
        cboPaymentModeEdit.SelectedIndex = -1
        txtDetailsEdit.Text = ""
        txtAmountPaidEdit.Text = 0
        cboPaymentModeEdit.SelectedIndex = -1
        txtPaymentDetailsEdit.Text = ""
        txtAmountPaidEdit.Text = 0


        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        SqlDataSourcePayment.DataBind()
        GridViewPayment.DataBind()

        SqlDataSourceAccount.DataBind()
        cboAccountEdit.DataBind()

        SqlDataSourceSuppliers.DataBind()
        cboSupplierEdit.DataBind()


    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSupplierID As Integer = 0, intPaymentModeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value
            If cboPaymentModeAdd.Text <> "" Then intPaymentModeID = cboPaymentModeAdd.Value
            If cboAccountAdd.Text <> "" Then intAccountID = cboAccountAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_SupplierPayments_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SupplierID", intSupplierID))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@PaymentDetails", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionNumber", txtPaymentDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountPaidAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyAdd()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Payment Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()

        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSupplierID As Integer = 0, intPaymentModeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSupplierEdit.Text <> "" Then intSupplierID = cboSupplierEdit.Value
            If cboPaymentModeEdit.Text <> "" Then intPaymentModeID = cboPaymentModeEdit.Value
            If cboAccountEdit.Text <> "" Then intAccountID = cboAccountEdit.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_SupplierPayments_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentID", CLng(Val(txtPaymentIDEdit.Text.Trim.ToUpper.ToString))))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SupplierID", intSupplierID))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@PaymentDetails", txtDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionNumber", txtPaymentDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountPaidEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyEdit()
            EmptyView()
            popupEditPayment.ShowOnPageLoad = False
            popupView.ShowOnPageLoad = False



        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub


    Protected Sub cmdViewPayment_Click()
        'On Error Resume Next
        Call CheckUserSession()
        intPaymentID = 0
        If GridViewPayment.VisibleRowCount = 0 Then Exit Sub

        With GridViewPayment
            Dim rowIndex As Integer = .FocusedRowIndex

            intPaymentID = CLng(.GetRowValues(rowIndex, "PaymentID").ToString)
        End With
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_SupplierPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("PaymentCode").ToString
                txtViewPaymentID.Text = .Item("PaymentID").ToString
                txtViewDate.Text = VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy")
                txtViewSupplier.Text = .Item("SupplierName").ToString
                txtViewPaymentMode.Text = .Item("PaymentMode").ToString
                txtViewAccount.Text = .Item("AccountCode").ToString
                txtViewDetails.Text = .Item("PaymentDetails").ToString
                txtViewPaymentDetails.Text = .Item("TransactionNumber").ToString
                txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("PaymentReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtViewPaymentID.Text = 0
        txtViewDate.Text = ""
        txtViewSupplier.Text = ""
        txtViewPaymentMode.Text = ""
        txtViewAccount.Text = ""
        txtViewDetails.Text = ""
        txtViewPaymentDetails.Text = ""
        txtViewAmountPaid.Text = 0
        txtViewTransactionCode.Text = ""
    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intPaymentID = 0
        If txtViewPaymentID.Text = 0 Then Exit Sub


        intPaymentID = CLng(Val(txtViewPaymentID.Text))
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_SupplierPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtPaymentIDEdit.Text = .Item("PaymentID").ToString
                dtpPaymentDateEdit.Value = CDate(VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy"))
                cboSupplierEdit.Value = CInt(.Item("SupplierID").ToString)
                cboAccountEdit.Value = CInt(.Item("AccountID").ToString)
                cboPaymentModeEdit.Value = CInt(.Item("PaymentModeID").ToString)
                txtDetailsEdit.Text = .Item("PaymentDetails").ToString
                txtPaymentDetailsEdit.Text = .Item("TransactionNumber").ToString
                txtAmountPaidEdit.Value = .Item("Amount").ToString

            End With

            popupEditPayment.ShowOnPageLoad = True
        End If

    End Sub


    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourcePayment.DataBind()
        GridViewPayment.DataBind()
    End Sub

    Private Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        Call CheckUserSession()
        If txtViewPaymentID.Text = 0 Then Exit Sub
        lblErrMsgDelete.ClientVisible = False
        lblSuccessMsgDelete.ClientVisible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""



        Try



            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "Usp_SupplierPayments_DeleteByPaymentID"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentID", CLng(Val(txtViewPaymentID.Text))))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            intGenReceiptType = 3

            lblErrMsgDelete.ClientVisible = False
            lblSuccessMsgDelete.ClientVisible = True
            lblSuccessMsgDelete.Text = "Payment Successfully Deleteed"

            PopupConfirmDelete.ShowOnPageLoad = False
            popupView.ShowOnPageLoad = False
            popupAddPayment.ShowOnPageLoad = False

            EmptyFields()

        Catch ex As Exception
            lblSuccessMsgDelete.ClientVisible = False
            lblErrMsgDelete.ClientVisible = True
            lblErrMsgDelete.Text = (ex.Message)
        End Try
    End Sub

    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub

    Private Sub cmdViewPaymentReport_Click(sender As Object, e As EventArgs) Handles cmdViewPaymentReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierPayments

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierPayments_RPTByDate @DateFrom='{0}',@DateTo='{1}'", txtSearchDateFrom.Text, txtSearchDateTo.Text)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupFuelReceipt.pdf")
        End Using


    End Sub


End Class