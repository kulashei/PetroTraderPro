Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO

Public Class fuelstock
    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intStockID As Long

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

        dtpStockDateAdd.MaxDate = DateCurrendDate
        dtpStockDateAdd.Value = DateCurrendDate

        dtpSearchDateFrom.MaxDate = DateCurrendDate
        dtpSearchDateFrom.Value = DateCurrendDate
        dtpSearchDateTo.Value = DateCurrendDate
        dtpSearchDateFrom.MaxDate = DateCurrendDate


        txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
        txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")

        cboSiteSearch.SelectedIndex = -1
        txtSiteSearch.Text = 0

        SqlDataSourceSites.DataBind()
        SqlDataSourceSearchSite.DataBind()

        cboSiteAdd.DataBind()
        cboSiteSearch.DataBind()


        cboSiteAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = 0

        If cboSiteAdd.Items.Count = 1 Then cboSiteAdd.SelectedIndex = 0
        If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value
        'If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0
        'GridUpdate()
        EmptyAdd1()

        If Session("RoleID1") = False Then dtpStockDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpStockDateEdit.ClientEnabled = False

        ' Fuel Stock
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=3"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID3Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID3Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID3Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID3View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID3Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID3Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID3Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID3View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID3View") = False Then cmdViewStockReport.ClientEnabled = False



        'Change Opening Stock
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=10"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID10Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID10Edit") = False Then txtOpenStockAdd.ClientEnabled = False
        If Session("RoleID10Edit") = False Then txtOpenStockEdit.ClientEnabled = False

        'Add Stock Picture
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=60"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID60Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID60Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID60Add") = True Then
            txtAllowedPicAdd.Text = 1
            FormLayoutAdd.FindItemOrGroupByName("GroupImageAdd").ClientVisible = True
        Else
            txtAllowedPicAdd.Text = 0
            FormLayoutAdd.FindItemOrGroupByName("GroupImageAdd").ClientVisible = False
        End If

        If Session("RoleID60Edit") = True Then
            txtAllowedPicEdit.Text = 1
            FormLayoutEdit.FindItemOrGroupByName("GroupImageEdit").ClientVisible = True
        Else
            txtAllowedPicEdit.Text = 0
            FormLayoutEdit.FindItemOrGroupByName("GroupImageEdit").ClientVisible = True

        End If


        'Allow Multilpe Stocks per day
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=62"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable
        Session("RoleID62Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID62Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")

        If Session("RoleID62Add") = True Then
            txtAllowMultiple.Text = 1
        Else
            txtAllowMultiple.Text = 0
        End If

        If Session("RoleID62Edit") = True Then
            txtAllowMultiple.Text = 1
        Else
            txtAllowMultiple.Text = 0

        End If

        SqlDataSourceStock.DataBind()
        GridViewStock.DataBind()

        fLoad = False

    End Sub


    Private Sub EmptyAdd()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""


        cboSiteAdd.SelectedIndex = -1
        cboTankAdd.SelectedIndex = -1
        txtOpenStockAdd.Value = 0
        txtClosingStockAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        txtFileNameAdd.Text = ""
    End Sub
    Private Sub EmptyAdd1()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()

        cboTankAdd.SelectedIndex = -1
        txtOpenStockAdd.Value = 0
        txtClosingStockAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        txtFileNameAdd.Text = ""
    End Sub

    Private Sub EmptyAdd2()
        txtOpenStockAdd.Value = 0
        txtClosingStockAdd.Value = 0
        'txtUnitPriceAdd.Value = 0
        lblErrMsgGen.Text = ""
    End Sub

    Private Sub EmptyRec()
        txtOpenStockAdd.Value = 0
        txtClosingStockAdd.Value = 0
        cboTankAdd.SelectedIndex = -1
        SqlDataSourceStock.DataBind()
        GridViewStock.DataBind()
        txtTransactionCode.Text = GenerateTransactionCode()
        txtFileNameAdd.Text = ""

    End Sub

    Private Sub EmptyView()

        txtStockIDView.Text = 0
        txtSiteNameView.Text = ""
        txtStockDateView.Text = ""
        txtTankView.Text = ""
        txtOpenStockView.Value = 0
        txtClosingStockView.Value = 0
        txtTransactionCodeView.Text = ""
    End Sub

    Private Sub EmptyEdit()

        txtStockIDEdit.Text = 0
        txtSiteIDEdit.Text = 0
        txtSiteNameEdit.Text = ""
        txtStockDateEdit.Text = ""
        txtTankIDEdit.Text = 0
        'cboTankEdit.SelectedIndex = -1
        txtOpenStockEdit.Value = 0
        txtClosingStockEdit.Value = 0
        txtTransactionCodeEdit.Text = ""
        txtFileNameEdit.Text = ""

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
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
            objCommand.CommandText = "usp_FuelDailyStock_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@StockDate", VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@StockCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@OpeningStock", txtOpenStockAdd.Value))
                .Add(New SqlParameter("@ClosingStock", txtClosingStockAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1

            Dim strPicpath As String = "~/fuel/fuelstockPics/" & txtTransactionCode.Text.ToString & ".jpg"

            If FileUploadPictureAdd.HasFile Then
                FileUploadPictureAdd.SaveAs(Server.MapPath(strPicpath))
            End If

            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Stock Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub
    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()
        If CInt(txtTankIDEdit.Value) = 0 Then Exit Sub
        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0


        Try
            Dim intStockID = 0
            intStockID = 0
            intStockID = CInt(Val(txtStockIDView.Text))
            If intStockID = 0 Then Exit Sub
            Dim str As String = String.Format("SELECT [dbo].[ufn_FuelDailyStock_CheckForExitingTankLaterDate]({0})  AS RecCount", intStockID)
            dtTemp = LoadData(str).Tables(0)

            If dtTemp.Rows(0).Item(0) > 0 Then PopupErrMsg.ShowOnPageLoad = True : lblErrMsgGen.Text = ("Stock Can not Deleted When There are Stock in a later date for Tank") : Exit Sub



            intTankID = CInt(txtTankIDEdit.Value)

            'txtQuantityEdit.Value = (Qty)


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelDailyStock_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@StockDate", VB6.Format(txtStockDateEdit.Text, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@OpeningStock", txtOpenStockEdit.Value))
                .Add(New SqlParameter("@ClosingStock", txtClosingStockEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            intGenReceiptType = 1
            Dim strPicpath As String = "~/fuel/fuelstockPics/" & txtTransactionCodeEdit.Text.ToString & ".jpg"

            If FileUploadPictureEdit.HasFile Then
                FileUploadPictureEdit.SaveAs(Server.MapPath(strPicpath))
            End If

            EmptyEdit()
            EmptyView()
            SqlDataSourceStock.DataBind()
            GridViewStock.DataBind()
            popupEditStock.ShowOnPageLoad = False
            popupViewStock.ShowOnPageLoad = False

        Catch ex As Exception
            lblErrMsgEdit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdViewStock_Click()
        Call CheckUserSession()
        intStockID = 0
        Dim intStockIDTypeID = 0
        If GridViewStock.VisibleRowCount = 0 Then Exit Sub

        With GridViewStock
            Dim rowIndex As Integer = .FocusedRowIndex

            intStockID = CLng(.GetRowValues(rowIndex, "StockID").ToString)
        End With
        If intStockID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelDailyStock WHERE StockID='{0}'", intStockID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            popupViewStock.ShowOnPageLoad = True
            With dt.Rows(0)
                txtStockIDView.Text = .Item("StockID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtStockDateView.Text = VB6.Format(.Item("StockDate").ToString, "dd-MMM-yyyy")
                txtTankView.Text = .Item("TankCode").ToString
                txtOpenStockView.Value = .Item("OpeningStock").ToString
                txtClosingStockView.Value = .Item("ClosingStock").ToString

                txtTransactionCodeView.Text = .Item("StockCode").ToString

                imgGalary.Items.Clear()

                Dim item As New DevExpress.Web.ImageGalleryItem()
                item.ImageUrl = "~/fuel/fuelstockPics/" & .Item("StockCode").ToString & ".jpg"
                item.ThumbnailUrl = "~/fuel/fuelstockPics/" & .Item("StockCode").ToString & ".jpg"
                item.Text = "Stock Image"

                imgGalary.Items.Add(item)
            End With

        End If



    End Sub

    Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
        Call CheckUserSession()
        SqlDataSourceStock.DataBind()
        GridViewStock.DataBind()
    End Sub

    Private Sub cboSite_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
        cboSiteAdd.DataBind()
        EmptyAdd1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intStockID = 0
        intStockID = 0
        intStockID = CInt(Val(txtStockIDView.Text))
        If intStockID = 0 Then Exit Sub
        Dim str As String = String.Format("SELECT [dbo].[ufn_FuelDailyStock_CheckForExitingTankLaterDate]({0})  AS RecCount", intStockID)
        dtTemp = LoadData(str).Tables(0)

        If dtTemp.Rows(0).Item(0) > 0 Then PopupErrMsg.ShowOnPageLoad = True : lblErrMsgGen.Text = ("Stock Can not Deleted When There are Stock in a later date for Tank") : Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelDailyStock WHERE StockID={0}", intStockID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewStock.ShowOnPageLoad = False

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intStockID = 0
        Dim intStockIDTypeID = 0
        If txtStockIDView.Text = 0 Then Exit Sub


        intStockID = CLng(Val(txtStockIDView.Text))
        If intStockID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelDailyStock WHERE StockID='{0}'", intStockID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtStockIDEdit.Text = .Item("StockID").ToString
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                txtSiteNameEdit.Text = .Item("SiteName").ToString
                txtStockDateEdit.Text = VB6.Format(.Item("StockDate").ToString, "dd-MMM-yyyy")
                txtTankIDEdit.Text = CInt(.Item("TankID").ToString)
                txtTankCodeEdit.Text = (.Item("TankCode").ToString)
                txtOpenStockEdit.Value = .Item("OpeningStock").ToString
                txtClosingStockEdit.Value = .Item("ClosingStock").ToString
                txtTransactionCodeEdit.Text = .Item("StockCode").ToString
                picPictureEdit.ImageUrl = "~/fuel/fuelstockPics/" & .Item("StockCode").ToString & ".jpg"

            End With
            If Session("RoleID10Edit") = True Then txtOpenStockEdit.ClientEnabled = True
            popupEditStock.ShowOnPageLoad = True
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

    Private Sub cmdViewStockReport_Click(sender As Object, e As EventArgs) Handles cmdViewStockReport.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptFuelDailyStock
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelDailySalesAndStock_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelStock.pdf")
        End Using


    End Sub

    Private Sub cboTankAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboTankAdd.ValueChanged
        'On Error Resume Next
        Call CheckUserSession()
        If fLoad = True Then Exit Sub
        Dim intTankID = 0
        If cboTankAdd.Text <> "" Then intTankID = cboTankAdd.Value
        If intTankID = 0 Then Exit Sub
        dsTemp = New DataSet
        dsTemp = LoadData(String.Format("Usp_FuelDailyStock_GetPreviousTankStock {0},'{1}'", CInt(intTankID), VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")))

        With dsTemp.Tables(0).Rows(0)
            If .Item("RecCount") = 0 Then
                txtOpenStockAdd.ClientEnabled = True
                txtOpenStockAdd.Text = ""
                txtOpenStockAdd.Focus()
            Else
                If CDate(VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")) = CDate(.Item("LastDate").ToString) Then lblErrMsgGen.Text = ("Please, the Tank Number you Have Selected Already Entered for this Date") : PopupErrMsg.ShowOnPageLoad = True : cboTankAdd.Text = "" : cboTankAdd.SelectedIndex = -1 : cboTankAdd.Focus() : Exit Sub
                Dim nDays As Long = DateDiff(DateInterval.Day, CDate(.Item("LastDate").ToString), CDate(VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")))
                If nDays < 0 Then lblErrMsgGen.Text = ("Please, the Date you have Entered is Earlier Than the last Entry Date") : PopupErrMsg.ShowOnPageLoad = True : cboTankAdd.Text = "" : cboTankAdd.SelectedIndex = -1 : cboTankAdd.Focus() : Exit Sub

                txtOpenStockAdd.ClientEnabled = False
                txtOpenStockAdd.Value = .Item("OpeningStock").ToString
                txtClosingStockAdd.Text = ""
                txtClosingStockAdd.Focus()
                If Session("RoleID10Edit") = True Then txtOpenStockAdd.ClientEnabled = True

            End If
        End With

        'Dim STR(1) As String
        'STR(0) = String.Format("Usp_FuelDailyStock_GetPreviousTankStock {0},'{1}'", CInt(intTankID), VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy"))
        'STR(1) = String.Format("Usp_FuelDailySales_GetPreviousMetreReadings {0},'{1}'", CInt(intPumpID), VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy"))

        'Session("dtMetre") = New DataTable
        'Session("dtCheck") = New DataTable
        'Dim dsMany() As DataSet = LoadManyDataSets(STR, 1)
        'Session("dtCheck") = dsMany(0).Tables(0)
        'Session("dtMetre") = dsMany(1).Tables(0)

        'If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 0 Then

        '    GridLookupPumpAdd.Text = ""
        '    PopupErrMsgStock.ShowOnPageLoad = True
        '    lblErrMsgPump.Text = ("Please Daily Sales for the Pump and this date is entered already")
        '    GridLookupPumpAdd.Text = ""
        '    Exit Sub
        'End If


        'If Session("dtCheck").Rows.Count > 0 And Val(txtAllowMultiple.Text) = 1 Then
        '    lblMultipleMsg.Text = ("Note: Daily Sales for the Pump and this date is entered already. Do you to enter multiple readings for the day?")
        '    PopupConfirmMultipleAdd.ShowOnPageLoad = True
        '    Exit Sub

        'End If

    End Sub

    Private Sub dtpStockDateAdd_ValueChanged(sender As Object, e As EventArgs) Handles dtpStockDateAdd.ValueChanged
        'On Error Resume Next
        Call CheckUserSession()
        If fLoad = True Then Exit Sub
        Dim intTankID = 0
        If cboTankAdd.Text <> "" Then intTankID = cboTankAdd.Value
        If intTankID = 0 Then Exit Sub
        dsTemp = New DataSet
        dsTemp = LoadData(String.Format("Usp_FuelDailyStock_GetPreviousTankStock {0},'{1}'", CInt(intTankID), VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")))

        With dsTemp.Tables(0).Rows(0)
            If .Item("RecCount") = 0 Then
                txtOpenStockAdd.ClientEnabled = True
                txtOpenStockAdd.Text = ""
                txtOpenStockAdd.Focus()
            Else
                If CDate(VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")) = CDate(.Item("LastDate").ToString) Then lblErrMsgGen.Text = ("Please, the Tank Number you Have Selected Already Entered for this Date") : PopupErrMsg.ShowOnPageLoad = True : cboTankAdd.Text = "" : cboTankAdd.SelectedIndex = -1 : cboTankAdd.Focus() : Exit Sub
                Dim nDays As Long = DateDiff(DateInterval.Day, CDate(.Item("LastDate").ToString), CDate(VB6.Format(dtpStockDateAdd.Value.Date, "dd-MMM-yyyy")))
                If nDays < 0 Then lblErrMsgGen.Text = ("Please, the Date you have Entered is Earlier Than the last Entry Date") : PopupErrMsg.ShowOnPageLoad = True : cboTankAdd.Text = "" : cboTankAdd.SelectedIndex = -1 : cboTankAdd.Focus() : Exit Sub

                txtOpenStockAdd.ClientEnabled = False
                txtOpenStockAdd.Value = .Item("OpeningStock").ToString
                txtClosingStockAdd.Text = ""
                txtClosingStockAdd.Focus()
                If Session("RoleID10Edit") = True Then txtOpenStockAdd.ClientEnabled = True

            End If
        End With
    End Sub
    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        On Error Resume Next
        Call CheckUserSession()
        If cboSiteSearch.Text = "" Then Exit Sub
        SqlDataSourceTanks.DataBind()
        cboTankAdd.DataBind()


    End Sub

    Private Sub GridViewStock_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewStock.CustomButtonCallback
        Call cmdViewStock_Click()
    End Sub
End Class