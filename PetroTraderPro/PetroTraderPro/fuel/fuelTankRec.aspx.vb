Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class fuelTankRec

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
        Dim DateCurrendDate As Date
        DateCurrendDate = CDate(StrCurrentDate)

        If Session("RoleID42") = True Then
            DateCurrendDate = DateAdd(DateInterval.Day, -1, DateCurrendDate)
        End If

        dtpReceiptDateAdd.MaxDate = DateCurrendDate
        dtpReceiptDateAdd.Value = DateCurrendDate

        dtpReceiptDateEdit.MaxDate = DateCurrendDate
        dtpReceiptDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        SqlDataSourceSites.DataBind()
        SqlDataSourceSearchSite.DataBind()

        cboSiteAdd.DataBind()
        cboSiteEdit.DataBind()
        cboSiteSearch.DataBind()

        cboSiteAdd.SelectedIndex = -1
        cboSiteEdit.SelectedIndex = -1
        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0

        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0
        If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value
        'GridUpdate()
        EmptyAdd1()

        If Session("RoleID1") = False Then dtpReceiptDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpReceiptDateEdit.ClientEnabled = False

        'Fuel Receipt
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=4"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID4Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID4Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID4Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID4View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID4Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID4Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID4Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID4View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID4View") = False Then cmdViewReceiptReport.ClientEnabled = False


        SqlDataSourceReceipt.DataBind()
        GridViewReceipt.DataBind()



    End Sub


    Private Sub EmptyAdd()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""


        cboSiteAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtShortageAdd.Value = 0
        txtOverAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtInvoiceNumberAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverAdd.Text = ""
        txtTransporterAdd.Text = ""
        txtRemarksAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub
    Private Sub EmptyAdd1()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()

        cboTankAdd.SelectedIndex = -1
        txtTransactionCode.Text = GenerateTransactionCode()

    End Sub


    Private Sub EmptyRec()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        txtQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtShortageAdd.Value = 0
        txtOverAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtInvoiceNumberAdd.Text = ""
        txtVehicleNumberAdd.Text = ""
        txtDriverAdd.Text = ""
        txtTransporterAdd.Text = ""
        txtRemarksAdd.Text = ""
        SqlDataSourceReceipt.DataBind()
        GridViewReceipt.DataBind()

    End Sub

    Private Sub EmptyView()

        txtSiteNameView.Text = ""
        txtTankView.Text = ""
        txtQuantityView.Value = 0
        txtUnitPriceView.Value = 0
        txtShortageView.Value = 0
        txtOverView.Value = 0
        txtNetQuantityView.Value = 0
        txtAmountView.Value = 0
        txtInvoiceNumberView.Text = ""
        txtVehicleNumberView.Text = ""
        txtDriverView.Text = ""
        txtTransporterView.Text = ""
        txtRemarksView.Text = ""
    End Sub

    Private Sub EmptyEdit()

        cboSiteEdit.SelectedIndex = -1
        cboTankEdit.SelectedIndex = -1
        txtQuantityEdit.Value = 0
        txtUnitPriceEdit.Value = 0
        txtShortageEdit.Value = 0
        txtOverEdit.Value = 0
        txtNetQuantityEdit.Value = 0
        txtAmountEdit.Value = 0
        txtInvoiceNumberEdit.Text = ""
        txtVehicleNumberEdit.Text = ""
        txtDriverEdit.Text = ""
        txtTransporterEdit.Text = ""
        txtRemarksEdit.Text = ""
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboTankAdd.Text <> "" Then intTankID = cboTankAdd.Value

            'txtQuantityAdd.Value = (Qty)
            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelTankReceipt_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ReceiptDate", VB6.Format(dtpReceiptDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@ReceiptCode", txtTransactionCode.TEXT))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@Quantity", txtNetQuantityAdd.Value))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceAdd.Value))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@Shortage", txtShortageAdd.Value))
                .Add(New SqlParameter("@Overs", txtOverAdd.Value))
                .Add(New SqlParameter("@QuantityDischarged", txtNetQuantityAdd.Value))
                .Add(New SqlParameter("@InvoiceNo", txtInvoiceNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Trasporter", txtTransporterAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@DriverName", txtDriverAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Remark", txtRemarksAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1

            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Receipt Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub
    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()
        If CInt(txtReceiptIDEdit.Value) = 0 Then Exit Sub
        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0


        Try

            If cboTankEdit.Text <> "" Then intTankID = cboTankEdit.Value

            'txtQuantityEdit.Value = (Qty)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelTankReceipt_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ReceiptID", CInt(Val(txtReceiptIDEdit.Text))))
                .Add(New SqlParameter("@ReceiptDate", VB6.Format(dtpReceiptDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@Quantity", txtNetQuantityEdit.Value))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceEdit.Value))
                .Add(New SqlParameter("@Amount", txtAmountEdit.Value))
                .Add(New SqlParameter("@Shortage", txtShortageEdit.Value))
                .Add(New SqlParameter("@Overs", txtOverEdit.Value))
                .Add(New SqlParameter("@QuantityDischarged", txtNetQuantityEdit.Value))
                .Add(New SqlParameter("@InvoiceNo", txtInvoiceNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Trasporter", txtTransporterEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@DriverName", txtDriverEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Remark", txtRemarksEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1

            EmptyEdit()
            EmptyView()
            SqlDataSourceReceipt.DataBind()
            GridViewReceipt.DataBind()
            popupEditReceipt.ShowOnPageLoad = False
            popupViewReceipt.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdViewReceipt_Click()
        Call CheckUserSession()
        intReceiptID = 0
        If GridViewReceipt.VisibleRowCount = 0 Then Exit Sub

        With GridViewReceipt
            Dim rowIndex As Integer = .FocusedRowIndex

            intReceiptID = CLng(.GetRowValues(rowIndex, "ReceiptID").ToString)
        End With
        If intReceiptID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelTankReceipt WHERE ReceiptID='{0}'", intReceiptID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            popupViewReceipt.ShowOnPageLoad = True
            With dt.Rows(0)
                txtReceiptIDView.Text = .Item("ReceiptID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtReceiptDateView.Text = VB6.Format(.Item("ReceiptDate").ToString, "dd-MMM-yyyy")
                txtTankView.Text = .Item("TankCode").ToString
                txtQuantityView.Value = .Item("Quantity").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtShortageView.Value = .Item("Shortage").ToString
                txtOverView.Value = .Item("Overs").ToString
                txtNetQuantityView.Value = .Item("QuantityDischarged").ToString
                txtAmountView.Value = .Item("Amount").ToString
                txtInvoiceNumberView.Text = .Item("InvoiceNo").ToString
                txtVehicleNumberView.Text = .Item("VehicleNo").ToString
                txtDriverView.Text = .Item("DriverName").ToString
                txtTransporterView.Text = .Item("Trasporter").ToString
                txtRemarksView.Text = .Item("Remark").ToString

            End With

        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceReceipt.DataBind()
        GridViewReceipt.DataBind()
    End Sub

    Private Sub cboSite_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
        cboSiteAdd.DataBind()
        EmptyAdd1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intReceiptID = 0
        intReceiptID = 0
        intReceiptID = CInt(Val(txtReceiptIDView.Text))
        If intReceiptID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelTankReceipt WHERE ReceiptID={0}", intReceiptID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewReceipt.ShowOnPageLoad = False

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intReceiptID = 0
        Dim intReceiptIDTypeID = 0
        If txtReceiptIDView.Text = 0 Then Exit Sub


        intReceiptID = CLng(Val(txtReceiptIDView.Text))
        If intReceiptID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelTankReceipt WHERE ReceiptID='{0}'", intReceiptID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtReceiptIDEdit.Text = .Item("ReceiptID").ToString
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                dtpReceiptDateEdit.Value = CDate(VB6.Format(.Item("ReceiptDate").ToString, "dd-MMM-yyyy"))

                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                cboTankEdit.Value = CInt(.Item("TankID").ToString)
                txtQuantityEdit.Value = .Item("Quantity").ToString
                txtUnitPriceEdit.Value = .Item("UnitPrice").ToString
                txtShortageEdit.Value = .Item("Shortage").ToString
                txtOverEdit.Value = .Item("Overs").ToString
                txtNetQuantityEdit.Value = .Item("QuantityDischarged").ToString
                txtAmountEdit.Value = .Item("Amount").ToString
                txtInvoiceNumberEdit.Text = .Item("InvoiceNo").ToString
                txtVehicleNumberEdit.Text = .Item("VehicleNo").ToString
                txtDriverEdit.Text = .Item("Trasporter").ToString
                txtTransporterEdit.Text = .Item("DriverName").ToString
                txtRemarksEdit.Text = .Item("Remark").ToString


            End With

            popupEditReceipt.ShowOnPageLoad = True
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

    Private Sub cmdViewReceiptReport_Click(sender As Object, e As EventArgs) Handles cmdViewReceiptReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelTankReciept
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelTankReceipt_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "FuelReceipt.pdf")
        End Using


    End Sub
    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        If cboSiteSearch.Text = "" Then Exit Sub
        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()
    End Sub

    Private Sub cboSiteEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteEdit.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        If cboSiteSearch.Text = "" Then Exit Sub
        SqlDataSourceTanksEdit.DataBind()
        cboTankEdit.DataBind()
    End Sub

    Private Sub GridViewReceipt_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewReceipt.CustomButtonCallback
        Call cmdViewReceipt_Click()
    End Sub
End Class