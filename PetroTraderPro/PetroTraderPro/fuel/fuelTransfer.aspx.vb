Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class fuelTransfer

    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intTransferID As Long

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

        If Session("RoleID42") = True Then
            DateCurrendDate = DateAdd(DateInterval.Day, -1, DateCurrendDate)
        End If

        dtpTransferDateAdd.MaxDate = DateCurrendDate
        dtpTransferDateAdd.Value = DateCurrendDate

        dtpTransferDateEdit.MaxDate = DateCurrendDate
        dtpTransferDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0

        cboSiteFromAdd.SelectedIndex = -1
        cboSiteToAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        GridLookupPumpAdd.GridView.Width = 400
        GridLookupPumpAdd.Value = Nothing
        cboTankAdd.SelectedIndex = 0

        txtAmountAdd.Text = 0
        txtTransactionCode.Text = GenerateTransactionCode()

        If cboSiteFromAdd.Items.Count = 1 Then cboSiteFromAdd.SelectedIndex = 0
        If cboSiteFromEdit.Items.Count = 1 Then cboSiteFromEdit.SelectedIndex = 0
        If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        'cboSite.SelectedIndex = 0
        'SqlDataSourcePump.SelectParameters(0) = cboSite.Value
        SqlDataSourcePump.DataBind()
        cboSiteFromAdd.DataBind()
        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()

        'GridUpdate()
        If Session("RoleID1") = False Then dtpTransferDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpTransferDateEdit.ClientEnabled = False


        ' Fuel Tranfer
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=8"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID8Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID8Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID8Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID8View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID8Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID8Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID8Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID8View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID8View") = False Then cmdViewTransferReport.ClientEnabled = False


    End Sub


    Private Sub EmptyAdd()
        txtWaybillNumberAdd.Text = ""
        cboSiteFromAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        cboSiteToAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRequestedByAdd.Text = ""
        txtReceivedByAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverNameAdd.Text = ""
    End Sub
    Private Sub EmptyAdd1()
        cboSiteFromAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        cboSiteToAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRequestedByAdd.Text = ""
        txtReceivedByAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverNameAdd.Text = ""
    End Sub

    Private Sub EmptyAdd2()
        txtWaybillNumberAdd.Text = ""
        cboSiteFromAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        cboSiteToAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRequestedByAdd.Text = ""
        txtReceivedByAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverNameAdd.Text = ""
        'txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        lblErrMsgGen.Text = ""
    End Sub

    Private Sub EmptyRec()
        txtWaybillNumberAdd.Text = ""
        cboSiteFromAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        cboSiteToAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRequestedByAdd.Text = ""
        txtReceivedByAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverNameAdd.Text = ""

        SqlDataSourceTransfer.DataBind()
        GridViewTransfer.DataBind()

    End Sub

    Private Sub EmptyView()

        txtTransferIDView.Text = 0
        txtSiteNameFromView.Text = ""
        txtSiteNameToView.Text = ""
        txtTransferDateView.Text = ""
        txtPumpView.Text = ""
        txtTankView.Text = ""
        txtQuantityView.Value = 0
        txtUnitPriceView.Value = 0
        txtAmountView.Value = 0
        txtRequestedByView.Text = ""
        txtReceivedByView.Text = ""
        txtVehicleNumberView.Text = ""
        txtDriverNameAdd.Text = ""
    End Sub

    Private Sub EmptyEdit()

        txtTransferIDEdit.Text = 0
        txtWaybillNumberEdit.Text = ""
        cboSiteFromEdit.SelectedIndex = -1
        GridLookupPumpEdit.Text = ""
        GridLookupPumpEdit.GridView.Width = 400
        GridLookupPumpEdit.Value = Nothing
        cboSiteToEdit.SelectedIndex = -1
        cboTankEdit.SelectedIndex = -1
        txtQuantityEdit.Value = 0
        txtUnitPriceEdit.Value = 0
        txtAmountEdit.Value = 0
        txtRequestedByEdit.Text = ""
        txtReceivedByEdit.Text = ""
        txtVehicleNumberEdit.Text = ""
        txtDriverNameEdit.Text = ""
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteFromID As Integer = 0, intPumpID As Integer = 0, intSiteToID As Integer = 0, intTankID As Integer = 0


        Try

            If cboSiteFromAdd.Text <> "" Then intSiteFromID = cboSiteFromAdd.Value
            If GridLookupPumpAdd.Text <> "" Then intPumpID = GridLookupPumpAdd.Value
            If cboSiteToAdd.Text <> "" Then intSiteToID = cboSiteToAdd.Value
            If cboTankAdd.Text <> "" Then intTankID = cboTankAdd.Value

            Dim Qty As Double = Val(VB6.Format(CDbl(txtQuantityAdd.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceAdd.Value), "##0.###0"))
            Dim amount = Val(VB6.Format(Qty * price, "##0.#0"))


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelStockTransfer_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransferDate", VB6.Format(dtpTransferDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@TransferCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@WayBillNo", txtWaybillNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PumpID", intPumpID))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceAdd.Value))
                .Add(New SqlParameter("@Amount", amount))
                .Add(New SqlParameter("@RequestedBy", txtRequestedByAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ReceivedBy", txtReceivedByAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@DriverName", txtDriverNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Transfer Successfully Registered"


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

        Dim intSiteFromID As Integer = 0, intPumpID As Integer = 0, intSiteToID As Integer = 0, intTankID As Integer = 0


        Try

            If cboSiteFromEdit.Text <> "" Then intSiteFromID = cboSiteFromEdit.Value
            If GridLookupPumpEdit.Text <> "" Then intPumpID = GridLookupPumpEdit.Value
            If cboSiteToEdit.Text <> "" Then intSiteToID = cboSiteToEdit.Value
            If cboTankEdit.Text <> "" Then intTankID = cboTankEdit.Value

            Dim Qty As Double = Val(VB6.Format(CDbl(txtQuantityEdit.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceEdit.Value), "##0.###0"))
            Dim amount = Val(VB6.Format(Qty * price, "##0.#0"))


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelStockTransfer_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TransferID", txtTransferIDEdit.Text))
                .Add(New SqlParameter("@TransferDate", VB6.Format(dtpTransferDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@WayBillNo", txtWaybillNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PumpID", intPumpID))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceEdit.Value))
                .Add(New SqlParameter("@Amount", amount))
                .Add(New SqlParameter("@RequestedBy", txtRequestedByEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ReceivedBy", txtReceivedByEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@DriverName", txtDriverNameEdit.Text.Trim.ToUpper))
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
        intTransferID = 0
        Dim intTransferIDTypeID = 0
        If GridViewTransfer.VisibleRowCount = 0 Then Exit Sub

        With GridViewTransfer
            Dim rowIndex As Integer = .FocusedRowIndex

            intTransferID = CLng(.GetRowValues(rowIndex, "TransferID").ToString)
        End With
        If intTransferID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelStockTransfer WHERE TransferID='{0}'", intTransferID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtTransferIDView.Text = .Item("TransferID").ToString
                txtTransferDateView.Text = VB6.Format(.Item("TransferDate").ToString, "dd-MMM-yyyy")
                txtSiteNameFromView.Text = .Item("SiteNameFrom").ToString
                txtSiteNameToView.Text = .Item("SiteNameTo").ToString
                txtPumpView.Text = .Item("PumpCode").ToString
                txtTankView.Text = .Item("TankCode").ToString
                txtQuantityView.Value = .Item("Quantity").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtAmountView.Value = .Item("Amount").ToString
                txtRequestedByView.Text = .Item("RequestedBy").ToString
                txtReceivedByView.Text = .Item("ReceivedBy").ToString
                txtVehicleNumberView.Text = .Item("VehicleNo").ToString
                txtDriverNameView.Text = .Item("DriverName").ToString

            End With

            popupViewTransfer.ShowOnPageLoad = True
        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceTransfer.DataBind()
        GridViewTransfer.DataBind()
    End Sub


    Private Sub cboSiteToAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteToAdd.ValueChanged
        Call CheckUserSession()
        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()
        cboTankAdd.Text = ""

    End Sub



    Private Sub cboSiteFromAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteFromAdd.ValueChanged
        Call CheckUserSession()
        SqlDataSourcePump.DataBind()
        GridLookupPumpAdd.DataBind()
        GridLookupPumpAdd.Text = ""
        txtUnitPriceAdd.Value = 0
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intTransferID = 0
        intTransferID = 0
        intTransferID = CInt(Val(txtTransferIDView.Text))
        If intTransferID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelStockTransfer WHERE TransferID={0}", intTransferID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewTransfer.ShowOnPageLoad = False

    End Sub

    Private Sub GridLookupPumpAdd_ValueChanged(sender As Object, e As EventArgs) Handles GridLookupPumpAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        'If fEdit = True Then Exit Sub
        If fLoad = True Then Exit Sub
        If GridLookupPumpAdd.Text = "" Then Exit Sub
        'Load Fuel Price
        On Error Resume Next
        If GridLookupPumpAdd.GridView.VisibleRowCount = 0 Then Exit Sub

        With GridLookupPumpAdd.GridView
            Dim rowIndex As Integer = .FocusedRowIndex
            If rowIndex = -1 Then Exit Sub

            txtUnitPriceAdd.Text = 0
            txtUnitPriceAdd.Text = .GetRowValues(rowIndex, "Rate").ToString()
        End With



    End Sub

    Private Sub GridLookupPumpEdit_ValueChanged(sender As Object, e As EventArgs) Handles GridLookupPumpEdit.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        'If fEdit = True Then Exit Sub
        If fLoad = True Then Exit Sub
        If GridLookupPumpEdit.Text = "" Then Exit Sub
        'Load Fuel Price
        On Error Resume Next
        If GridLookupPumpEdit.GridView.VisibleRowCount = 0 Then Exit Sub

        With GridLookupPumpEdit.GridView
            Dim rowIndex As Integer = .FocusedRowIndex
            If rowIndex = -1 Then Exit Sub

            txtUnitPriceEdit.Text = 0
            txtUnitPriceEdit.Text = .GetRowValues(rowIndex, "Rate").ToString()
        End With



    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intTransferID = 0
        Dim intTransferIDTypeID = 0
        If txtTransferIDView.Text = 0 Then Exit Sub


        intTransferID = CLng(Val(txtTransferIDView.Text))
        If intTransferID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelStockTransfer WHERE TransferID='{0}'", intTransferID)).Tables(0)

        If dt.Rows.Count > 0 Then
            popupEditTransfer.ShowOnPageLoad = True

            EmptyEdit()
            With dt.Rows(0)
                txtTransferIDEdit.Text = .Item("TransferID").ToString
                dtpTransferDateEdit.Value = CDate(.Item("TransferDate").ToString)
                txtWaybillNumberEdit.Text = .Item("WayBillNo").ToString
                cboSiteFromAdd.Value = CInt(.Item("TankID").ToString)
                cboSiteToEdit.Value = CInt(.Item("SiteIDFrom").ToString)
                cboSiteFromEdit.Value = CInt(.Item("SiteIDTo").ToString)
                SqlDataSourcePumpEdit.DataBind()
                SqlDataSourceTanksEdit.DataBind()
                GridLookupPumpEdit.DataBind()
                cboTankEdit.DataBind()
                GridLookupPumpEdit.Value = CInt(.Item("PumpID").ToString)
                cboTankEdit.Value = CInt(.Item("TankID").ToString)
                txtQuantityEdit.Value = .Item("Quantity").ToString
                txtUnitPriceEdit.Value = .Item("UnitPrice").ToString
                txtAmountEdit.Value = .Item("Amount").ToString
                txtRequestedByEdit.Text = .Item("RequestedBy").ToString
                txtReceivedByEdit.Text = .Item("ReceivedBy").ToString
                txtVehicleNumberEdit.Text = .Item("VehicleNo").ToString
                txtDriverNameEdit.Text = .Item("DriverName").ToString


            End With

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
        Dim report As New XtraRptFuelStockTransfer
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelStockTransfer_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelTransfer.pdf")
        End Using


    End Sub

    Private Sub GridViewTransfer_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewTransfer.CustomButtonCallback
        Call cmdViewTransfer_Click()
    End Sub
End Class