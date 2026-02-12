Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class customerPay
    Inherits System.Web.UI.Page
    Private intPaymentID As Long
    Private dtSendSMS As DataTable


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

        dtpPaymentDateAdd.MaxDate = DateCurrendDate
        dtpPaymentDateAdd.Value = DateCurrendDate

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
        cboAccountAdd.SelectedIndex = -1
        cboAccountTypeAdd.SelectedIndex = -1
        GridLookupCustomersAdd.Text = ""
        txtDetailsAdd.Text = ""
        txtAmountAdd.Text = 0
        cboAccountTypeAdd.SelectedIndex = 0
        txtPaymentDetailsAdd.Text = "CASH"
        txtAmountAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        intGenReceiptType = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourcePayment.DataBind()
        GridLookupCustomersAdd.DataBind()


        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        'If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        ' Fuel Consumption
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=15"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID15Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID15Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID15Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID15View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID15Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        'If Session("RoleID15Edit") = False Then cmdEdit.ClientEnabled = False
        'If Session("RoleID15Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID15View") = False Then cmdSearcByDate.ClientEnabled = False
        'If Session("RoleID15View") = False Then cmdViewSalesReport.ClientEnabled = False

    End Sub

    Private Sub EmptyAdd()

        SqlDataSourcePayment.DataBind()
        SqlDataSourceAccountAdd.DataBind()
        GridLookupCustomersAdd.DataBind()

        cboSiteAdd.SelectedIndex = -1
        cboAccountAdd.SelectedIndex = -1
        cboAccountTypeAdd.SelectedIndex = -1
        GridLookupCustomersAdd.Text = ""
        txtDetailsAdd.Text = ""
        txtAmountAdd.Text = 0
        cboAccountTypeAdd.SelectedIndex = 0
        txtPaymentDetailsAdd.Text = "CASH"
        txtAmountAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        intGenReceiptType = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""




    End Sub

    Private Sub EmptyEdit()

        SqlDataSourcePayment.DataBind()
        SqlDataSourceAccountEdit.DataBind()
        GridLookupCustomersEdit.DataBind()

        txtPaymentIDEdit.Text = 0
        cboSiteEdit.SelectedIndex = -1
        cboAccountEdit.SelectedIndex = -1
        cboAccountTypeEdit.SelectedIndex = -1
        GridLookupCustomersEdit.Text = ""
        txtDetailsEdit.Text = ""
        txtAmountEdit.Text = 0
        cboAccountTypeEdit.SelectedIndex = 0
        txtPaymentDetailsEdit.Text = "CASH"
        txtAmountEdit.Text = 0
        intGenReceiptType = 0


        lblErrMsgEdit.ClientVisible = False
        lblSuccessMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""




    End Sub

    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
        Call LoadAccountAdd()

    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intCustomerID As Integer = 0, intAccountTypeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value
            If cboAccountTypeAdd.Text <> "" Then intAccountTypeID = cboAccountTypeAdd.Value
            If cboAccountAdd.Text <> "" Then intAccountID = cboAccountAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            'objCommand = New SqlCommand
            'objCommand.Connection = objConnect
            'objCommand.CommandText = "usp_CustomerPayments_Insert"
            'objCommand.CommandType = CommandType.StoredProcedure

            Dim da As New SqlDataAdapter("", strCon)
            da.SelectCommand.CommandText = "usp_CustomerPayments_Insert"
            da.SelectCommand.CommandType = CommandType.StoredProcedure

            With da.SelectCommand.Parameters
                .Add(New SqlParameter("@PaymentCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@Details", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@AccountTypeID", intAccountTypeID))
                .Add(New SqlParameter("@PaymentDetails", txtPaymentDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With

            dtSendSMS = New DataTable
            da.Fill(dtSendSMS)
            If dtSendSMS.Rows.Count > 0 Then
                Call SendPaySMS()

            End If

            'objCommand.ExecuteNonQuery()
            'objCommand.Parameters.Clear()
            intGenReceiptType = 1
            PrintPaymentReceipt(txtTransactionCode.Text)
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Payment Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()

        lblErrMsgEdit.ClientVisible = False
        lblSuccessMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSiteID As Integer = 0, intCustomerID As Integer = 0, intAccountTypeID As Integer = 0, intAccountID As Integer = 0


        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If GridLookupCustomersEdit.Text <> "" Then intCustomerID = GridLookupCustomersEdit.Value
            If cboAccountTypeEdit.Text <> "" Then intAccountTypeID = cboAccountTypeEdit.Value
            If cboAccountEdit.Text <> "" Then intAccountID = cboAccountEdit.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_CustomerPayments_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentID", CLng(Val(txtPaymentIDEdit.Text.Trim.ToUpper))))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@Details", txtDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@AccountTypeID", intAccountTypeID))
                .Add(New SqlParameter("@PaymentDetails", txtPaymentDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With

            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyEdit()
            EmptyView()
            SqlDataSourcePayment.DataBind()
            GridViewPayment.DataBind()
            popupEditPayment.ShowOnPageLoad = False
            popupView.ShowOnPageLoad = False


        Catch ex As Exception
            lblSuccessMsgEdit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub


    Private Sub PrintPaymentReceipt(ByVal strReceiptNumber As String)
        'On Error Resume Next
        Call CheckUserSession()
        Dim report As New XtraRptCustomerPaymentReceipt
        report.Parameters("PaymentCode").Value = strReceiptNumber
        rptViewerReceipt.OpenReport(report)
        PopupPrintReceipt.ShowOnPageLoad = True
    End Sub



    Protected Sub cmdViewPayment_Click()
        'On Error Resume Next
        Call CheckUserSession()
        intPaymentID = 0
        Dim intPaymentIDTypeID = 0
        If GridViewPayment.VisibleRowCount = 0 Then Exit Sub

        With GridViewPayment
            Dim rowIndex As Integer = .FocusedRowIndex

            intPaymentID = CLng(.GetRowValues(rowIndex, "PaymentID").ToString)
        End With
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_CustomerPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("PaymentCode").ToString
                txtViewPaymentID.Text = .Item("PaymentID").ToString
                txtViewDate.Text = VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy")
                txtViewReceiptNunber.Text = .Item("PaymentReceiptNo").ToString
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewCustomer.Text = .Item("CustomerName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewAccountType.Text = .Item("AccountType").ToString
                txtViewAccount.Text = .Item("AccountCode").ToString
                txtViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("PaymentReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtViewPaymentID.Text = 0
        txtViewReceiptNunber.Text = ""
        txtViewAccountType.Text = ""
        txtViewPaymentDetails.Text = ""
        txtViewAmountPaid.Text = 0
    End Sub

    Private Sub cmdViewReprint_Click(sender As Object, e As EventArgs) Handles cmdViewReprint.Click
        On Error Resume Next
        Call CheckUserSession()
        intGenReceiptType = 2

        PrintPaymentReceipt((txtViewTransactionCode.Text.Trim.ToUpper))
        PopupPrintReceipt.ShowOnPageLoad = True


    End Sub


    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourcePayment.DataBind()
        GridViewPayment.DataBind()
    End Sub

    Private Sub cmdConfirmCancelYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmCancelYes.Click
        Call CheckUserSession()
        If txtViewPaymentID.Text = 0 Then Exit Sub
        lblErrMsgCancel.ClientVisible = False
        lblSuccessMsgCancel.ClientVisible = False
        lblErrMsgCancel.Text = ""
        lblSuccessMsgCancel.Text = ""



        Try



            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "Usp_CustomerPayments_CancelByPaymentID"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentID", CLng(Val(txtViewPaymentID.Text))))
                .Add(New SqlParameter("@CanceledDate", VB6.Format(dtpPaymentCanceledDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@CancelRemark", txtRetrunRemark.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            intGenReceiptType = 3
            PrintPaymentReceipt((txtViewTransactionCode.Text.Trim.ToUpper))

            lblErrMsgCancel.ClientVisible = False
            lblSuccessMsgCancel.ClientVisible = True
            lblSuccessMsgCancel.Text = "Payment Successfully Canceled"

            popupCancelPayment.ShowOnPageLoad = False
            popupView.ShowOnPageLoad = False
            popupAddPayment.ShowOnPageLoad = False

            EmptyFields()

        Catch ex As Exception
            lblSuccessMsgCancel.ClientVisible = False
            lblErrMsgCancel.ClientVisible = True
            lblErrMsgCancel.Text = (ex.Message)
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

    Private Sub cmdViewReport_Click(sender As Object, e As EventArgs) Handles cmdViewReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerPayments
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_CustomerPayments_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CustomerPayment.pdf")
        End Using


    End Sub

    Private Sub SendPaySMS()
        If Len(dtSendSMS.Rows(0).Item("PhoneNumber1").ToString) = 10 Then

            Dim strMsg As String = "Dear " & dtSendSMS.Rows(0).Item("CustomerName") & ", Payment of GHS" & Microsoft.VisualBasic.Format(dtSendSMS.Rows(0).Item("Amount"), "#,##0.#0") & " has been Received. Payment Refrence: " & dtSendSMS.Rows(0).Item("PaymentReceiptNo") &
                        "  Balance: " & Microsoft.VisualBasic.Format(dtSendSMS.Rows(0).Item("Balance"), "GHS#,##0.#0") & ". Payment Date: " & Microsoft.VisualBasic.Format(dtSendSMS.Rows(0).Item("PaymentDate"), "dd-MMM-yyyy") & ". Thank You."

            Call SendMSM(strMsg, dtSendSMS.Rows(0).Item("PhoneNumber1"), Session("SMSAPI"), Session("SMSSender"))
        End If
    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intPaymentID = 0
        Dim intPaymentIDTypeID = 0
        If CLng(Val(txtViewPaymentID.Text)) = 0 Then Exit Sub


        intPaymentID = CLng(Val(txtViewPaymentID.Text))
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_CustomerPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtPaymentIDEdit.Text = .Item("PaymentID").ToString
                dtpPaymentDateEdit.Value = CDate(VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy"))
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                GridLookupCustomersEdit.Value = CInt(.Item("CustomerID").ToString)
                txtDetailsEdit.Text = .Item("Details").ToString
                cboAccountTypeEdit.Value = CInt(.Item("AccountTypeID").ToString)
                cboAccountEdit.Value = CInt(.Item("AccountID").ToString)
                txtPaymentDetailsEdit.Text = .Item("PaymentDetails").ToString
                txtAmountEdit.Value = .Item("Amount").ToString

            End With

            popupEditPayment.ShowOnPageLoad = True
        End If

    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        'On Error Resume Next
        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""


        Try
            Dim intPaymentID = 0
            intPaymentID = 0
            intPaymentID = CInt(Val(txtViewPaymentID.Text))
            If intPaymentID = 0 Then Exit Sub

            Dim strQuery As String = String.Format("DELETE FROM CustomerPayments WHERE PaymentID={0}", intPaymentID)
            ExecuteMyQuery(strQuery)


            EmptyView()
            SqlDataSourcePayment.DataBind()
            GridViewPayment.DataBind()
            popupView.ShowOnPageLoad = False
        Catch ex As Exception
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = True
            lblErrMsgView.Text = (ex.Message)
        End Try
    End Sub

    Private Sub LoadAccountAdd()
        Call CheckUserSession()
        Dim intSiteID = 0, intAccountType = 0
        If cboSiteAdd.Text = "" Then Exit Sub
        If cboAccountTypeAdd.Text <> "" Then Exit Sub

        If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
        If cboAccountTypeAdd.Text <> "" Then intAccountType = cboAccountTypeAdd.Value

        SqlDataSourceAccountAdd.DataBind()
        cboAccountAdd.DataBind()
        cboAccountAdd.SelectedIndex = -1
    End Sub
    Private Sub LoadAccountEdit()
        Call CheckUserSession()
        Dim intSiteID = 0, intAccountType = 0
        If cboSiteEdit.Text = "" Then Exit Sub
        If cboAccountTypeEdit.Text <> "" Then Exit Sub

        If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
        If cboAccountTypeEdit.Text <> "" Then intAccountType = cboAccountTypeEdit.Value

        SqlDataSourceAccountEdit.DataBind()
        cboAccountEdit.DataBind()
        cboAccountEdit.SelectedIndex = -1


    End Sub

    Private Sub cboAccountTypeAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboAccountTypeAdd.ValueChanged
        Call CheckUserSession()
        Call LoadAccountAdd()

    End Sub
    Private Sub cboAccountTypeEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboAccountTypeEdit.ValueChanged
        Call CheckUserSession()
        Call LoadAccountEdit()

    End Sub

    Private Sub cboSiteEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteEdit.ValueChanged
        Call CheckUserSession()
        Call LoadAccountEdit()
    End Sub

    Private Sub GridViewPayment_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewPayment.CustomButtonCallback
        'On Error Resume Next
        Call CheckUserSession()
        intPaymentID = 0
        Dim intPaymentIDTypeID = 0
        If GridViewPayment.VisibleRowCount = 0 Then Exit Sub

        With GridViewPayment
            Dim rowIndex As Integer = .FocusedRowIndex

            intPaymentID = CLng(.GetRowValues(rowIndex, "PaymentID").ToString)
        End With
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_CustomerPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("PaymentCode").ToString
                txtViewPaymentID.Text = .Item("PaymentID").ToString
                txtViewDate.Text = VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy")
                txtViewReceiptNunber.Text = .Item("PaymentReceiptNo").ToString
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewCustomer.Text = .Item("CustomerName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewAccountType.Text = .Item("AccountType").ToString
                txtViewAccount.Text = .Item("AccountCode").ToString
                txtViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("PaymentReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If

    End Sub
End Class