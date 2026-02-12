Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class cusRpts
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

        GridLookupCustomersAdd.Text = ""
        GridLookupCustomersAdd.GridView.Width = 600

        SqlDataSourceCustomers.DataBind()
        GridLookupCustomersAdd.DataBind()


        ' Customer Fuel Supply
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=13"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID13View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID13View") = False Then
            cmdFuelCredit.ClientEnabled = False
        End If

        ' Customer Inventory Supply
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=14"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID14View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID14View") = False Then
            cmdLubeCredit.ClientEnabled = False
        End If

        ' Customer Payments
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=15"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID15View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID15View") = False Then
            cmdCustomerPayments.ClientEnabled = False
        End If

        ' Debit/Credit Customer Account
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=16"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID16View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID16View") = False Then
            cmdDebitCredit.ClientEnabled = False
        End If

        'Print Customer Statement
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=17"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID17View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID17View") = False Then
            cmdCustomerStatement.ClientEnabled = False
        End If

        'View Customer Balances
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=18"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID18View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID18View") = False Then
            cmdCustomerBalance.ClientEnabled = False
            cmdDebtors.ClientEnabled = False
            cmdCreditors.ClientEnabled = False
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

    Protected Sub cmdFuelCredit_Click(sender As Object, e As EventArgs) Handles cmdFuelCredit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelCustomerSupply1
        Dim intCustomerID = 0
        If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelCustomerSupply_RPTByDateByCustomerID @DateFrom='{0}',@DateTo='{1}', @CustomerID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCustomerID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelCustomerSupply.pdf")
        End Using
    End Sub

    Private Sub cmdCustomerPayments_Click(sender As Object, e As EventArgs) Handles cmdCustomerPayments.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerPayments1
        Dim intCustomerID = 0
        If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_CustomerPayments_RPTByDateByCustomerID @DateFrom='{0}',@DateTo='{1}', @CustomerID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCustomerID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CustomerPayment.pdf")
        End Using
    End Sub

    Private Sub cmdDebitCredit_Click(sender As Object, e As EventArgs) Handles cmdDebitCredit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerAccountsDebitCredit
        Dim intCustomerID = 0
        If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_CustomerAccountDebitCredit_RPTByDateByCustomerID @DateFrom='{0}',@DateTo='{1}', @CustomerID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCustomerID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CustomerAccountDrCr.pdf")
        End Using

    End Sub

    Private Sub cmdLubeCredit_Click(sender As Object, e As EventArgs) Handles cmdLubeCredit.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptPOSCustomerSupply
        Dim intCustomerID = 0
        If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_POSSales_RPTSearchCreditByDateByCustomerID @DateFrom='{0}',@DateTo='{1}', @CustomerID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCustomerID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "POSCustomerSupply.pdf")
        End Using


    End Sub

    Private Sub cmdCustomerStatement_Click(sender As Object, e As EventArgs) Handles cmdCustomerStatement.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerStatement
        Dim intCustomerID = 0
        If GridLookupCustomersAdd.Text <> "" Then intCustomerID = GridLookupCustomersAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_CustomerStatement @DateFrom='{0}',@DateTo='{1}', @CustomerID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCustomerID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CusStatement.pdf")
        End Using

    End Sub

    Private Sub cmdCustomerBalance_Click(sender As Object, e As EventArgs) Handles cmdCustomerBalance.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerBalance

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers ORDER BY CustomerName")).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CusBalance.pdf")
        End Using

    End Sub

    Private Sub cmdDebtors_Click(sender As Object, e As EventArgs) Handles cmdDebtors.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerBalance

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers WHERE Balance<0 ORDER BY CustomerName")).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Debtors.pdf")
        End Using

    End Sub

    Private Sub cmdCreditors_Click(sender As Object, e As EventArgs) Handles cmdCreditors.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerBalance

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers WHERE Balance>0 ORDER BY CustomerName")).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Debtors.pdf")
        End Using
    End Sub
End Class