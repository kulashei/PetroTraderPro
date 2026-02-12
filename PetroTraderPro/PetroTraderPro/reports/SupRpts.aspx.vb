Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class SupRpts
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

        cboSupplierAdd.Text = ""

        SqlDataSourceSuppliers.DataBind()
        cboSupplierAdd.DataBind()

        ' Supplier Fuel Receipt
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=20"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID20View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID20View") = False Then
            cmdFuelReceipt.ClientEnabled = False
        End If


        ' Supplier Inventory Receipt
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=21"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID21View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID21View") = False Then
            cmdLubeCredit.ClientEnabled = False
        End If


        ' Supplier Payments
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=22"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID22View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID22View") = False Then
            cmdSupplierPayments.ClientEnabled = False
        End If


        ' Debit/Credit Supplier Account
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=23"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID23View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID23View") = False Then
            cmdDebitCredit.ClientEnabled = False
        End If


        'View Supplier Statement
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=24"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID24View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID24View") = False Then
            cmdSupplierStatement.ClientEnabled = False
        End If


        'View Supplier Balances
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=25"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID25View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID25View") = False Then
            cmdSupplierBalance.ClientEnabled = False
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

    Protected Sub cmdFuelReceipt_Click(sender As Object, e As EventArgs) Handles cmdFuelReceipt.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierFuelReceipt
        Dim intSupplierID = 0
        If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierFuelReceipt_RPTByDateBySupplierID @DateFrom='{0}',@DateTo='{1}', @SupplierID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSupplierID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelSupplierSupply.pdf")
        End Using
    End Sub

    Private Sub cmdSupplierPayments_Click(sender As Object, e As EventArgs) Handles cmdSupplierPayments.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierPayments
        Dim intSupplierID = 0
        If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierPayments_RPTByDateBySupplierID @DateFrom='{0}',@DateTo='{1}', @SupplierID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSupplierID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupplierPayment.pdf")
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
        Dim report As New XtraRptSupplierDebitCredit
        Dim intSupplierID = 0
        If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierDebitCredit_RPTByDateBySupplierID @DateFrom='{0}',@DateTo='{1}', @SupplierID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSupplierID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupplierAccountDrCr.pdf")
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
        Dim report As New XtraRptPOSSupplierReceipt
        Dim intSupplierID = 0
        If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierPOSReceipt_RPTByDateBySupplierID @DateFrom='{0}',@DateTo='{1}', @SupplierID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSupplierID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "POSSupplierSupply.pdf")
        End Using


    End Sub

    Private Sub cmdSupplierStatement_Click(sender As Object, e As EventArgs) Handles cmdSupplierStatement.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierStatement
        Dim intSupplierID = 0
        If cboSupplierAdd.Text <> "" Then intSupplierID = cboSupplierAdd.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierStatement @DateFrom='{0}',@DateTo='{1}', @SupplierID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSupplierID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupplierStatement.pdf")
        End Using

    End Sub

    Private Sub cmdSupplierBalance_Click(sender As Object, e As EventArgs) Handles cmdSupplierBalance.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptSupplierList

        Dim dt As DataTable = LoadData("EXEC Usp_Suppliers_RPT").Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Suppliers.pdf")
        End Using

    End Sub

    Protected Sub cmdRefresh_Click(sender As Object, e As EventArgs) Handles cmdRefresh.Click
        EmptyFields()
    End Sub
End Class