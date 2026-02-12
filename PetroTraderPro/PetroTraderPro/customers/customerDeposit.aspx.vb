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
Public Class customerDeposit
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
        dtpSalesDate.MaxDate = CDate(StrCurrentDate)
        dtpSalesDate.Value = CDate(StrCurrentDate)

        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpSearchDateFrom.Value = CDate(StrCurrentDate)
        dtpSearchDateTo.Value = CDate(StrCurrentDate)
        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)

        dtpSalesCanceledDate.Value = CDate(StrCurrentDate)
        dtpSalesCanceledDate.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate

        cboSite.SelectedIndex = -1
        GridLookupItems.Text = ""
        GridLookupItems.Value = Nothing
        txtQuantity.Text = 0
        txtUnitPrice.Text = 0
        txtAmount.Text = 0
        cboPaymentMode.SelectedIndex = 0
        txtPaymentDetails.Text = "CASH"
        'txtAmountPaid.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()

        NCount = 0
        lblNCount.Text = 0
        intPaid = 0

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Session("TempSales") = New DataTable

        CreateTempSales()

        SqlDataSourceItems.DataBind()
        SqlDataSourceCustomers.DataBind()
        GridLookupItems.DataBind()



    End Sub
    Private Sub CreateTempSales()

        Session("TempSales") = New DataTable
        Session("TempSales").Columns.Add("RowNo", GetType(Integer))
        Session("TempSales").Columns.Add("NCount", GetType(Integer))
        Session("TempSales").Columns.Add("ItemID", GetType(Integer))
        Session("TempSales").Columns.Add("ItemName", GetType(String))
        Session("TempSales").Columns.Add("UM", GetType(String))
        Session("TempSales").Columns.Add("Quantity", GetType(Double))
        Session("TempSales").Columns.Add("UnitPrice", GetType(Double))
        Session("TempSales").Columns.Add("Amount", GetType(Double))
        Call ItemCount()


        GridViewTempSales.DataSource = Session("TempSales")
        GridViewTempSales.DataBind()
    End Sub

    Private Sub ItemCount()
        If Session("TempSales").Rows.Count = 0 Then
            lblNCount.Text = 1
        Else
            lblNCount.Text = Session("TempSales").Rows(Session("TempSales").Rows.Count - 1).Item("NCount") + 1
        End If

        'NCount = NCount + 1
    End Sub

    Private Sub AddToList()
        On Error Resume Next
        Dim TempRow() As System.Data.DataRow
        TempRow = Session("TempSales").Select("NCount=" & CInt(lblNCount.Text))

        Dim douQty As Double = 0, douPrice As Double = 0, douCost As Double = 0
        Dim margin As Double = 0, Amount As Double = 0, totaMargin As Double = 0
        With GridLookupItems.GridView
            Dim RowIndx As Integer = .FocusedRowIndex
            douQty = txtQuantity.Value
            douPrice = txtUnitPrice.Value
            douCost = Val(VB6.Format(.GetRowValues(RowIndx, "CostPrice"), "##0.###0"))

            margin = douPrice - douCost
            Amount = VB6.Format(douQty * douPrice, "##0.#0")
            totaMargin = VB6.Format((margin * douQty), "##0.#0")

            If TempRow.Count = 0 Then
                Dim Row1 As DataRow
                Row1 = Session("TempSales").NewRow()

                Row1.Item("NCount") = CInt(lblNCount.Text)
                Row1.Item("ItemID") = GridLookupItems.Value
                Row1.Item("ItemName") = .GetRowValues(RowIndx, "ItemName").ToString
                Row1.Item("UM") = .GetRowValues(RowIndx, "UM").ToString
                Row1.Item("Quantity") = douQty
                Row1.Item("UnitPrice") = douPrice
                Row1.Item("Amount") = Amount

                Session("TempSales").Rows.Add(Row1)
            Else
                TempRow(0)("ItemID") = GridLookupItems.Value
                TempRow(0)("ItemName") = .GetRowValues(RowIndx, "ItemName").ToString
                TempRow(0)("UM") = .GetRowValues(RowIndx, "UM").ToString
                TempRow(0)("Quantity") = douQty
                TempRow(0)("UnitPrice") = douPrice
                TempRow(0)("Amount") = Amount
            End If
        End With
        Call EmptyRec()

    End Sub

    Private Sub EmptyRec()
        On Error Resume Next

        GridLookupItems.Text = ""
        'lblBillNo.Text = ""
        txtAmount.Value = 0.0#
        'lblBalance.Text = 0.0#
        txtUnitPrice.Value = 0.0#
        txtQuantity.Text = 0.0#
        'txtCashPaid.Text = 0.0#

        GridViewTempSales.DataSource = Session("TempSales")
        GridViewTempSales.DataBind()
        ItemCount()
    End Sub

    Protected Sub GridViewTempSales_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles GridViewTempSales.DataBound
        Dim gridView As ASPxGridView = TryCast(sender, ASPxGridView)
        GridViewTempSales.JSProperties("cpSummary") = GridViewTempSales.GetTotalSummaryValue(GridViewTempSales.TotalSummary("Amount"))
    End Sub
    Protected Sub cmdAddItem_Click(sender As Object, e As EventArgs) Handles cmdAddItem.Click
        Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        lblErrMsgItem.Visible = False
        lblErrMsgItem.Text = ""
        If cboSite.Text = "" Then cboSite.Focus() : Exit Sub
        If GridLookupItems.Text = "" Then GridLookupItems.Focus() : Exit Sub
        If Val(VB6.Format(txtQuantity.Value, "##0.#0")) = 0 Then txtQuantity.Focus() : Exit Sub
        If Val(VB6.Format(txtUnitPrice.Value, "##0.###0")) = 0 Then txtUnitPrice.Focus() : Exit Sub

        Call AddToList()
        Call ItemCount()

    End Sub

    Private Sub cboSite_ValueChanged(sender As Object, e As EventArgs) Handles cboSite.ValueChanged
        Call CheckUserSession()
        CreateTempSales()
    End Sub

    Private Sub GridViewTempSales_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTempSales.CustomButtonCallback
        'On Error Resume Next

        Select Case e.ButtonID

            Case "cmdRemove"

                Call CheckUserSession()
                If GridViewTempSales.VisibleRowCount = 0 Then Exit Sub

                With GridViewTempSales
                    Dim rowIndex As Integer = .FocusedRowIndex
                    If rowIndex = -1 Then Exit Sub

                    Session("TempSales").DefaultView.Delete(rowIndex)

                End With

                GridViewTempSales.DataSource = Session("TempSales")
                GridViewTempSales.DataBind()

        End Select
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Try
            If GridLookupCustomers.Text = "" Then GridLookupCustomers.Focus() : Exit Sub
            If GridViewTempSales.VisibleRowCount = 0 Then Exit Sub
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
            Dim TotalSalesItm As DevExpress.Web.ASPxSummaryItem = GridViewTempSales.TotalSummary("Amount")
            Dim TotalSales As Double = Convert.ToDouble(GridViewTempSales.GetTotalSummaryValue(TotalSalesItm))

            AddSales()

        Catch ex As Exception
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Private Sub AddSales()
        'On Error Resume Next
        Try
            Dim intSiteID As Integer = 0, intPaymentModeID As Integer = 0, intCustomerID As Integer = 0

            Dim TotalSalesItm As DevExpress.Web.ASPxSummaryItem = GridViewTempSales.TotalSummary("Amount")
            Dim TotalSales As Double = Convert.ToDouble(GridViewTempSales.GetTotalSummaryValue(TotalSalesItm))


            If cboSite.Text <> "" Then intSiteID = cboSite.Value
            If GridLookupCustomers.Text <> "" Then intCustomerID = GridLookupCustomers.Value
            If cboPaymentMode.Text <> "" Then intPaymentModeID = cboPaymentMode.Value

            Dim ItmCount As Integer = 0
            Dim ItmItemID As Long = 0
            Dim ItmUM As String = ""
            Dim ItmQuantity As Double = 0
            Dim ItmPrice As Double = 0
            Dim ItmAmount As Double = 0
            Dim strQuery As String = ""

            strQuery = "EXEC usp_CustomerDeposit_Insert " &
                "@SalesCode='" & txtTransactionCode.Text & "'," &
                "@SalesDate='" & VB6.Format(dtpSalesDate.Value.Date, "dd-MMM-yyyy") & "'," &
                "@CustomerID=" & intCustomerID & "," &
                "@SiteID=" & intSiteID & "," &
                "@TotalAmount=" & TotalSales & "," &
                "@PaymentModeID=" & intPaymentModeID & "," &
                "@PaymentDetails='" & txtPaymentDetails.Text.Trim.ToUpper & "'," &
                "@UserID=" & Session("UserID")

            With GridViewTempSales

                For i = 0 To .VisibleRowCount - 1

                    ItmUM = .GetRowValues(i, "UM").ToString
                    ItmItemID = .GetRowValues(i, "ItemID")
                    ItmCount = .GetRowValues(i, "NCount")
                    ItmQuantity = .GetRowValues(i, "Quantity")
                    ItmPrice = .GetRowValues(i, "UnitPrice")
                    ItmAmount = .GetRowValues(i, "Amount")

                    strQuery = strQuery & " EXEC usp_CustomerDepositDetails_Insert " &
                        "@SalesCode='" & txtTransactionCode.Text.Trim.ToUpper & "'," &
                        "@SiteID=" & intSiteID & "," &
                        "@ItemID=" & ItmItemID & "," &
                        "@UM='" & ItmUM & "'," &
                        "@NCount=" & ItmCount & "," &
                        "@Quantity=" & ItmQuantity & "," &
                        "@UnitPrice=" & ItmPrice & "," &
                        "@Amount=" & ItmAmount & "," &
                        "@UserID=" & Session("UserID")

                Next
            End With

            ExecuteMyQuery(strQuery)

            'PopupSave.ShowOnPageLoad = False
            intGenReceiptType = 1
            PrintSalesReceipt(txtTransactionCode.Text.Trim.ToUpper)
            PopupPrintReceipt.ShowOnPageLoad = True


            Call EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Deposit Successfully Completed"

        Catch ex As Exception
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try
    End Sub


    Private Sub PrintSalesReceipt(ByVal strReceiptNumber As String)
        On Error Resume Next
        Call CheckUserSession()
        intGenReceiptType = 1
        Dim report As New XtraRptCustomerDeposittA5
        report.Parameters("SalesCode").Value = strReceiptNumber
        rptViewerReceipt.OpenReport(report)

    End Sub
    Private Sub PrintSalesRePrintReceipt(ByVal strReceiptNumber As String, intGenReceiptType As Integer)
        On Error Resume Next
        Call CheckUserSession()
        Dim report As New XtraRptCustomerDeposittA5
        report.Parameters("SalesCode").Value = strReceiptNumber
        rptViewerReceipt.OpenReport(report)

    End Sub

    Private Sub cashsales_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        If cboSite.Items.Count = 1 Then cboSite.SelectedIndex = 0

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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_CustomerDeposit WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesViewSalesID.Text = .Item("SalesID").ToString
                txtSalesViewTransactionCode.Text = .Item("SalesCode").ToString
                txtSalesViewDate.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtSalesViewSite.Text = .Item("SiteName").ToString
                txtSalesViewReceiptNo.Text = .Item("SalesReceiptNo").ToString
                txtSalesViewPaymentMode.Text = .Item("PaymentMode").ToString
                txtSalesViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtSalesViewTotalAmount.Value = .Item("TotalSales").ToString
            End With

            popupViewSales.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtSalesViewTransactionCode.Text = ""
        txtSalesViewReceiptNo.Text = ""
        txtSalesViewSalesID.Text = 0
        txtSalesViewSite.Text = ""
        txtSalesViewPaymentMode.Text = ""
        txtSalesViewPaymentDetails.Text = ""
        txtSalesViewDate.Text = ""
        txtSalesViewTotalAmount.Text = 0
    End Sub

    Private Sub cmdViewReprint_Click(sender As Object, e As EventArgs) Handles cmdViewReprint.Click
        On Error Resume Next
        Call CheckUserSession()
        intGenReceiptType = 2

        PrintSalesRePrintReceipt((txtSalesViewTransactionCode.Text.Trim.ToUpper), 2)
        PopupPrintReceipt.ShowOnPageLoad = True


    End Sub

    Private Sub cmdConfirmCancelYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmCancelYes.Click
        Call CheckUserSession()
        If txtSalesViewSalesID.Text = 0 Then Exit Sub
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
            objCommand.CommandText = "Usp_CustomerDeposit_CancelBySalesID"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesID", CLng(Val(txtSalesViewSalesID.Text))))
                .Add(New SqlParameter("@CanceledDate", VB6.Format(dtpSalesCanceledDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@CancelRemark", txtRetrunRemark.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            intGenReceiptType = 3
            PrintSalesRePrintReceipt(CLng(txtSalesViewSalesID.Text.Trim.ToUpper), 3)
            PopupPrintReceipt.ShowOnPageLoad = True

            lblErrMsgCancel.ClientVisible = False
            lblSuccessMsgCancel.ClientVisible = True
            lblSuccessMsgCancel.Text = "Deposit Successfully Cancelled"

            popupCancelSales.ShowOnPageLoad = False
            popupViewSales.ShowOnPageLoad = False
            popupAddSales.ShowOnPageLoad = False

            EmptyFields()

        Catch ex As Exception
            lblErrMsgCancel.ClientVisible = False
            lblErrMsgCancel.ClientVisible = True
            lblErrMsgCancel.Text = (ex.Message)
        End Try
    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()
    End Sub


    Private Sub GridViewSalesView_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewSalesView.CustomButtonCallback
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If GridViewSales.VisibleRowCount = 0 Then Exit Sub

        With GridViewSales
            Dim rowIndex As Integer = .FocusedRowIndex

            intSalesID = CLng(.GetRowValues(rowIndex, "SalesID").ToString)
        End With
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_CustomerDeposit WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesViewSalesID.Text = .Item("SalesID").ToString
                txtSalesViewTransactionCode.Text = .Item("SalesCode").ToString
                txtSalesViewDate.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtSalesViewSite.Text = .Item("SiteName").ToString
                txtSalesViewReceiptNo.Text = .Item("SalesReceiptNo").ToString
                txtSalesViewPaymentMode.Text = .Item("PaymentMode").ToString
                txtSalesViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtSalesViewTotalAmount.Value = .Item("TotalSales").ToString
            End With

            popupViewSales.ShowOnPageLoad = True
        End If
    End Sub
End Class