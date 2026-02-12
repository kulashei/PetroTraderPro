Imports System.Data.SqlClient
Imports System.IO
Imports DevExpress.XtraPrinting
Imports Microsoft.VisualBasic.Compatibility

Public Class fuelsales
    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intSalesID As Long
    Private dtMetre As DataTable, dtCheck As DataTable
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
        fLoad = True
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

        'dtpSalesDateEdit.MaxDate = DateCurrendDate
        'dtpSalesDateEdit.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        GridLookupPumpAdd.GridView.Width = 400
        GridLookupPumpAdd.Value = Nothing

        'txtOpenMetreAdd.Text = 0
        '    txtClosingMetreAdd.Text = 0
        '    txtQuantityAdd.Text = 0
        '    txtTestQuantityAdd.Text = 0
        '    txtNetQuantityAdd.Text = 0
        '    txtUnitPriceAdd.Text = 0
        '    txtCostPriceAdd.Text = 0
        '    txtAmountAdd.Text = 0
        '    txtTransactionCode.Text = GenerateTransactionCode()


        'lblErrMsgAdd.ClientVisible = False
        '    lblSuccessMsgAdd.clientVisible = False
        '    lblErrMsgAdd.Text = ""
        '    lblSuccessMsgAdd.Text = ""
        SqlDataSourceSites.DataBind()
        SqlDataSourceSearchSite.DataBind()

        cboSiteAdd.DataBind()
        cboSiteSearch.DataBind()

        cboSiteAdd.SelectedIndex = -1
        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0

        'cboSite.SelectedIndex = 0
        'SqlDataSourcePump.SelectParameters(0) = cboSite.Value

        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0
        'GridUpdate()
        EmptyAdd1()

        If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False

        'If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        'Fuel Sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=2"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID2Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID2Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID2Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID2View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID2Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID2Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID2Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID2View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID2View") = False Then cmdViewSalesReport.ClientEnabled = False


        'Change Opening Metre
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=9"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID9Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID9Edit") = False Then txtOpenMetreAdd.ClientEnabled = False
        If Session("RoleID9Edit") = False Then txtOpenMetreEdit.ClientEnabled = False



        'Add Metre Picture
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=59"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID59Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID59Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID59Add") = True Then
            txtAllowedPicAdd.Text = 1
            FormLayoutAdd.FindItemOrGroupByName("GroupImageAdd").ClientVisible = True
        Else
            txtAllowedPicAdd.Text = 0
            FormLayoutAdd.FindItemOrGroupByName("GroupImageAdd").ClientVisible = False
        End If

        If Session("RoleID59Edit") = True Then
            txtAllowedPicEdit.Text = 1
            FormLayoutEdit.FindItemOrGroupByName("GroupImageEdit").ClientVisible = True
        Else
            txtAllowedPicEdit.Text = 0
            FormLayoutEdit.FindItemOrGroupByName("GroupImageEdit").ClientVisible = True

        End If

        'Allow Multilpe Metre Readings per day
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=61"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID61Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID61Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID61Add") = True Then
            txtAllowMultiple.Text = 1
        Else
            txtAllowMultiple.Text = 0
        End If

        If Session("RoleID61Edit") = True Then
            txtAllowMultiple.Text = 1
        Else
            txtAllowMultiple.Text = 0

        End If

        'Dim SS As New fuelConsume
        'SS.Controls.Item

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()
        fLoad = False
    End Sub


    Private Sub EmptyAdd()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        cboSiteAdd.SelectedIndex = -1
        GridLookupPumpAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
        txtOpenMetreAdd.Value = 0
        txtClosingMetreAdd.Value = 0
        txtQuantityAdd.Value = 0
        txtTestQuantityAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
    End Sub
    Private Sub EmptyAdd1()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourcePump.DataBind()
        GridLookupPumpAdd.DataBind()
        SqlDataSourceAttendants.DataBind()
        cboAttendantAdd.DataBind()

        GridLookupPumpAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
        cboAttendantAdd.Text = ""
        txtOpenMetreAdd.Value = 0
        txtClosingMetreAdd.Value = 0
        txtQuantityAdd.Value = 0
        txtTestQuantityAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = ""
        txtUnitPriceAdd.Value = 0
        txtCostPriceAdd.Text = 0

        txtAmountAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        txtFileNameAdd.Text = ""


    End Sub

    Private Sub EmptyAdd2()
        txtOpenMetreAdd.Value = 0
        txtClosingMetreAdd.Value = 0
        txtQuantityAdd.Value = 0
        txtTestQuantityAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        'txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        lblErrMsgGen.Text = ""
    End Sub

    Private Sub EmptyRec()
        GridLookupPumpAdd.Text = ""
        txtOpenMetreAdd.Value = 0
        txtClosingMetreAdd.Value = 0
        txtQuantityAdd.Value = 0
        txtTestQuantityAdd.Value = 0
        txtNetQuantityAdd.Value = 0
        txtUnitPriceAdd.Value = 0
        txtAmountAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        txtFileNameAdd.Text = ""

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

    End Sub

    Private Sub EmptyView()

        txtSalesIDView.Text = 0
        txtSiteNameView.Text = ""
        txtSalesDateView.Text = ""
        txtPumpView.Text = ""
        txtAttendantView.Text = ""
        txtOpenMetreView.Value = 0
        txtClosingMetreView.Value = 0
        txtQuantityView.Value = 0
        txtTestQuantityView.Value = 0
        txtNetQuantityView.Value = 0
        txtUnitPriceView.Value = 0
        txtAmountView.Value = 0
    End Sub

    Private Sub EmptyEdit()

        txtSalesIDEdit.Text = 0
        txtSiteIDEdit.Text = 0
        txtSiteNameEdit.Text = ""
        txtSalesDateEdit.Text = ""
        txtPumpEdit.Text = ""
        txtPumpIDEdit.Text = 0
        cboAttendantEdit.SelectedIndex = -1
        txtOpenMetreEdit.Value = 0
        txtClosingMetreEdit.Value = 0
        txtQuantityEdit.Value = 0
        txtTestQuantityEdit.Value = 0
        txtNetQuantityEdit.Value = 0
        txtUnitPriceEdit.Value = 0

        txtFileNameEdit.Text = ""
        txtAmountEdit.Value = 0

        txtTransactionCodeEdit.Text = ""
        txtFileNameEdit.Text = ""


    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intPumpID As Integer = 0, intAttendantID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If GridLookupPumpAdd.Text <> "" Then intPumpID = GridLookupPumpAdd.Value
            If cboAttendantAdd.Text <> "" Then intAttendantID = cboAttendantAdd.Value

            Dim OpenMetre As Double = Val(VB6.Format(CDbl(txtOpenMetreAdd.Value), "##0.###0"))
            Dim CloseMetre = Val(VB6.Format(CDbl(txtClosingMetreAdd.Value), "##0.###0"))
            Dim TestQty = Val(VB6.Format(CDbl(txtTestQuantityAdd.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceAdd.Value), "##0.###0"))
            Dim Qty = CloseMetre - OpenMetre
            Dim NetQty = Qty - TestQty
            Dim amount = Val(VB6.Format(NetQty * price, "##0.#0"))
            'txtQuantityAdd.Value = (Qty)
            'txtNetQuantityAdd.Value = (NetQty)
            'txtAmountAdd.Value = (amount)

            intPumpID = GridLookupPumpAdd.Value
            Dim STR(1) As String
            STR(0) = String.Format("SELECT * FROM FuelDailySales WHERE PumpID={0} AND SalesDate='{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))
            STR(1) = String.Format("Usp_FuelDailySales_GetPreviousMetreReadings {0},'{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))


            dtCheck = New DataTable
            Dim dtCheckMetre = New DataTable

            Dim dsMany() As DataSet = LoadManyDataSets(STR, 1)
            dtCheck = dsMany(0).Tables(0)
            dtCheckMetre = dsMany(1).Tables(0)

            If dtCheck.Rows.Count > 0 And Val(txtAllowMultiple.Text) = 0 Then

                GridLookupPumpAdd.Text = ""
                PopupErrMsgPump.ShowOnPageLoad = True
                lblErrMsgPump.Text = ("Please Daily Sales for the Pump and this date is entered already")
                GridLookupPumpAdd.Text = ""
                Exit Sub
            End If


            If dtCheckMetre.Rows.Count > 0 Then
                If Val(dtCheckMetre.Rows(0).Item("OpeningMetre")) <> Val(txtOpenMetreAdd.Value) Then
                    If Session("RoleID9Edit") = False Then


                        lblErrMsgPump.Text = ("Please, the Opening Metre you have Entered is not the same as the last Closing Metre") : PopupErrMsgPump.ShowOnPageLoad = True : GridLookupPumpAdd.Text = "" : GridLookupPumpAdd.Focus() : Exit Sub

                    End If
                End If
            End If


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelDailySales_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@PumpID", intPumpID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@OpeningMetre", txtOpenMetreAdd.Value))
                .Add(New SqlParameter("@ClosingMetre", txtClosingMetreAdd.Value))
                .Add(New SqlParameter("@TotalQuantity", Qty.ToString("##0.#0")))
                .Add(New SqlParameter("@TestQuantity", txtTestQuantityAdd.Value))
                .Add(New SqlParameter("@NetQuantity", NetQty.ToString("##0.#0")))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceAdd.Value))
                .Add(New SqlParameter("@Amount", amount.ToString("##0.#0")))
                .Add(New SqlParameter("@CostPrice", txtCostPriceAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            Dim strPicpath As String = "~/fuel/fuelSalesPics/" & txtTransactionCode.Text.ToString & ".jpg"

            If FileUploadPictureAdd.HasFile Then
                FileUploadPictureAdd.SaveAs(Server.MapPath(strPicpath))
            End If


            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Sales Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub
    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()

        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSiteID As Integer = 0, intPumpID As Integer = 0, intAttendantID As Integer = 0

        Try

            Dim intSalesID = 0
            intSalesID = 0
            intSalesID = CInt(Val(txtSalesIDView.Text))
            If intSalesID = 0 Then Exit Sub
            Dim str As String = String.Format("SELECT [dbo].[ufn_FuelDailySales_CheckForExitingPumpLaterDate]({0})  AS RecCount", intSalesID)
            dtTemp = LoadData(str).Tables(0)

            If dtTemp.Rows(0).Item(0) > 0 Then PopupErrMsg.ShowOnPageLoad = True : lblErrMsgGen.Text = ("Sales Can not Deleted When There are Sales in a later date for pump") : Exit Sub

            If cboAttendantEdit.Text <> "" Then intAttendantID = cboAttendantEdit.Value
            intPumpID = txtPumpIDEdit.Value

            Dim OpenMetre As Double = Val(VB6.Format(CDbl(txtOpenMetreEdit.Value), "##0.###0"))
            Dim CloseMetre = Val(VB6.Format(CDbl(txtClosingMetreEdit.Value), "##0.###0"))
            Dim TestQty = Val(VB6.Format(CDbl(txtTestQuantityEdit.Value), "##0.###0"))
            Dim price = Val(VB6.Format(CDbl(txtUnitPriceEdit.Value), "##0.###0"))
            Dim Qty = CloseMetre - OpenMetre
            Dim NetQty = Qty - TestQty
            Dim amount = Val(VB6.Format(NetQty * price, "##0.#0"))
            'txtQuantityEdit.Value = (Qty)
            'txtNetQuantityEdit.Value = (NetQty)
            'txtAmountEdit.Value = (amount)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelDailySales_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(txtSalesDateEdit.Text, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@PumpID", intPumpID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@OpeningMetre", txtOpenMetreEdit.Value))
                .Add(New SqlParameter("@ClosingMetre", txtClosingMetreEdit.Value))
                .Add(New SqlParameter("@TotalQuantity", Qty.ToString("##0.#0")))
                .Add(New SqlParameter("@TestQuantity", txtTestQuantityEdit.Value))
                .Add(New SqlParameter("@NetQuantity", NetQty.ToString("##0.#0")))
                .Add(New SqlParameter("@UnitPrice", txtUnitPriceEdit.Value))
                .Add(New SqlParameter("@Amount", amount.ToString("##0.#0")))
                .Add(New SqlParameter("@CostPrice", txtCostPriceEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            Dim strPicpath As String = "~/fuel/fuelSalesPics/" & txtTransactionCodeEdit.Text.ToString & ".jpg"

            If FileUploadPictureEdit.HasFile Then
                FileUploadPictureEdit.SaveAs(Server.MapPath(strPicpath))
            End If


            EmptyEdit()
            EmptyView()
            SqlDataSourceSales.DataBind()
            GridViewSales.DataBind()
            popupEditSales.ShowOnPageLoad = False
            popupViewSales.ShowOnPageLoad = False

        Catch ex As Exception
            lblErrMsgEdit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelDailySales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtPumpView.Text = .Item("PumpCode").ToString
                txtAttendantView.Text = .Item("AttendantName").ToString
                txtOpenMetreView.Value = .Item("OpeningMetre").ToString
                txtClosingMetreView.Value = .Item("ClosingMetre").ToString
                txtQuantityView.Value = .Item("TotalQuantity").ToString
                txtTestQuantityView.Value = .Item("TestQuantity").ToString
                txtNetQuantityView.Value = .Item("NetQuantity").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtAmountView.Value = .Item("Amount").ToString

                txtTransactionCodeView.Text = .Item("SalesCode").ToString
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
        SqlDataSourcePump.DataBind()
        cboSiteAdd.DataBind()
        GridLookupPumpAdd.Text = ""
        EmptyAdd1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intSalesID = 0
        intSalesID = 0
        intSalesID = CInt(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub
        Dim str As String = String.Format("SELECT [dbo].[ufn_FuelDailySales_CheckForExitingPumpLaterDate]({0})  AS RecCount", intSalesID)
        dtTemp = LoadData(str).Tables(0)

        If dtTemp.Rows(0).Item(0) > 0 Then PopupErrMsg.ShowOnPageLoad = True : lblErrMsgGen.Text = ("Sales Can not Deleted When There are Sales in a later date for pump") : Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelDailySales WHERE SalesID={0}", intSalesID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewSales.ShowOnPageLoad = False

    End Sub

    Private Sub GridLookupPump_ValueChanged(sender As Object, e As EventArgs) Handles GridLookupPumpAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        'If fEdit = True Then Exit Sub
        If fLoad = True Then Exit Sub
        If GridLookupPumpAdd.Text = "" Then Exit Sub
        If dtpSalesDateAdd.Text = "" Then Exit Sub

        'Load Fuel Price
        On Error Resume Next
        If GridLookupPumpAdd.GridView.VisibleRowCount = 0 Then Exit Sub

        With GridLookupPumpAdd.GridView
            Dim rowIndex As Integer = .FocusedRowIndex
            If rowIndex = -1 Then Exit Sub

            txtUnitPriceAdd.Text = 0
            txtUnitPriceAdd.Text = .GetRowValues(rowIndex, "Rate").ToString()
        End With

        Dim intPumpID As Integer = 0
        intPumpID = GridLookupPumpAdd.Value
        Call EmptyAdd2()
        Dim STR(1) As String
        STR(0) = String.Format("SELECT * FROM FuelDailySales WHERE PumpID={0} AND SalesDate='{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))
        STR(1) = String.Format("Usp_FuelDailySales_GetPreviousMetreReadings {0},'{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))

        Session("dtMetre") = New DataTable
        Session("dtCheck") = New DataTable
        Dim dsMany() As DataSet = LoadManyDataSets(STR, 1)
        Session("dtCheck") = dsMany(0).Tables(0)
        Session("dtMetre") = dsMany(1).Tables(0)

        If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 0 Then

            GridLookupPumpAdd.Text = ""
            PopupErrMsgPump.ShowOnPageLoad = True
            lblErrMsgPump.Text = ("Please Daily Sales for the Pump and this date is entered already")
            GridLookupPumpAdd.Text = ""
            Exit Sub
        End If


        If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 1 Then
            lblMultipleMsg.Text = ("Note: Daily Sales for the Pump and this date is entered already. Do you to enter multiple readings for the day?")
            PopupConfirmMultipleAdd.ShowOnPageLoad = True
            Exit Sub

        End If



        'If Session("RoleID9") = False Then txtOpenMetreAdd.ClientEnabled = False
        'If Session("RoleID9") = False Then txtOpenMetreEdit.ClientEnabled = False

        'EmptySalesRec()
        txtUnitPriceAdd.ReadOnly = True
        If Session("dtMetre").Rows(0).Item("RecCount") = 0 Then
            txtOpenMetreAdd.ClientEnabled = True
            txtOpenMetreAdd.Text = 0
            txtOpenMetreAdd.Focus()
        Else
            Dim nDays As Long = DateDiff(DateInterval.Day, CDate(Session("dtMetre").Rows(0).Item("LastDate").ToString), CDate(VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
            If nDays < 0 Then lblErrMsgPump.Text = ("Please, the Date you have Entered is Earlier Than the last Entry Date") : PopupErrMsgPump.ShowOnPageLoad = True : GridLookupPumpAdd.Text = "" : GridLookupPumpAdd.Focus() : Exit Sub

            txtOpenMetreAdd.Text = Session("dtMetre").Rows(0).Item("OpeningMetre")
            txtOpenMetreAdd.ClientEnabled = False
            txtClosingMetreAdd.Focus()
            If Session("RoleID9Edit") = True Then txtOpenMetreAdd.ClientEnabled = True
        End If

    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If txtSalesIDView.Text = 0 Then Exit Sub


        intSalesID = CLng(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelDailySales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtSalesIDEdit.Text = .Item("SalesID").ToString
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                txtSiteNameEdit.Text = .Item("SiteName").ToString
                txtSalesDateEdit.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtPumpEdit.Text = .Item("PumpCode").ToString
                txtPumpIDEdit.Text = .Item("PumpID").ToString
                cboAttendantEdit.Value = CInt(.Item("AttendantID").ToString)
                txtOpenMetreEdit.Value = .Item("OpeningMetre").ToString
                txtClosingMetreEdit.Value = .Item("ClosingMetre").ToString
                txtQuantityEdit.Value = .Item("TotalQuantity").ToString
                txtTestQuantityEdit.Value = .Item("TestQuantity").ToString
                txtNetQuantityEdit.Value = .Item("NetQuantity").ToString
                txtUnitPriceEdit.Value = .Item("UnitPrice").ToString
                txtAmountEdit.Value = .Item("Amount").ToString

                txtTransactionCodeEdit.Text = .Item("SalesCode").ToString
                picPictureEdit.ImageUrl = "~/fuel/fuelSalesPics/" & .Item("SalesCode").ToString & ".jpg"


            End With
            If Session("RoleID9Edit") = True Then txtOpenMetreEdit.ClientEnabled = True

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
        Dim report As New XtraRptFuelDailySales
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelSales.pdf")
        End Using


    End Sub



    Private Sub dtpSalesDateAdd_ValueChanged(sender As Object, e As EventArgs) Handles dtpSalesDateAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        'If fEdit = True Then Exit Sub
        If fLoad = True Then Exit Sub
        If GridLookupPumpAdd.Text = "" Then Exit Sub
        If dtpSalesDateAdd.Text = "" Then Exit Sub

        'Load Fuel Price
        On Error Resume Next
        If GridLookupPumpAdd.GridView.VisibleRowCount = 0 Then Exit Sub

        With GridLookupPumpAdd.GridView
            Dim rowIndex As Integer = .FocusedRowIndex
            If rowIndex = -1 Then Exit Sub

            txtUnitPriceAdd.Text = 0
            txtUnitPriceAdd.Text = .GetRowValues(rowIndex, "Rate").ToString()
        End With

        Dim intPumpID As Integer = 0
        intPumpID = GridLookupPumpAdd.Value
        Call EmptyAdd2()
        Dim STR(1) As String
        STR(0) = String.Format("SELECT * FROM FuelDailySales WHERE PumpID={0} AND SalesDate='{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))
        STR(1) = String.Format("Usp_FuelDailySales_GetPreviousMetreReadings {0},'{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))


        Session("dtMetre") = New DataTable
        Session("dtCheck") = New DataTable
        Dim dsMany() As DataSet = LoadManyDataSets(STR, 1)
        Session("dtCheck") = dsMany(0).Tables(0)
        Session("dtMetre") = dsMany(1).Tables(0)

        If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 0 Then

            GridLookupPumpAdd.Text = ""
            PopupErrMsgPump.ShowOnPageLoad = True
            lblErrMsgPump.Text = ("Please Daily Sales for the Pump and this date is entered already")
            GridLookupPumpAdd.Text = ""
            Exit Sub
        End If


        If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 1 Then
            lblMultipleMsg.Text = ("Note: Daily Sales for the Pump and this date is entered already. Do you to enter multiple readings for the day?")
            PopupConfirmMultipleAdd.ShowOnPageLoad = True
            Exit Sub

        End If



        'If Session("RoleID9") = False Then txtOpenMetreAdd.ClientEnabled = False
        'If Session("RoleID9") = False Then txtOpenMetreEdit.ClientEnabled = False

        'EmptySalesRec()
        txtUnitPriceAdd.ReadOnly = True
        If Session("dtMetre").Rows(0).Item("RecCount") = 0 Then
            txtOpenMetreAdd.ClientEnabled = True
            txtOpenMetreAdd.Text = 0
            txtOpenMetreAdd.Focus()
        Else
            Dim nDays As Long = DateDiff(DateInterval.Day, CDate(Session("dtMetre").Rows(0).Item("LastDate").ToString), CDate(VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
            If nDays < 0 Then lblErrMsgPump.Text = ("Please, the Date you have Entered is Earlier Than the last Entry Date") : PopupErrMsgPump.ShowOnPageLoad = True : GridLookupPumpAdd.Text = "" : GridLookupPumpAdd.Focus() : Exit Sub

            txtOpenMetreAdd.Text = Session("dtMetre").Rows(0).Item("OpeningMetre")
            txtOpenMetreAdd.ClientEnabled = False
            txtClosingMetreAdd.Focus()
            If Session("RoleID9Edit") = True Then txtOpenMetreAdd.ClientEnabled = True
        End If

    End Sub


    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        If cboSiteSearch.Text = "" Then Exit Sub
        SqlDataSourcePump.DataBind()
        GridLookupPumpAdd.DataBind()

        SqlDataSourceAttendants.DataBind()
        cboAttendantAdd.DataBind()



    End Sub
    'Private Sub cboSiteEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteEdit.ValueChanged
    '    On Error Resume Next
    '    Call CheckUserSession()
    '    If cboSiteSearch.Text = "" Then Exit Sub
    '    SqlDataSourcePumpedit.DataBind()
    '    GridLookupPumpAdd.DataBind()

    '    SqlDataSourceAttendants.DataBind()
    '    cboAttendantAdd.DataBind()

    'End Sub

    Private Sub GridViewSales_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewSales.CustomButtonCallback
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If GridViewSales.VisibleRowCount = 0 Then Exit Sub

        With GridViewSales
            Dim rowIndex As Integer = .FocusedRowIndex

            intSalesID = CLng(.GetRowValues(rowIndex, "SalesID").ToString)
        End With
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelDailySales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtPumpView.Text = .Item("PumpCode").ToString
                txtAttendantView.Text = .Item("AttendantName").ToString
                txtOpenMetreView.Value = .Item("OpeningMetre").ToString
                txtClosingMetreView.Value = .Item("ClosingMetre").ToString
                txtQuantityView.Value = .Item("TotalQuantity").ToString
                txtTestQuantityView.Value = .Item("TestQuantity").ToString
                txtNetQuantityView.Value = .Item("NetQuantity").ToString
                txtUnitPriceView.Value = .Item("UnitPrice").ToString
                txtAmountView.Value = .Item("Amount").ToString
                txtTransactionCodeView.Text = .Item("SalesCode").ToString

                imgGalary.Items.Clear()

                Dim item As New DevExpress.Web.ImageGalleryItem()
                item.ImageUrl = "~/fuel/fuelSalesPics/" & .Item("SalesCode").ToString & ".jpg"
                item.ThumbnailUrl = "~/fuel/fuelSalesPics/" & .Item("SalesCode").ToString & ".jpg"
                item.Text = "Metre Image"

                imgGalary.Items.Add(item)

            End With

            popupViewSales.ShowOnPageLoad = True
        End If


    End Sub

    Private Sub cmdConfirmMultipleYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmMultipleYes.Click


        'If Session("RoleID9") = False Then txtOpenMetreAdd.ClientEnabled = False
        'If Session("RoleID9") = False Then txtOpenMetreEdit.ClientEnabled = False

        'EmptySalesRec()
        txtUnitPriceAdd.ReadOnly = True
        If Session("dtMetre").Rows(0).Item("RecCount") = 0 Then
            txtOpenMetreAdd.ClientEnabled = True
            txtOpenMetreAdd.Text = 0
            txtOpenMetreAdd.Focus()
        Else
            Dim nDays As Long = DateDiff(DateInterval.Day, CDate(Session("dtMetre").Rows(0).Item("LastDate").ToString), CDate(VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
            If nDays < 0 Then lblErrMsgPump.Text = ("Please, the Date you have Entered is Earlier Than the last Entry Date") : PopupErrMsgPump.ShowOnPageLoad = True : GridLookupPumpAdd.Text = "" : GridLookupPumpAdd.Focus() : Exit Sub

            txtOpenMetreAdd.Text = Session("dtMetre").Rows(0).Item("OpeningMetre")
            txtOpenMetreAdd.ClientEnabled = False
            txtClosingMetreAdd.Focus()
            If Session("RoleID9Edit") = True Then txtOpenMetreAdd.ClientEnabled = True
        End If
    End Sub

    Private Sub cmdConfirmMultipleNo_Click(sender As Object, e As EventArgs) Handles cmdConfirmMultipleNo.Click
        GridLookupPumpAdd.Text = ""
        txtOpenMetreAdd.Text = 0
        txtClosingMetreAdd.Text = 0
        PopupConfirmMultipleAdd.ShowOnPageLoad = False
    End Sub
End Class