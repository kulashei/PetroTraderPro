Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class AccountTranfers
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
            dtpTransactionDateAdd.MaxDate = CDate(StrCurrentDate)
            dtpTransactionDateAdd.Value = CDate(StrCurrentDate)

            dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
            dtpSearchDateFrom.Value = CDate(StrCurrentDate)
            dtpSearchDateTo.Value = CDate(StrCurrentDate)
            dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)

        'dtpAccountTransferCanceledDate.Value = CDate(StrCurrentDate)
        'dtpAccountTransferCanceledDate.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        cboAccountSearch.SelectedIndex = -1
        txtAccountSearch.Text = 0

        txtTransactionCode.Text = GenerateTransactionCode()



        'cboAccount.SelectedIndex = 0
        'SqlDataSourceAccount.SelectParameters(0) = cboAccount.Value
        SqlDataSourceAccount.DataBind()
        SqlDataSourceTransfer.DataBind()

        cboAccountFromAdd.DataBind()
        cboAccountToAdd.DataBind()

        cboAccountFromEdit.DataBind()
        cboAccountToEdit.DataBind()

        'If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        'If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        '  Account Tranfers
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=29"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID29Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID29Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID29Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID29View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID29Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID29Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID29Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID29View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID29View") = False Then cmdViewTransferReport.ClientEnabled = False

    End Sub


    Private Sub EmptyAdd()

        dtpTransactionDateAdd.Value = CDate(StrCurrentDate)
        'dtpTransactionDateAdd
        cboAccountFromAdd.SelectedIndex = -1
        cboAccountToAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        txtTransactionNumberAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()

    End Sub

    Private Sub EmptyRec()
        cboAccountFromAdd.SelectedIndex = -1
        cboAccountToAdd.SelectedIndex = -1
        txtDetailsAdd.Text = ""
        txtTransactionNumberAdd.Text = ""
        txtAmountAdd.Value = 0


        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtTransactionCode.Text = GenerateTransactionCode()
        SqlDataSourceTransfer.DataBind()
        GridViewTransfer.DataBind()

    End Sub

    Private Sub EmptyView()

        txtTransactionIDView.Text = 0
        txtTransactionDateView.Text = ""
        txtAccountFromView.Text = ""
        txtAccountToView.Text = ""
        txtDetailsView.Text = ""
        txtTransactionNumberView.Text = ""
        txtAmountView.Value = 0

        txtAmountView.Value = 0
    End Sub

    Private Sub EmptyEdit()

        cboAccountFromEdit.SelectedIndex = -1
        cboAccountToEdit.SelectedIndex = -1
        txtDetailsEdit.Text = ""
        txtTransactionNumberEdit.Text = ""
        txtAmountEdit.Value = 0


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

        Dim intAccountIDFrom As Integer = 0, intAccountIDTo As Integer = 0


        Try

            If cboAccountFromAdd.Text <> "" Then intAccountIDFrom = cboAccountFromAdd.Value
            If cboAccountToAdd.Text <> "" Then intAccountIDTo = cboAccountToAdd.Value

            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountsTranfers_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@AccountIDFrom", intAccountIDFrom))
                .Add(New SqlParameter("@AccountIDTo", intAccountIDTo))
                .Add(New SqlParameter("@TransactionDetails", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionNo", txtTransactionNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Account Transfer Successfully Registered"


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

        Dim intAccountIDFrom As Integer = 0, intAccountIDTo As Integer = 0


        Try

            If cboAccountFromAdd.Text <> "" Then intAccountIDFrom = cboAccountFromAdd.Value
            If cboAccountToAdd.Text <> "" Then intAccountIDTo = cboAccountToAdd.Value

            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_AccountsTranfers_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransactionID", CInt(Val(txtTransactionIDEdit.Text))))
                .Add(New SqlParameter("@TransactionDate", VB6.Format(dtpTransactionDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@AccountIDFrom", intAccountIDFrom))
                .Add(New SqlParameter("@AccountIDTo", intAccountIDTo))
                .Add(New SqlParameter("@TransactionDetails", txtDetailsAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@TransactionNo", txtTransactionNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyEdit()
            EmptyView()
            SqlDataSourceTransfer.DataBind()
            GridViewTransfer.DataBind()
            popupEditTransfer.ShowOnPageLoad = False
            popupViewTransfer.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdViewTransfer_Click()
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransfer.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransfer
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountsTranfers WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtAccountFromView.Text = .Item("AccountCodeFrom").ToString
                txtAccountToView.Text = .Item("AccountCodeTo").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtTransactionNumberView.Text = .Item("TransactionNo").ToString
                txtAmountView.Value = .Item("Amount").ToString



            End With

            popupViewTransfer.ShowOnPageLoad = True
        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceTransfer.DataBind()
        GridViewTransfer.DataBind()
    End Sub


    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intTransactionID = 0
        intTransactionID = 0
        intTransactionID = CInt(Val(txtTransactionIDView.Text))
        If intTransactionID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM AccountTransfer WHERE TransactionID={0}", intTransactionID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewTransfer.ShowOnPageLoad = False

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If txtTransactionIDView.Text = 0 Then Exit Sub


        intTransactionID = CLng(Val(txtTransactionIDView.Text))
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountsTranfers WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtTransactionIDEdit.Text = .Item("TransactionID").ToString
                dtpTransactionDateEdit.Value = CDate(VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy"))
                cboAccountFromEdit.Value = CInt(.Item("AccountID").ToString)
                cboAccountToEdit.Value = CInt(.Item("AccountID").ToString)
                txtDetailsEdit.Text = .Item("TransactionDetails").ToString
                txtTransactionNumberEdit.Text = .Item("TransactionNo").ToString
                txtAmountEdit.Value = .Item("Amount").ToString

            End With

            popupEditTransfer.ShowOnPageLoad = True
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

    Private Sub cmdViewTransferReport_Click(sender As Object, e As EventArgs) Handles cmdViewTransferReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountTransfer
        Dim intAccountID = 0
        If cboAccountSearch.Text <> "" Then intAccountID = cboAccountSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountsTranfers_RPTByDateByAccountID @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountTransfer.pdf")
        End Using


        End Sub

    Private Sub GridViewTransfer_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTransfer.CustomButtonCallback
        Call CheckUserSession()
        intTransactionID = 0
        Dim intTransactionIDTypeID = 0
        If GridViewTransfer.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransfer
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransactionID = CLng(.GetRowValues(rowIndex, "TransactionID").ToString)
        End With
        If intTransactionID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_AccountsTranfers WHERE TransactionID='{0}'", intTransactionID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransactionIDView.Text = .Item("TransactionID").ToString
                txtTransactionDateView.Text = VB6.Format(.Item("TransactionDate").ToString, "dd-MMM-yyyy")
                txtAccountFromView.Text = .Item("AccountCodeFrom").ToString
                txtAccountToView.Text = .Item("AccountCodeTo").ToString
                txtDetailsView.Text = .Item("TransactionDetails").ToString
                txtTransactionNumberView.Text = .Item("TransactionNo").ToString
                txtAmountView.Value = .Item("Amount").ToString
            End With

            popupViewTransfer.ShowOnPageLoad = True
        End If

    End Sub
End Class