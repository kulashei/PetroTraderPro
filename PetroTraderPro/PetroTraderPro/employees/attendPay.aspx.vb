Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class attendPay
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
        cboPaymentModeAdd.SelectedIndex = -1
        cboAttendantAdd.Text = ""
        txtDetailsAdd.Text = ""
        txtAmountAdd.Text = 0
        cboPaymentModeAdd.SelectedIndex = 0
        txtPaymentDetailsAdd.Text = "CASH"
        txtAmountAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        intGenReceiptType = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourcePayment.DataBind()
        cboAttendantAdd.DataBind()


        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        If Session("RoleID1") = False Then dtpPaymentDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpPaymentDateEdit.ClientEnabled = False

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
        cboAttendantAdd.DataBind()

        cboSiteAdd.SelectedIndex = -1
        cboPaymentModeAdd.SelectedIndex = -1
        cboAttendantAdd.Text = ""
        txtDetailsAdd.Text = ""
        txtAmountAdd.Text = 0
        cboPaymentModeAdd.SelectedIndex = 0
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
        cboAttendantEdit.DataBind()

        txtPaymentIDEdit.Text = 0
        cboSiteEdit.SelectedIndex = -1
        cboPaymentModeEdit.SelectedIndex = -1
        cboAttendantEdit.Text = ""
        txtDetailsEdit.Text = ""
        txtAmountEdit.Text = 0
        cboPaymentModeEdit.SelectedIndex = 0
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
    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intAttendantID As Integer = 0, intPaymentModeID As Integer = 0

        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboAttendantAdd.Text <> "" Then intAttendantID = cboAttendantAdd.Value
            If cboPaymentModeAdd.Text <> "" Then intPaymentModeID = cboPaymentModeAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendantPayments_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@Details", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@PaymentDetails", txtPaymentDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With

            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1
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

        Dim intSiteID As Integer = 0, intAttendantID As Integer = 0, intPaymentModeID As Integer = 0


        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If cboAttendantEdit.Text <> "" Then intAttendantID = cboAttendantEdit.Value
            If cboPaymentModeEdit.Text <> "" Then intPaymentModeID = cboPaymentModeEdit.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendantPayments_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PaymentID", CLng(Val(txtPaymentIDEdit.Text.Trim.ToUpper))))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@Details", txtDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("PaymentCode").ToString
                txtViewPaymentID.Text = .Item("PaymentID").ToString
                txtViewDate.Text = VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy")
                txtViewReceiptNunber.Text = .Item("PaymentReceiptNo").ToString
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewAttendant.Text = .Item("AttendantName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewPaymentMode.Text = .Item("PaymentMode").ToString
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
        txtViewPaymentMode.Text = ""
        txtViewPaymentDetails.Text = ""
        txtViewAmountPaid.Text = 0
    End Sub



    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourcePayment.DataBind()
        GridViewPayment.DataBind()
    End Sub

    'Private Sub cmdConfirmCancelYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmCancelYes.Click
    '    Call CheckUserSession()
    '    If txtViewPaymentID.Text = 0 Then Exit Sub
    '    lblErrMsgCancel.ClientVisible = False
    '    lblSuccessMsgCancel.ClientVisible = False
    '    lblErrMsgCancel.Text = ""
    '    lblSuccessMsgCancel.Text = ""



    '    Try



    '        If objConnect.State = ConnectionState.Closed Then
    '            Call ConnectDBase()
    '        End If
    '        objCommand = New SqlCommand
    '        objCommand.Connection = objConnect
    '        objCommand.CommandText = "Usp_FuelAttendantPayments_ReturnByPaymentID"
    '        objCommand.CommandType = CommandType.StoredProcedure

    '        With objCommand.Parameters
    '            .Add(New SqlParameter("@PaymentID", CLng(Val(txtViewPaymentID.Text))))
    '            .Add(New SqlParameter("@CanceledDate", VB6.Format(dtpPaymentCanceledDate.Value.Date, "dd-MMM-yyyy")))
    '            .Add(New SqlParameter("@CancelRemark", txtRetrunRemark.Text.Trim.ToUpper))
    '            .Add(New SqlParameter("@UserID", Session("UserID")))
    '        End With
    '        objCommand.ExecuteNonQuery()
    '        objCommand.Parameters.Clear()

    '        intGenReceiptType = 3
    '        PrintPaymentReceipt((txtViewTransactionCode.Text.Trim.ToUpper))

    '        lblErrMsgCancel.ClientVisible = False
    '        lblSuccessMsgCancel.ClientVisible = True
    '        lblSuccessMsgCancel.Text = "Payment Successfully Canceled"

    '        popupCancelPayment.ShowOnPageLoad = False
    '        popupView.ShowOnPageLoad = False
    '        popupAddPayment.ShowOnPageLoad = False

    '        EmptyFields()

    '    Catch ex As Exception
    '        lblSuccessMsgCancel.ClientVisible = False
    '        lblErrMsgCancel.ClientVisible = True
    '        lblErrMsgCancel.Text = (ex.Message)
    '    End Try
    'End Sub
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
        Dim report As New XtraRptAttendantPayments
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelAttendantPayments_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AttendantPayment.pdf")
        End Using


    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intPaymentID = 0
        Dim intPaymentIDTypeID = 0
        If CLng(Val(txtViewPaymentID.Text)) = 0 Then Exit Sub


        intPaymentID = CLng(Val(txtViewPaymentID.Text))
        If intPaymentID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtPaymentIDEdit.Text = .Item("PaymentID").ToString
                dtpPaymentDateEdit.Value = CDate(VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy"))
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                cboAttendantEdit.Value = CInt(.Item("AttendantID").ToString)
                txtDetailsEdit.Text = .Item("Details").ToString
                cboPaymentModeEdit.Value = CInt(.Item("PaymentModeID").ToString)
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

            Dim strQuery As String = String.Format("DELETE FROM FuelAttendantPayments WHERE PaymentID={0}", intPaymentID)
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantPayments WHERE PaymentID='{0}'", intPaymentID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtViewTransactionCode.Text = .Item("PaymentCode").ToString
                txtViewPaymentID.Text = .Item("PaymentID").ToString
                txtViewDate.Text = VB6.Format(.Item("PaymentDate").ToString, "dd-MMM-yyyy")
                txtViewReceiptNunber.Text = .Item("PaymentReceiptNo").ToString
                txtViewSite.Text = .Item("SiteName").ToString
                txtViewAttendant.Text = .Item("AttendantName").ToString
                txtViewDetails.Text = .Item("Details").ToString
                txtViewPaymentMode.Text = .Item("PaymentMode").ToString
                txtViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtViewAmountPaid.Value = .Item("Amount").ToString
                'txtViewReceiptN.Text = .Item("PaymentReceiptNo").ToString

            End With

            popupView.ShowOnPageLoad = True
        End If


    End Sub
End Class