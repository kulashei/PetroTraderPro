Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class cusFuelSales

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
        Dim DateCurrendDate As Date
        DateCurrendDate = CDate(StrCurrentDate)

        If Session("RoleID42") = True Then
            DateCurrendDate = DateAdd(DateInterval.Day, -1, DateCurrendDate)
        End If

        dtpSalesDateAdd.MaxDate = DateCurrendDate
        dtpSalesDateAdd.Value = DateCurrendDate

        dtpSalesDateEdit.MaxDate = DateCurrendDate
        dtpSalesDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0

            cboSiteAdd.SelectedIndex = -1
        txtTransactionCode.Text = GenerateTransactionCode()

        EmptyAdd()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        'cboSite.SelectedIndex = 0
        'SqlDataSourceProduct.SelectParameters(0) = cboSite.Value
        SqlDataSourceSites.DataBind()
        SqlDataSourceProduct.DataBind()
        SqlDataSourceCustomerAdd.DataBind()
        cboSiteAdd.DataBind()
        GridLookUpCustomerAdd.DataBind()
        GridLookupProductAdd.DataBind()


        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0

        If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        ' Fuel Consumption
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=13"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID13Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID13Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID13Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID13View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID13Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID13Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID13Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID13View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID13View") = False Then cmdViewSalesReport.ClientEnabled = False


    End Sub


    Private Sub EmptyAdd()

        cboSiteAdd.SelectedIndex = -1
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.GridView.Width = 400
        GridLookupProductAdd.Value = Nothing
        GridLookUpCustomerAdd.Text = ""

        txtUnitPriceAdd.Text = 0
        txtVehicleNumberAdd.Text = ""
        txtReceiptNumberAdd.Text = ""
        txtAmountAdd.Value = 0
    End Sub
    Private Sub EmptyAdd1()
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.GridView.Width = 400
        GridLookupProductAdd.Value = Nothing
        GridLookUpCustomerAdd.Text = ""

        txtUnitPriceAdd.Text = 0
        txtVehicleNumberAdd.Text = ""
        txtReceiptNumberAdd.Text = ""
        txtAmountAdd.Value = 0
    End Sub

    Private Sub EmptyAdd2()
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.GridView.Width = 400
        GridLookupProductAdd.Value = Nothing
        GridLookUpCustomerAdd.Text = ""

        txtUnitPriceAdd.Text = 0
        txtVehicleNumberAdd.Text = ""
        txtReceiptNumberAdd.Text = ""
        txtAmountAdd.Value = 0
        lblErrMsgGen.Text = ""
    End Sub

    Private Sub EmptyRec()
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.Text = ""
        GridLookupProductAdd.GridView.Width = 400
        GridLookupProductAdd.Value = Nothing
        GridLookUpCustomerAdd.Text = ""

        txtUnitPriceAdd.Text = 0
        txtVehicleNumberAdd.Text = ""
        txtReceiptNumberAdd.Text = ""
        txtAmountAdd.Value = 0

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

    End Sub

    Private Sub EmptyView()

        txtSalesIDView.Text = 0
        txtSiteNameView.Text = ""
        txtSalesDateView.Text = ""
        txtProductView.Text = ""
        txtCustomerView.Text = ""

        txtUnitPriceView.Text = 0
        txtVehicleNumberView.Text = ""
        txtReceiptNumberView.Text = ""
        txtAmountView.Value = 0

        txtUnitPriceView.Value = 0
        txtAmountView.Value = 0
    End Sub

    Private Sub EmptyEdit()

        txtSalesIDEdit.Text = 0
        txtSiteIDEdit.Text = 0
        cboSiteEdit.SelectedIndex = -1
        GridLookupProductEdit.Text = ""
        GridLookupProductEdit.Text = ""
        GridLookupProductEdit.GridView.Width = 400
        GridLookupProductEdit.Value = Nothing
        GridLookUpCustomerEdit.Text = ""

        txtUnitPriceEdit.Text = 0
        txtVehicleNumberEdit.Text = ""
        txtReceiptNumberEdit.Text = ""
        txtAmountEdit.Value = 0
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intProductID As Integer = 0, intCustomerID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If GridLookupProductAdd.Text <> "" Then intProductID = GridLookupProductAdd.Value
            If GridLookUpCustomerAdd.Text <> "" Then intCustomerID = GridLookUpCustomerAdd.Value

            Dim amount = Val(VB6.Format(CDbl(txtAmountAdd.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceAdd.Value), "##0.###0"))
            If price = 0 Then Exit Sub

            Dim Qty = Val(VB6.Format(amount / price, "##0.#0"))


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelCustomerSupply_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@ProductID", intProductID))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ReceiptNo", txtReceiptNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceAdd.Value))
                .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1

            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Sales Successfully Registered"


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

        Dim intSiteID As Integer = 0, intProductID As Integer = 0, intCustomerID As Integer = 0

        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If GridLookupProductEdit.Text <> "" Then intProductID = GridLookupProductEdit.Value
            If GridLookUpCustomerEdit.Text <> "" Then intCustomerID = GridLookUpCustomerEdit.Value

            Dim amount = Val(VB6.Format(CDbl(txtAmountEdit.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceEdit.Value), "##0.###0"))
            If price = 0 Then Exit Sub

            Dim Qty = Val(VB6.Format(amount / price, "##0.#0"))


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelCustomerSupply_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesID", CInt(Val(txtSalesIDEdit.Text.ToString))))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@ProductID", intProductID))
                .Add(New SqlParameter("@VehicleNo", txtVehicleNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ReceiptNo", txtReceiptNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceEdit.Value))
                .Add(New SqlParameter("@Amount", txtAmountEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            EmptyEdit()
            EmptyView()
            SqlDataSourceSales.DataBind()
            GridViewSales.DataBind()
            popupEditSales.ShowOnPageLoad = False
            popupViewSales.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelCustomerSupply WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtProductView.Text = .Item("ProductCode").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtCustomerView.Text = .Item("CustomerName").ToString
                txtVehicleNumberView.Value = .Item("VehicleNo").ToString
                txtReceiptNumberView.Value = .Item("ReceiptNo").ToString
                txtAmountView.Value = .Item("Amount").ToString

            End With

            popupViewSales.ShowOnPageLoad = True
        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()
    End Sub

    Private Sub cboSite_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
        SqlDataSourceProduct.DataBind()
        cboSiteAdd.DataBind()
        GridLookupProductAdd.Text = ""
        EmptyAdd1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intSalesID = 0
        intSalesID = 0
        intSalesID = CInt(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelCustomerSupply WHERE SalesID={0}", intSalesID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewSales.ShowOnPageLoad = False

    End Sub

    Private Sub GridLookupProduct_ValueChanged(sender As Object, e As EventArgs) Handles GridLookupProductAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        'If fEdit = True Then Exit Sub
        If fLoad = True Then Exit Sub
        If GridLookupProductAdd.Text = "" Then Exit Sub
        'Load Fuel Price
        On Error Resume Next
        If GridLookupProductAdd.GridView.VisibleRowCount = 0 Then Exit Sub

        With GridLookupProductAdd.GridView
            Dim rowIndex As Integer = .FocusedRowIndex
            If rowIndex = -1 Then Exit Sub

            txtUnitPriceAdd.Text = 0
            txtUnitPriceAdd.Text = .GetRowValues(rowIndex, "Rate").ToString()
        End With


    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If txtSalesIDView.Text = 0 Then Exit Sub


        intSalesID = CLng(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelCustomerSupply WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtSalesIDEdit.Text = .Item("SalesID").ToString
                dtpSalesDateEdit.Value = CDate(VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy"))
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                GridLookUpCustomerEdit.Value = CInt(.Item("CustomerID").ToString)
                GridLookupProductEdit.Value = CInt(.Item("ProductID").ToString)
                txtVehicleNumberEdit.Text = .Item("VehicleNo").ToString
                txtReceiptNumberEdit.Text = .Item("ReceiptNo").ToString
                txtUnitPriceEdit.Value = .Item("UnitPrice").ToString
                txtAmountEdit.Value = .Item("Amount").ToString

            End With

            popupEditSales.ShowOnPageLoad = True
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

    Private Sub cmdViewSalesReport_Click(sender As Object, e As EventArgs) Handles cmdViewSalesReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelCustomerSupply
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelCustomerSupply_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
            'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
            report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

            Using ms As New MemoryStream()
                report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
                WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelSales.pdf")
            End Using


        End Sub

    Private Sub GridViewSales_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewSales.CustomButtonCallback
        Call CheckUserSession()
        intSalesID = 0

        If GridViewSales.VisibleRowCount = 0 Then Exit Sub

        With GridViewSales
            Dim rowIndex As Integer = .FocusedRowIndex

            intSalesID = CLng(.GetRowValues(rowIndex, "SalesID").ToString)
        End With
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelCustomerSupply WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtProductView.Text = .Item("ProductCode").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtCustomerView.Text = .Item("CustomerName").ToString
                txtVehicleNumberView.Value = .Item("VehicleNo").ToString
                txtReceiptNumberView.Value = .Item("ReceiptNo").ToString
                txtAmountView.Value = .Item("Amount").ToString

            End With

            popupViewSales.ShowOnPageLoad = True
        End If


    End Sub
End Class