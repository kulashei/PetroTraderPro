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
Public Class supReceipt

    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intReceiptID As Long

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
        dtpReceiptDate.MaxDate = CDate(StrCurrentDate)
        dtpReceiptDate.Value = CDate(StrCurrentDate)

        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpSearchDateFrom.Value = CDate(StrCurrentDate)
        dtpSearchDateTo.Value = CDate(StrCurrentDate)
        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)

        dtpReceiptCanceledDate.Value = CDate(StrCurrentDate)
        dtpReceiptCanceledDate.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate
        txtSearchDateTo.Text = StrCurrentDate

        cboSite.SelectedIndex = -1
        GridLookupItems.Text = ""
        GridLookupItems.Value = Nothing
        txtQtyInStock.Text = 0
        txtTotalStock.Text = 0
        txtQuantity.Text = 0
        txtUnitPrice.Text = 0
        txtAmount.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()

        NCount = 0
        lblNCount.Text = 0
        intPaid = 0

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Session("TempReceipt") = New DataTable

        CreateTempReceipt()
        'cboSite.SelectedIndex = 0
        'SqlDataSourceItems.SelectParameters(0) = cboSite.Value
        'SqlDataSourceItems.DataBind()
        'GridLookupItems.DataBind()
        'If cboSite.Items.Count = 1 Then cboSite.SelectedIndex = 0
        'GridUpdate()

        'If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        'If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        '' Fuel Consumption
        'Session("TempUserRole") = New DataTable
        'Session("AllUserRoles").DefaultView.RowFilter = "RoleID=5"
        'Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        'Session("RoleID5Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        'Session("RoleID5Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        'Session("RoleID5Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        'Session("RoleID5View") = Session("TempUserRole").Rows(0).Item("CanView")

        'If Session("RoleID5Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        'If Session("RoleID5Edit") = False Then cmdEdit.ClientEnabled = False
        'If Session("RoleID5Delete") = False Then cmdDelete.ClientEnabled = False

        'If Session("RoleID5View") = False Then cmdSearcByDate.ClientEnabled = False
        'If Session("RoleID5View") = False Then cmdViewSalesReport.ClientEnabled = False

    End Sub
    Private Sub CreateTempReceipt()

        Session("TempReceipt") = New DataTable
        Session("TempReceipt").Columns.Add("RowNo", GetType(Integer))
        Session("TempReceipt").Columns.Add("NCount", GetType(Integer))
        Session("TempReceipt").Columns.Add("ItemID", GetType(Integer))
        Session("TempReceipt").Columns.Add("ItemName", GetType(String))
        Session("TempReceipt").Columns.Add("UM", GetType(String))
        Session("TempReceipt").Columns.Add("ExpiryDate", GetType(String))
        Session("TempReceipt").Columns.Add("BatchNumber", GetType(String))
        Session("TempReceipt").Columns.Add("Quantity", GetType(Double))
        Session("TempReceipt").Columns.Add("UnitPrice", GetType(Double))
        Session("TempReceipt").Columns.Add("Amount", GetType(Double))
        Session("TempReceipt").Columns.Add("UnitMargin", GetType(Double))
        Session("TempReceipt").Columns.Add("CostPrice", GetType(Double))
        Session("TempReceipt").Columns.Add("TotalMargin", GetType(Double))
        Call ItemCount()


        GridViewTempReceipt.DataSource = Session("TempReceipt")
        GridViewTempReceipt.DataBind()
    End Sub

    Private Sub ItemCount()
        If Session("TempReceipt").Rows.Count = 0 Then
            lblNCount.Text = 1
        Else
            lblNCount.Text = Session("TempReceipt").Rows(Session("TempReceipt").Rows.Count - 1).Item("NCount") + 1
        End If

        'NCount = NCount + 1
    End Sub

    Private Sub AddToList()
        On Error Resume Next
        Dim TempRow() As System.Data.DataRow
        TempRow = Session("TempReceipt").Select("NCount=" & CInt(lblNCount.Text))

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
                Row1 = Session("TempReceipt").NewRow()

                Row1.Item("NCount") = CInt(lblNCount.Text)
                Row1.Item("ItemID") = GridLookupItems.Value
                Row1.Item("ItemName") = .GetRowValues(RowIndx, "ItemName").ToString
                Row1.Item("UM") = .GetRowValues(RowIndx, "UM").ToString
                Row1.Item("Quantity") = douQty
                Row1.Item("UnitPrice") = douPrice
                Row1.Item("Amount") = Amount
                Row1.Item("UnitMargin") = margin
                Row1.Item("CostPrice") = douCost
                Row1.Item("TotalMargin") = totaMargin
                Row1.Item("ExpiryDate") = .GetRowValues(RowIndx, "ExpiryDate").ToString
                Row1.Item("BatchNumber") = .GetRowValues(RowIndx, "BatchNumber").ToString

                Session("TempReceipt").Rows.Add(Row1)
            Else
                TempRow(0)("ItemID") = GridLookupItems.Value
                TempRow(0)("ItemName") = .GetRowValues(RowIndx, "ItemName").ToString
                TempRow(0)("UM") = .GetRowValues(RowIndx, "UM").ToString
                TempRow(0)("Quantity") = douQty
                TempRow(0)("UnitPrice") = douPrice
                TempRow(0)("Amount") = Amount
                TempRow(0)("UnitMargin") = margin
                TempRow(0)("CostPrice") = douCost
                TempRow(0)("TotalMargin") = totaMargin
                TempRow(0)("ExpiryDate") = .GetRowValues(RowIndx, "ExpiryDate").ToString
                TempRow(0)("BatchNumber") = .GetRowValues(RowIndx, "BatchNumber").ToString
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
        txtQtyInStock.Value = 0.0#
        txtTotalStock.Value = 0.0#
        txtQuantity.Text = 0.0#
        'txtCashPaid.Text = 0.0#

        GridViewTempReceipt.DataSource = Session("TempReceipt")
        GridViewTempReceipt.DataBind()
        ItemCount()
    End Sub

    Protected Sub GridViewTempReceipt_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles GridViewTempReceipt.DataBound
        Dim gridView As ASPxGridView = TryCast(sender, ASPxGridView)
        GridViewTempReceipt.JSProperties("cpSummary") = GridViewTempReceipt.GetTotalSummaryValue(GridViewTempReceipt.TotalSummary("Amount"))
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
        If Val(VB6.Format(txtQuantity.Text, "##0.#0")) > Val(VB6.Format(txtQtyInStock.Text, "##0.#0")) Then lblErrMsgItem.Text = ("Please, the Quantity is More than Quantity in Stock") : lblErrMsgItem.Visible = True : txtQuantity.Focus() : Exit Sub

        Call AddToList()
        Call ItemCount()

    End Sub

    Private Sub cboSite_ValueChanged(sender As Object, e As EventArgs) Handles cboSite.ValueChanged
        Call CheckUserSession()
        CreateTempReceipt()
    End Sub

    Private Sub GridViewTempReceipt_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTempReceipt.CustomButtonCallback
        'On Error Resume Next

        Select Case e.ButtonID

            Case "cmdRemove"

                Call CheckUserSession()
                If GridViewTempReceipt.VisibleRowCount = 0 Then Exit Sub

                With GridViewTempReceipt
                    Dim rowIndex As Integer = .FocusedRowIndex
                    If rowIndex = -1 Then Exit Sub

                    Session("TempReceipt").DefaultView.Delete(rowIndex)

                End With

                GridViewTempReceipt.DataSource = Session("TempReceipt")
                GridViewTempReceipt.DataBind()

        End Select
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Try
            If GridLookupSuppliers.Text = "" Then GridLookupSuppliers.Focus() : Exit Sub
            If GridViewTempReceipt.VisibleRowCount = 0 Then Exit Sub
            intPaid = 1

            'If Val(VB6.Format$(Me.txtCashPaid.Text, "##0.#0")) = 0 Then 
            '    intPaid = 1
            '    Dim resss
            '    resss = MsgBox("Please do you want save the Receipt without receiving the Cash ", vbYesNo + vbCritical)
            '    If resss = vbNo Then Exit Sub
            '    intPaid = 0
            '    GoTo 20
            'End If

            'If Val(VB6.Format(txtCashPaid.Text, "##0.#0")) = 0 Then MsgBox("Please Enter The Cash Paid") : txtCashPaid.Focus() : Exit Sub
            Dim TotalReceiptItm As DevExpress.Web.ASPxSummaryItem = GridViewTempReceipt.TotalSummary("Amount")
            Dim TotalReceipt As Double = Convert.ToDouble(GridViewTempReceipt.GetTotalSummaryValue(TotalReceiptItm))

            AddReceipt()

        Catch ex As Exception
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Private Sub AddReceipt()
        'On Error Resume Next
        Try
            Dim intSiteID As Integer = 0, intPaymentModeID As Integer = 0, intSupplierID As Integer = 0

            Dim TotalReceiptItm As DevExpress.Web.ASPxSummaryItem = GridViewTempReceipt.TotalSummary("Amount")
            Dim TotalReceipt As Double = Convert.ToDouble(GridViewTempReceipt.GetTotalSummaryValue(TotalReceiptItm))


            If cboSite.Text <> "" Then intSiteID = cboSite.Value
            If GridLookupSuppliers.Text <> "" Then intSupplierID = GridLookupSuppliers.Value

            Dim ItmCount As Integer = 0
            Dim ItmItemID As Long = 0
            Dim ItmUM As String = ""
            Dim ItmExpiryDate As String = ""
            Dim ItmBatchNumber As String = ""
            Dim ItmQuantity As Double = 0
            Dim ItmPrice As Double = 0
            Dim ItmAmount As Double = 0
            Dim ItmUnitMargin As Double = 0
            Dim ItmCostPrice As Double = 0
            Dim ItmTotalMargin As Double = 0
            Dim strQuery As String = ""

            strQuery = "EXEC usp_POSReceipt_Insert " &
                "@ReceiptCode='" & txtTransactionCode.Text & "'," &
                "@ReceiptDate='" & VB6.Format(dtpReceiptDate.Value.Date, "dd-MMM-yyyy") & "'," &
                "@TransactionTypeID=2, " &
                "@SupplierID=" & intSupplierID & "," &
                "@SiteID=" & intSiteID & "," &
                "@TotalAmount=" & TotalReceipt & "," &
                "@CashPaid=" & 0 & "," &
                "@Balance=" & 0 & "," &
                "@Paid=" & 1 & "," &
                "@PaymentModeID=" & 0 & "," &
                "@PaymentDetails='" & "" & "'," &
                "@ItemReceivedBy=''," &
                "@ItemReceivedByPhoneNumber=''," &
                "@ItemReceivedByVehicleNumber=''," &
                "@UserID=" & Session("UserID")

            With GridViewTempReceipt

                For i = 0 To .VisibleRowCount - 1

                    ItmExpiryDate = .GetRowValues(i, "ExpiryDate").ToString
                    ItmBatchNumber = .GetRowValues(i, "BatchNumber").ToString
                    ItmUM = .GetRowValues(i, "UM").ToString
                    ItmItemID = .GetRowValues(i, "ItemID")
                    ItmCount = .GetRowValues(i, "NCount")
                    ItmQuantity = .GetRowValues(i, "Quantity")
                    ItmPrice = .GetRowValues(i, "UnitPrice")
                    ItmAmount = .GetRowValues(i, "Amount")
                    ItmUnitMargin = .GetRowValues(i, "UnitMargin")
                    ItmCostPrice = .GetRowValues(i, "CostPrice")
                    ItmTotalMargin = .GetRowValues(i, "TotalMargin")

                    strQuery = strQuery & " EXEC usp_POSReceiptDetails_Insert " &
                    "@ReceiptCode='" & txtTransactionCode.Text.Trim.ToUpper & "'," &
                    "@SiteID=" & intSiteID & "," &
                    "@ItemID=" & ItmItemID & "," &
                    "@ExpiryDate='" & ItmExpiryDate & "'," &
                    "@BatchNumber='" & ItmBatchNumber & "'," &
                    "@UM='" & ItmUM & "'," &
                    "@NCount=" & ItmCount & "," &
                    "@Quantity=" & ItmQuantity & "," &
                    "@UnitPrice=" & ItmPrice & "," &
                    "@Amount=" & ItmAmount & "," &
                    "@UnitMargin=" & ItmUnitMargin & "," &
                    "@CostPrice=" & ItmCostPrice & "," &
                    "@TotalMargin=" & ItmTotalMargin & "," &
                    "@UserID=" & Session("UserID")

                Next
            End With

            ExecuteMyQuery(strQuery)

            'PopupSave.ShowOnPageLoad = False
            intGenReceiptType = 1
            PrintReceiptReceipt(txtTransactionCode.Text.Trim.ToUpper)
            PopupPrintReceipt.ShowOnPageLoad = True


            Call EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Receipt Successfully Completed"

        Catch ex As Exception
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try
    End Sub


    Private Sub PrintReceiptReceipt(ByVal strReceiptNumber As String)
        On Error Resume Next
        Call CheckUserSession()
        'Dim intPriner As Integer = 0
        'If intPriner = 1 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptPOS
        '    report.Parameters("ReceiptCode").Value = strReceiptNumber
        '    rptViewerReceipt.OpenReport(report)

        'ElseIf intPriner = 2 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptA5
        '    report.Parameters("ReceiptCode").Value = strReceiptNumber
        '    rptViewerReceipt.OpenReport(report)
        'ElseIf intPriner = 3 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptA5
        '    report.Parameters("ReceiptCode").Value = strReceiptNumber
        '    rptViewerReceipt.OpenReport(report)
        'End If
    End Sub
    Private Sub PrintReceiptReReceipt(ByVal intReceiptID As Long)

        'On Error Resume Next
        'Call CheckUserSession()
        'Dim intPriner As Integer = 0
        'If intPriner = 1 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptPOSReprint
        '    report.Parameters("ReceiptID").Value = intReceiptID
        '    rptViewerReceipt.OpenReport(report)

        'ElseIf intPriner = 2 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptA5Reprint
        '    report.Parameters("ReceiptID").Value = intReceiptID
        '    rptViewerReceipt.OpenReport(report)
        'ElseIf intPriner = 3 Then
        '    Dim report As New XtraRptPOSCashReceiptReceiptA5Reprint
        '    report.Parameters("ReceiptID").Value = intReceiptID
        '    rptViewerReceipt.OpenReport(report)
        'End If
    End Sub

    Private Sub cashReceipt_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        If cboSite.Items.Count = 1 Then cboSite.SelectedIndex = 0

    End Sub

    Protected Sub cmdViewReceipt_Click()
        Call CheckUserSession()
        intReceiptID = 0
        Dim intReceiptIDTypeID = 0
        If GridViewReceipt.VisibleRowCount = 0 Then Exit Sub

        With GridViewReceipt
            Dim rowIndex As Integer = .FocusedRowIndex

            intReceiptID = CLng(.GetRowValues(rowIndex, "ReceiptID").ToString)
        End With
        If intReceiptID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_POSReceipt WHERE ReceiptID='{0}'", intReceiptID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtReceiptViewReceiptID.Text = .Item("ReceiptID").ToString
                txtReceiptViewDate.Text = VB6.Format(.Item("ReceiptDate").ToString, "dd-MMM-yyyy")
                txtReceiptViewSite.Text = .Item("SiteName").ToString
                txtReceiptViewReceiptNo.Text = .Item("ReceiptReceiptNo").ToString
                txtReceiptViewPaymentStatus.Text = .Item("PaymentStatus").ToString
                txtReceiptViewPaymentMode.Text = .Item("PaymentMode").ToString
                txtReceiptViewPaymentDetails.Text = .Item("PaymentDetails").ToString
                txtReceiptViewAmountPaid.Text = .Item("CashPaid").ToString
                txtReceiptViewBalance.Text = .Item("Balance").ToString
                txtReceiptViewTotalAmount.Text = .Item("TotalReceipt").ToString
                If CInt(.Item("Paid")).ToString = 1 Then
                    txtReceiptViewPaymentStatus.ForeColor = Color.DarkGreen
                ElseIf CInt(.Item("Paid")).ToString = 0 Then
                    txtReceiptViewPaymentStatus.ForeColor = Color.Red

                End If

            End With

            popupViewReceipt.ShowOnPageLoad = True
        End If



    End Sub
    Private Sub EmptyView()
        txtReceiptViewReceiptID.Text = 0
        txtReceiptViewSite.Text = ""
        txtReceiptViewPaymentMode.Text = ""
        txtReceiptViewPaymentDetails.Text = ""
        txtReceiptViewAmountPaid.Text = 0
        txtReceiptViewBalance.Text = 0
    End Sub

    Private Sub cmdViewReprint_Click(sender As Object, e As EventArgs) Handles cmdViewReprint.Click
        On Error Resume Next
        Call CheckUserSession()
        intGenReceiptType = 2

        PrintReceiptReReceipt(CLng(txtReceiptViewReceiptID.Text.Trim.ToUpper))
        PopupPrintReceipt.ShowOnPageLoad = True


    End Sub

    Private Sub cmdConfirmCancelYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmCancelYes.Click
        Call CheckUserSession()
        If txtReceiptViewReceiptID.Text = 0 Then Exit Sub
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
            objCommand.CommandText = "Usp_POSReceipt_CancelByReceiptID"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ReceiptID", CLng(Val(txtReceiptViewReceiptID.Text))))
                .Add(New SqlParameter("@CanceledDate", VB6.Format(dtpReceiptCanceledDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@CancelRemark", txtRetrunRemark.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            intGenReceiptType = 3
            PrintReceiptReReceipt(CLng(txtReceiptViewReceiptID.Text.Trim.ToUpper))
            PopupPrintReceipt.ShowOnPageLoad = True

            lblErrMsgCancel.ClientVisible = False
            lblSuccessMsgCancel.ClientVisible = True
            lblSuccessMsgCancel.Text = "Invoice Successfully Canceled"

            popupCancelReceipt.ShowOnPageLoad = False
            popupViewReceipt.ShowOnPageLoad = False
            popupAddReceipt.ShowOnPageLoad = False

            EmptyFields()

        Catch ex As Exception
            lblErrMsgCancel.ClientVisible = False
            lblErrMsgCancel.ClientVisible = True
            lblErrMsgCancel.Text = (ex.Message)
        End Try
    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        'Call CheckUserSession()
        'SqlDataSourceReceipt.DataBind()
        'GridViewReceipt.DataBind()
    End Sub

    Private Sub cmdViewPrintWaybill_Click(sender As Object, e As EventArgs) Handles cmdViewPrintWaybill.Click
        'Call CheckUserSession()
        'Dim report As New XtraRptCashReceiptWayBill
        'report.Parameters("ReceiptID").Value = CLng(txtReceiptViewReceiptID.Text.Trim.ToUpper)
        'rptViewerReceipt.OpenReport(report)
        'PopupPrintReceipt.ShowOnPageLoad = True

    End Sub

    Private Sub cmdViewReport_Click(sender As Object, e As EventArgs) Handles cmdViewReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptPOSSupplierReceipt

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_SupplierPOSReceipt_RPTByDate @DateFrom='{0}',@DateTo='{1}' ", txtSearchDateFrom.Text, txtSearchDateTo.Text)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "SupplierPOSReceipt.pdf")
        End Using

    End Sub

    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub

End Class