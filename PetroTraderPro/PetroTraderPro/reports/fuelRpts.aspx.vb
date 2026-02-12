Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class fuelRpts
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

        cboSite.SelectedIndex = 0
        cboPump.SelectedIndex = -1
        cboTank.SelectedIndex = -1
        cboProduct.SelectedIndex = -1
        Dim STR(0) As String
        STR(0) = "Exec Usp_GetCurrentDate"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)

        dsCurrentDate = dsMany(0)
        StrCurrentDate = dsCurrentDate.Tables(0).Rows(0).Item("CurrentDate")

        dtpDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpDateTo.MaxDate = CDate(StrCurrentDate)


        dtpDateFrom.Value = CDate(StrCurrentDate)
        dtpDateTo.Value = CDate(StrCurrentDate)



        'Fuel sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=2"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID2View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID2View") = False Then
            cmdSalesReport.ClientEnabled = False
            cmdFuelGeneralsales.ClientEnabled = False
            cmdFuelSalesSummary.ClientEnabled = False
            cmdFuelDailySummary.ClientEnabled = False
        End If



        'Fuel Stock
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=3"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID3View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID3View") = False Then
            cmdSalesAndStock.ClientEnabled = False
            cmdFuelStockSummary.ClientEnabled = False
        End If


        ' Fuel Receipt
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=4"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID4View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID4View") = False Then
            cmdFuelReceipt.ClientEnabled = False
        End If


        ' Fuel Consumption
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=5"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID5View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID5View") = False Then
            cmdFuelConsumption.ClientEnabled = False
        End If

        ' Fuel E-Payment
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=6"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID6View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID6View") = False Then
            cmdEPayment.ClientEnabled = False
        End If

        ' Fuel Coupon Sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=7"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID7View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID7View") = False Then
            cmdCouponSales.ClientEnabled = False
        End If

        ' Fuel Tranfer
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=8"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID8View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID8View") = False Then
            cmdStockTransfer.ClientEnabled = False
        End If

        'View Fuel Margin Report
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=11"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID11View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID11View") = False Then
            cmdProfitandLoss.ClientEnabled = False
        End If

        ' Customer Fuel Supply
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=13"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID13View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID13View") = False Then
            cmdFuelCustomerSupply.ClientEnabled = False
        End If

        ' Customer Payments
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=15"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID15View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID15View") = False Then
            cmdCustomerPayment.ClientEnabled = False
        End If

        ' Expenditure
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=31"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID31View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID31View") = False Then
            cmdExpenditure.ClientEnabled = False
        End If

        'Fuel sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=2"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID2View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID2View") = False Then
            cmdSalesReport.ClientEnabled = False
            cmdFuelGeneralsales.ClientEnabled = False
            cmdFuelSalesSummary.ClientEnabled = False
            cmdFuelDailySummary.ClientEnabled = False
        End If

        ' Account Deposits(Sales)
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=27"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID27View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID27View") = False Then
            cmdBankDeposit.ClientEnabled = False
        End If

        'Attendant Shortage
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=47"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID47View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID47View") = False Then
            cmdAttendShortage.ClientEnabled = False
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

    Private Sub cmdSalesReport_Click(sender As Object, e As EventArgs) Handles cmdSalesReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelDailySales
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        report.Name = "DailyFuelSales-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Sales Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelSales.pdf")
        'End Using

    End Sub

    Protected Sub cmdSalesAndStock_Click(sender As Object, e As EventArgs) Handles cmdSalesAndStock.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelDailyStock
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySalesAndStock_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        report.Name = "DailyFuelStock-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Sales & Stock Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelStock.pdf")
        'End Using

    End Sub

    Protected Sub cmdFuelGeneralsales_Click(sender As Object, e As EventArgs) Handles cmdFuelGeneralsales.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelGenelSales
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySales_RPTProductSalesSummaryByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelGenelSales-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel General Sales Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelGenelSales.pdf")
        'End Using


    End Sub

    Protected Sub cmdFuelCustomerSupply_Click(sender As Object, e As EventArgs) Handles cmdFuelCustomerSupply.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelCustomerSupply
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelCustomerSupply_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "CustomerFuelSupply-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Customer Fuel Supply Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CustomerFuelSupply.pdf")
        'End Using

    End Sub

    Protected Sub cmdFuelConsumption_Click(sender As Object, e As EventArgs) Handles cmdFuelConsumption.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelConsumption
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelConsumption_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"



        report.Name = "FuelConsumption-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Consumption Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelConsumption.pdf")
        'End Using
    End Sub

    Protected Sub cmdFuelSalesSummary_Click(sender As Object, e As EventArgs) Handles cmdFuelSalesSummary.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelSalesSummary
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySales_Summary_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelSalesSummary-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Sales Summary Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelSalesSummary.pdf")
        'End Using

    End Sub

    Protected Sub cmdStockTransfer_Click(sender As Object, e As EventArgs) Handles cmdStockTransfer.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelStockTransfer
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelStockTransfer_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelStockTransfer-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Stock Transfer Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelStockTransfer.pdf")
        'End Using
    End Sub

    Protected Sub cmdFuelStockSummary_Click(sender As Object, e As EventArgs) Handles cmdFuelStockSummary.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelStockSummary
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelStockSummary_RPTBySiteID @SiteID={0}", intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelStockSummary-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel StockS ummary Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelStockSummary.pdf")
        'End Using
    End Sub

    Protected Sub cmdFuelReceipt_Click(sender As Object, e As EventArgs) Handles cmdFuelReceipt.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelTankReciept
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelTankReceipt_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelTankReciept-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Fuel Reciept Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelTankReciept.pdf")
        'End Using
    End Sub

    Protected Sub cmdCouponSales_Click(sender As Object, e As EventArgs) Handles cmdCouponSales.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelCouponSales
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelCouponSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "CouponSales-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Coupon Sales Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelEPaymentSales.pdf")
        'End Using
    End Sub

    Protected Sub cmdEPayment_Click(sender As Object, e As EventArgs) Handles cmdEPayment.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelEPaymentSales
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelEPaymentSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "FuelEPaymentSales-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "E-Payments Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True
        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelEPaymentSales.pdf")
        'End Using
    End Sub

    Protected Sub cmdCustomerPayment_Click(sender As Object, e As EventArgs) Handles cmdCustomerPayment.Click
        ''On Error Resume Next
        'Call CheckUserSession()
        ''Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        ''Response.Redirect("~/paymentreceipt1.aspx")
        ''If CLng(Session("PaymentID")) = 0 Then Exit Sub
        'Dim printFlag As Boolean = Nothing
        'Dim stream = New MemoryStream()
        'Dim report As New XtraRptFuelEPaymentSales
        'Dim intSiteID = 0
        'If cboSite.Text <> "" Then intSiteID = cboSite.Value

        'Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelEPaymentSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        'report.DataSource = dt
        ''report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        'report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelEPaymentSales.pdf")
        'End Using

    End Sub

    Protected Sub cmdExpenditure_Click(sender As Object, e As EventArgs) Handles cmdExpenditure.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptExpenditure
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_Expenditure_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "Expenditure-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Expenditure Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Expenditure.pdf")
        'End Using

    End Sub

    Protected Sub cmdBankDeposit_Click(sender As Object, e As EventArgs) Handles cmdEPayment.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAccountDepositSales
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_AccountDepositSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "AccountDepositSales-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Account Deposit Sales Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "AccountDepositSales.pdf")
        'End Using
    End Sub

    Protected Sub cmdFuelDailySummary_Click(sender As Object, e As EventArgs) Handles cmdFuelDailySummary.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelGeneralSaleSummary
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySalesSummary1_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "SalesSummary-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Sales Summary Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True

        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SalesSummary.pdf")
        'End Using


    End Sub

    Protected Sub cmdRefresh_Click(sender As Object, e As EventArgs) Handles cmdRefresh.Click
        EmptyFields()
    End Sub

    Protected Sub cmdAttendShortage_Click(sender As Object, e As EventArgs) Handles cmdAttendShortage.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelAttendantShortages
        Dim intSiteID = 0
        If cboSite.Text <> "" Then intSiteID = cboSite.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelAttendantShortages_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"


        report.Name = "AttendantShortage-" & GenerateTransactionCode()
        PopupPrintReport.HeaderText = "Attendant Shortages Report"
        rptViewerReport.OpenReport(report)
        PopupPrintReport.ShowOnPageLoad = True
        'Using ms As New MemoryStream()
        '    report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
        '    WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SalesSummary.pdf")
        'End Using


    End Sub
End Class