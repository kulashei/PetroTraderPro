Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class AccountDepositSales
    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intTransactionID As Long

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
        dtpTransactionDateAdd.MaxDate = DateCurrendDate
        dtpTransactionDateAdd.Value = DateCurrendDate

        dtpTransactionDateEdit.MaxDate = DateCurrendDate
        dtpTransactionDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        If Session("RoleID42") = True Then
            DateCurrendDate = DateAdd(DateInterval.Day, -1, DateCurrendDate)
        End If



        dtpSalesDateAdd.MaxDate = DateCurrendDate
        dtpSalesDateAdd.Value = DateCurrendDate

        dtpSalesDateEdit.MaxDate = DateCurrendDate
        dtpSalesDateEdit.Value = DateCurrendDate



        SqlDataSourceSites.DataBind()
        SqlDataSourceSearchSite.DataBind()
        SqlDataSourceAccountAdd.DataBind()
        SqlDataSourceAccountEdit.DataBind()
        SqlDataSourceDeposit.DataBind()

        cboSiteAdd.DataBind()
        cboSiteEdit.DataBind()
        cboSiteSearch.DataBind()
        cboAccountAdd.DataBind()
        cboAccountEdit.DataBind()
        GridViewDeposit.DataBind()

        cboSiteAdd.SelectedIndex = -1
        cboSiteEdit.SelectedIndex = -1
        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0


        'cboSite.SelectedIndex = 0
        'SqlDataSourceAccount.SelectParameters(0) = cboSite.Value

        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0
        If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value
        EmptyAdd1()



        If Session("RoleID1") = False Then dtpTransactionDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpTransactionDateEdit.ClientEnabled = False

        '  Account Deposits(Sales)
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=27"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID27Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID27Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID27Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID27View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID27Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID27Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID27Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID27View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID27View") = False Then cmdViewDepositReport.ClientEnabled = False
        SqlDataSourceDeposit.DataBind()
        GridViewDeposit.DataBind()

    End Sub


    Private Sub EmptyAdd()

        dtpTransactionDateAdd.Value = CDate(StrCurrentDate)
        dtpSalesDateAdd.Value = CDate(StrCurrentDate)
        cboSiteAdd.SelectedIndex = -1
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboPaymentModeAdd.SelectedIndex = -1
        txtTransactionNumberAdd.Text = ""
        txtPaidByAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()

    End Sub
    Private Sub EmptyAdd1()

        dtpSalesDateAdd.Text = ""
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboPaymentModeAdd.SelectedIndex = -1
        txtTransactionNumberAdd.Text = ""
        txtPaidByAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()

    End Sub

    Private Sub EmptyAdd2()
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboPaymentModeAdd.SelectedIndex = -1
        txtTransactionNumberAdd.Text = ""
        txtPaidByAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        lblErrMsgGen.Text = ""
    End Sub

    Private Sub EmptyRec()
        cboSiteAdd.SelectedIndex = -1
        cboAccountAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        cboPaymentModeAdd.SelectedIndex = -1
        txtTransactionNumberAdd.Text = ""
        txtPaidByAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()
        SqlDataSourceDeposit.DataBind()
        GridViewDeposit.DataBind()

    End Sub

    Private Sub EmptyView()

        txtTransactionIDView.Text = 0
        txtTransactionDateView.Text = ""
        txtSalesDateView.Text = ""
        txtSiteNameView.Text = ""
        txtAccountView.Text = ""
        txtDetailsView.Text = ""
        txtPaymentModeView.Text = ""
        txtTransactionNumberView.Text = ""
        txtPaidByView.Text = ""
        txtAmountView.Value = 0

        txtAmountView.Value = 0
    End Sub

    Private Sub EmptyEdit()

        dtpSalesDateEdit.Value = CDate(StrCurrentDate)
        cboSiteEdit.SelectedIndex = -1
        cboAccountEdit.SelectedIndex = -1
        txtDetailsEdit.Text = ""
        cboPaymentModeEdit.SelectedIndex = -1
        txtTransactionNumberEdit.Text = ""
        txtPaidByEdit.Text = ""
        txtAmountEdit.Value = 0


        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intAccountID As Integer = 0, intPaymentModeID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboAccountAdd.Text <> "" Then intAccountID = cboAccountAdd.Value
            If cboPaymentModeAdd.Text <> "" Then intPaymentModeID = cboPaymentModeAdd.Value

            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountDepositSales_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@TransactionDetails", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@PaidBy", txtPaidByAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ChequeNo", txtTransactionNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Account Deposit Successfully Registered"


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

        Dim intSiteID As Integer = 0, intAccountID As Integer = 0, intPaymentModeID As Integer = 0


        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If cboAccountEdit.Text <> "" Then intAccountID = cboAccountEdit.Value
            If cboPaymentModeEdit.Text <> "" Then intPaymentModeID = cboPaymentModeEdit.Value

            'txtNetQuantityEdit.Value = (NetQty)
            'txtAmountEdit.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountDepositSales_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionID", CLng(Val(txtTransactionIDEdit.Text))))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AccountID", intAccountID))
                .Add(New SqlParameter("@TransactionDetails", txtDetailsEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@PaidBy", txtPaidByEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ChequeNo", txtTransactionNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyEdit()
            EmptyView()
            SqlDataSourceDeposit.DataBind()
            GridViewDeposit.DataBind()
            popupEditDeposit.ShowOnPageLoad = False
            popupViewDeposit.ShowOnPageLoad = False

        Catch ex As Exception
            lblErrMsgEdit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdViewDeposit_Click()
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewDeposit.VisibleRowCount = 0 Then Exit Sub

        With GridViewDeposit
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountDeposit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtAccountView.Text = .Item("AccountCode").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtPaymentModeView.Text = .Item("PaymentMode").ToString
                txtTransactionNumberView.Text = .Item("ChequeNo").ToString
                txtPaidByView.Text = .Item("PaidBy").ToString
                txtAmountView.Value = .Item("Amount").ToString

                'txtTransactionIDView.Text = .Item("TransactionID").ToString
                'txtSiteNameView.Text = .Item("SiteName").ToString
                'txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                'txtAccountView.Text = .Item("AccountCode").ToString
                'txtPaymentModeView.Text = .Item("PaymentMode").ToString
                'txtTransactionNumberView.Text = .Item("ChequeNo").ToString
                'txtPaidByView.Text = .Item("PaidBy").ToString
                'txtAmountView.Value = .Item("Amount").ToString


            End With

            popupViewDeposit.ShowOnPageLoad = True
        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceDeposit.DataBind()
        GridViewDeposit.DataBind()
    End Sub


    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intTransactionID = 0
        intTransactionID = 0
        intTransactionID = CInt(Val(txtTransactionIDView.Text))
        If intTransactionID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM AccountDeposit WHERE TransactionID={0}", intTransactionID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewDeposit.ShowOnPageLoad = False

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If txtTransactionIDView.Text = 0 Then Exit Sub


        intTransactionID = CLng(Val(txtTransactionIDView.Text))
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountDeposit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtTransactionIDEdit.Text = .Item("TransactionID").ToString
                dtpTransactionDateEdit.Value = CDate(VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy"))
                dtpSalesDateEdit.Value = CDate(VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy"))
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                cboAccountEdit.Value = CInt(.Item("AccountID").ToString)
                txtDetailsEdit.Text = .Item("TransactionDetails").ToString
                cboPaymentModeEdit.Value = CInt(.Item("PaymentModeID").ToString)
                txtTransactionNumberEdit.Text = .Item("ChequeNo").ToString
                txtPaidByEdit.Text = .Item("PaidBy").ToString
                txtAmountEdit.Value = .Item("Amount").ToString

            End With

            popupEditDeposit.ShowOnPageLoad = True
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

    Private Sub cmdViewDepositReport_Click(sender As Object, e As EventArgs) Handles cmdViewDepositReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountDepositSales
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountDepositSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountDepositSales.pdf")
        End Using


    End Sub

    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        If cboSiteAdd.SelectedIndex = -1 Then Exit Sub

        SqlDataSourceAccountAdd.DataBind()
        cboAccountAdd.DataBind()
    End Sub

    Private Sub GridViewDeposit_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewDeposit.CustomButtonCallback

        Call CheckUserSession()
        intTransactionID = 0
        If GridViewDeposit.VisibleRowCount = 0 Then Exit Sub

        With GridViewDeposit
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountDeposit WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtAccountView.Text = .Item("AccountCode").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtPaymentModeView.Text = .Item("PaymentMode").ToString
                txtTransactionNumberView.Text = .Item("ChequeNo").ToString
                txtPaidByView.Text = .Item("PaidBy").ToString
                txtAmountView.Value = .Item("Amount").ToString

                'txtTransactionIDView.Text = .Item("TransactionID").ToString
                'txtSiteNameView.Text = .Item("SiteName").ToString
                'txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                'txtAccountView.Text = .Item("AccountCode").ToString
                'txtPaymentModeView.Text = .Item("PaymentMode").ToString
                'txtTransactionNumberView.Text = .Item("ChequeNo").ToString
                'txtPaidByView.Text = .Item("PaidBy").ToString
                'txtAmountView.Value = .Item("Amount").ToString


            End With

            popupViewDeposit.ShowOnPageLoad = True
        End If

    End Sub
End Class