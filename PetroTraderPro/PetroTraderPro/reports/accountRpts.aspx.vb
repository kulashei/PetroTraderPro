Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class accountRpts
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CheckUserSession()
            EmptyFields()
        End If
    End Sub
    Private Sub CheckUserSession()
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

        dtpDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpDateFrom.Value = CDate(StrCurrentDate)
        dtpDateTo.Value = CDate(StrCurrentDate)
        dtpDateFrom.MaxDate = CDate(StrCurrentDate)

        cboAccount.Text = ""

        SqlDataSourceAccount.DataBind()
        cboAccount.DataBind()


        '  Account Deposits
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID IN(27,28)"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID27View") = Session("TempUserRole").Rows(0).Item("CanView")
        Session("RoleID28View") = Session("TempUserRole").Rows(1).Item("CanView")
        If Session("RoleID27View") = False Then
            cmdBankDeposit.ClientEnabled = False
        End If
        If Session("RoleID28View") = False Then
            cmdBankDeposit.ClientEnabled = False
        End If

        '   Account Tranfers
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=29"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID29View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID29View") = False Then
            cmdAccountTranfer.ClientEnabled = False
        End If

        '    Account Debit/Credit
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=30"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID30View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID30View") = False Then
            cmdCredit.ClientEnabled = False
            cmdDebit.ClientEnabled = False
        End If

        '   View Account Statement
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=33"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID33View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID33View") = False Then
            cmdAccountStatement.ClientEnabled = False
        End If

        '   View Account Balance
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=34"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID34View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID34View") = False Then
            cmdAccountBalance.ClientEnabled = False
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

    Private Sub cmdAccountStatement_Click(sender As Object, e As EventArgs) Handles cmdAccountStatement.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountStatement
        Dim intAccountID = 0
        If cboAccount.Text <> "" Then intAccountID = cboAccount.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountStatement @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CusStatement.pdf")
        End Using

    End Sub

    Private Sub cmdAccountBalance_Click(sender As Object, e As EventArgs) Handles cmdAccountBalance.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountList

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Accounts ORDER BY SiteName,AccountName")).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CusBalance.pdf")
        End Using

    End Sub

    Protected Sub cmdBankDeposit_Click(sender As Object, e As EventArgs) Handles cmdBankDeposit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountDepositSales
        Dim intAccountID = 0
        If cboAccount.Text <> "" Then intAccountID = cboAccount.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountDeposit_RPTByDateByAccountID @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountDeposit.pdf")
        End Using

    End Sub

    Protected Sub cmdAccountTranfer_Click(sender As Object, e As EventArgs) Handles cmdAccountTranfer.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountTransfer
        Dim intAccountID = 0
        If cboAccount.Text <> "" Then intAccountID = cboAccount.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountsTranfers_RPTByDateByAccountID @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountTranfers.pdf")
        End Using

    End Sub

    Protected Sub cmdCredit_Click(sender As Object, e As EventArgs) Handles cmdCredit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountTrantractions
        Dim intAccountID = 0
        If cboAccount.Text <> "" Then intAccountID = cboAccount.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountCredits_RPTByDateByAccountID @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Accountcredit.pdf")
        End Using

    End Sub

    Protected Sub cmdDebit_Click(sender As Object, e As EventArgs) Handles cmdDebit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountTrantractions
        Dim intAccountID = 0
        If cboAccount.Text <> "" Then intAccountID = cboAccount.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountDebits_RPTByDateByAccountID @DateFrom='{0}',@DateTo='{1}', @AccountID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intAccountID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountDebit.pdf")
        End Using


    End Sub
End Class