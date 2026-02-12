Imports System.Data.SqlClient
Imports System.Data
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Imports System.Drawing
Imports DevExpress.XtraReports.UI
Imports DevExpress.XtraReports.Parameters
Imports DevExpress.XtraReports.Expressions
Public Class salesPend
    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intSalesID As Long

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
        dtpPaymentDate.MaxDate = CDate(StrCurrentDate)
        dtpPaymentDate.Value = CDate(StrCurrentDate)


        cboPaymentMode.SelectedIndex = 0
        txtPaymentDetails.Text = "CASH"
        txtAmountPaid.Text = 0
        txtBalance.Text = 0
        txtSalesViewSalesID.Text = 0
        txtSalesViewSite.Text = ""

        NCount = 0
        intPaid = 0

        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.Visible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""

        EmptyView()

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

        SqlDataSourceSalesView.DataBind()
        GridViewSalesView.DataBind()

    End Sub



    Protected Sub cmdSaveYes_Click(sender As Object, e As EventArgs) Handles cmdSaveYes.Click
        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.Visible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""

        If GridViewSalesView.VisibleRowCount = 0 Then Exit Sub
        intPaid = 1

        'If Val(VB6.Format$(Me.txtCashPaid.Text, "##0.#0")) = 0 Then 
        '    intPaid = 1
        '    Dim resss
        '    resss = MsgBox("Please do you want save the Sales without receiving the Cash ", vbYesNo + vbCritical)
        '    If resss = vbNo Then Exit Sub
        '    intPaid = 0
        '    GoTo 20
        'End If

        'If Val(VB6.Format(txtCashPaid.Text, "##0.#0")) = 0 Then MsgBox("Please Enter The Cash Paid") : txtCashPaid.Focus() : Exit Sub
        Dim TotalSalesItm As DevExpress.Web.ASPxSummaryItem = GridViewSalesView.TotalSummary("Amount")
        Dim TotalSales As Double = Convert.ToDouble(GridViewSalesView.GetTotalSummaryValue(TotalSalesItm))
        If Val(VB6.Format(txtAmountPaid.Value, "##0.#0")) < TotalSales Then lblErrMsgView.Text = "The Cash Paid is less than Total Amount " : lblErrMsgView.ClientVisible = True : txtAmountPaid.Focus() : Exit Sub

        Dim intPaymentModeID As Integer = 0
        If cboPaymentMode.Text <> "" Then intPaymentModeID = cboPaymentMode.Value


        Try


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_POSSales_UpdatePendingInvoices"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesID", CLng(Val(txtSalesViewSalesID.Text))))
                .Add(New SqlParameter("@CashPaid", VB6.Format(txtAmountPaid.Value, "##0.#0")))
                .Add(New SqlParameter("@Balance", VB6.Format(txtBalance.Value, "##0.#0")))
                .Add(New SqlParameter("@PaymentDate", VB6.Format(dtpPaymentDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@PaymentModeID", intPaymentModeID))
                .Add(New SqlParameter("@PaymentDetails", txtPaymentDetails.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            popupViewSales.ShowOnPageLoad = False
            lblErrMsgView.ClientVisible = False
            lblSuccessMsgView.Visible = True
            lblSuccessMsgView.Text = "Sales Successfully Entered"


        Catch ex As Exception
            lblSuccessMsgView.Visible = False
            lblErrMsgView.ClientVisible = True
            lblErrMsgView.Text = (ex.Message)
        End Try


    End Sub



    Private Sub PrintSalesReceipt(ByVal strReceiptNumber As String)
        On Error Resume Next
        Call CheckUserSession()
        Dim intPriner As Integer = 0
        If cboSalesViewPrinter.Text <> "" Then intPriner = cboSalesViewPrinter.Value
        If intPriner = 1 Then
            Dim report As New XtraRptPOSCashSalesReceiptPOS
            report.Parameters("SalesCode").Value = strReceiptNumber
            rptViewerReceipt.OpenReport(report)

        ElseIf intPriner = 2 Then
            Dim report As New XtraRptPOSCashSalesReceiptA5
            report.Parameters("SalesCode").Value = strReceiptNumber
            rptViewerReceipt.OpenReport(report)
        ElseIf intPriner = 3 Then
            Dim report As New XtraRptPOSCashSalesReceiptA5
            report.Parameters("SalesCode").Value = strReceiptNumber
            rptViewerReceipt.OpenReport(report)
        End If
    End Sub
    Private Sub PrintSalesReReceipt(ByVal intSalesID As Long)

        On Error Resume Next
        Call CheckUserSession()
        Dim intPriner As Integer = 0
        If cboSalesViewPrinter.Text <> "" Then intPriner = cboSalesViewPrinter.Value
        If intPriner = 1 Then
            Dim report As New XtraRptPOSCashSalesReceiptPOSReprint
            report.Parameters("SalesID").Value = intSalesID
            rptViewerReceipt.OpenReport(report)

        ElseIf intPriner = 2 Then
            Dim report As New XtraRptPOSCashSalesReceiptA5Reprint
            report.Parameters("SalesID").Value = intSalesID
            rptViewerReceipt.OpenReport(report)
        ElseIf intPriner = 3 Then
            Dim report As New XtraRptPOSCashSalesReceiptA5Reprint
            report.Parameters("SalesID").Value = intSalesID
            rptViewerReceipt.OpenReport(report)
        End If
    End Sub


    Protected Sub cmdViewSales_Click()
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If GridViewSales.VisibleRowCount = 0 Then Exit Sub

        With GridViewSales
            Dim rowIndex As Integer = .FocusedRowIndex

            intSalesID = CLng(.GetRowValues(rowIndex, "SalesID").ToString)
        End With
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_POSSales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesViewSalesID.Text = .Item("SalesID").ToString
                txtSalesViewDate.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtSalesViewSite.Text = .Item("SiteName").ToString
                txtSalesViewReceiptNo.Text = .Item("SalesReceiptNo").ToString
                txtSalesViewTotalAmount.Text = .Item("TotalSales").ToString
                'If CInt(.Item("Paid")).ToString = 1 Then

            End With

            popupViewSales.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtSalesViewSalesID.Text = 0
        txtSalesViewDate.Text = ""
        txtSalesViewSite.Text = ""
        txtSalesViewReceiptNo.Text = ""
        txtSalesViewTotalAmount.Text = ""
        txtSalesViewSalesID.Text = 0
        txtSalesViewSite.Text = ""
    End Sub





End Class