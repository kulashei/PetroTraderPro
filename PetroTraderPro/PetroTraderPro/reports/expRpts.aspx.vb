Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class expRpts
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

        cboCategory.Text = ""

        SqlDataSourceCategory.DataBind()
        cboCategory.DataBind()


        '    Expenditure
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=31"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID31View") = Session("TempUserRole").Rows(0).Item("CanView")
        If Session("RoleID31View") = False Then
            cmdDetails.ClientEnabled = False
            cmdSummary.ClientEnabled = False
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

    Private Sub cmdDetails_Click(sender As Object, e As EventArgs) Handles cmdDetails.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptExpenditure
        Dim intCategoryID = 0
        If cboCategory.Text <> "" Then intCategoryID = cboCategory.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_Expenditure_RPTByDateByCategoryID @DateFrom='{0}',@DateTo='{1}', @CategoryID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCategoryID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "ExpDetails.pdf")
        End Using

    End Sub

    Private Sub cmdSummary_Click(sender As Object, e As EventArgs) Handles cmdSummary.Click
        'On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptExpenditureSummary
        Dim intCategoryID = 0
        If cboCategory.Text <> "" Then intCategoryID = cboCategory.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_Expenditure_SummaryRPTByDateByCategoryID @DateFrom='{0}',@DateTo='{1}', @CategoryID={2}", VB6.Format(dtpDateFrom.Value.Date, "dd-MMM-yyyy"), VB6.Format(dtpDateTo.Value.Date, "dd-MMM-yyyy"), intCategoryID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "ExpSum.pdf")
        End Using

    End Sub

End Class