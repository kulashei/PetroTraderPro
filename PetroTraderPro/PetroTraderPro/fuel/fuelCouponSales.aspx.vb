Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class fuelCouponSales

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
        If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False

        ' Fuel Coupon Sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=7"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID7Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID7Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID7Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID7View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID7Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID7Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID7Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID7View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID7View") = False Then cmdViewSalesReport.ClientEnabled = False


    End Sub


    Private Sub EmptyAdd()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""


        cboSiteAdd.SelectedIndex = -1
        cboDenominationAdd.Text = ""
        cboDenominationAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub
    Private Sub EmptyAdd1()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        cboDenominationAdd.Text = ""
        cboDenominationAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Private Sub EmptyAdd2()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        cboDenominationAdd.Text = ""
        cboDenominationAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        lblErrMsgGen.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Private Sub EmptyRec()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        cboDenominationAdd.Text = ""
        cboDenominationAdd.SelectedIndex = -1
        txtQuantityAdd.Value = 0
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtAmountAdd.Value = 0

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Private Sub EmptyView()

        txtSalesIDView.Text = 0
        txtSiteNameView.Text = ""
        txtSalesDateView.Text = ""
        txtDenominationView.Text = ""


        txtQuantityView.Value = 0
        txtAmountView.Value = 0
        txtRemarkView.Text = ""

    End Sub

    Private Sub EmptyEdit()

        txtSalesIDEdit.Text = 0
        txtSiteIDEdit.Text = 0
        cboSiteEdit.SelectedIndex = -1
        cboDenominationEdit.Text = ""
        cboDenominationEdit.SelectedIndex = -1
        txtQuantityEdit.Value = 0
        txtAmountEdit.Value = 0
        txtRemarkEdit.Text = ""
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intDenominationID As Integer = 0, intCustomerID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboDenominationAdd.Text <> "" Then intDenominationID = cboDenominationAdd.Value

            Dim Denomination = Val(VB6.Format((cboDenominationAdd.Text), "##0.#0"))
            Dim Qty = Val(VB6.Format(CDbl(txtQuantityAdd.Value), "##0"))
            If Denomination = 0 Then Exit Sub

            Dim Amount = Val(VB6.Format(Denomination * Qty, "##0.#0"))




            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelCouponSales_Insert"
            objCommand.CommandType = CommandType.StoredProcedure


            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@DenominationID", intDenominationID))
                .Add(New SqlParameter("@Denomination", Denomination))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@Amount", Amount))
                .Add(New SqlParameter("@Remark", txtRemarkAdd.Text.Trim.ToUpper))
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

        Dim intSiteID As Integer = 0, intDenominationID As Integer = 0

        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If cboDenominationEdit.Text <> "" Then intDenominationID = cboDenominationEdit.Value

            Dim Denomination = Val(VB6.Format((cboDenominationEdit.Text), "##0.#0"))
            Dim Qty = Val(VB6.Format(CDbl(txtQuantityEdit.Value), "##0"))
            If Denomination = 0 Then Exit Sub

            Dim Amount = Val(VB6.Format(Denomination * Qty, "##0.#0"))


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelCouponSales_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesID", CInt(Val(txtSalesIDEdit.Text))))
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@DenominationID", intDenominationID))
                .Add(New SqlParameter("@Denomination", Denomination))
                .Add(New SqlParameter("@Quantity", Qty))
                .Add(New SqlParameter("@Amount", Amount))
                .Add(New SqlParameter("@Remark", txtRemarkEdit.Text.Trim.ToUpper))
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelCouponSales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtDenominationView.Text = .Item("Denomination").ToString
                txtQuantityView.Value = .Item("Quantity").ToString
                txtAmountView.Value = .Item("Amount").ToString
                txtRemarkView.Text = .Item("Remark").ToString

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
        SqlDataSourceDenomination.DataBind()
        cboSiteAdd.DataBind()
        cboDenominationAdd.Text = ""
        EmptyAdd1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intSalesID = 0
        intSalesID = 0
        intSalesID = CInt(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelCouponSales WHERE SalesID={0}", intSalesID)
        ExecuteMyQuery(strQuery)

        EmptyRec()
        EmptyView()
        popupViewSales.ShowOnPageLoad = False

    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If txtSalesIDView.Text = 0 Then Exit Sub


        intSalesID = CLng(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelCouponSales WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtSalesIDEdit.Text = .Item("SalesID").ToString
                dtpSalesDateEdit.Value = CDate(VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy"))
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                cboDenominationEdit.Value = CInt(.Item("DenominationID").ToString)
                txtQuantityEdit.Value = .Item("Quantity").ToString

                Dim Denomination = Val(cboDenominationEdit.Text)
                Dim Qty = Val(.Item("Quantity").ToString)

                txtAmountEdit.Value = Denomination * Qty
                txtRemarkEdit.Text = .Item("Remark").ToString

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
        Dim report As New XtraRptFuelCouponSales
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelCouponSales_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "DailyFuelSales.pdf")
        End Using


    End Sub

    Private Sub GridViewSales_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewSales.CustomButtonCallback
        Call cmdViewSales_Click()
    End Sub
End Class