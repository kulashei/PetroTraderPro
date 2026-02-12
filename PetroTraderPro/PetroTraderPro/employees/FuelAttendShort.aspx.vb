Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class FuelAttendShort

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
        If Session("RoleID1") = False Then dtpSalesDateAdd.ClientEnabled = False
        If Session("RoleID1") = False Then dtpSalesDateEdit.ClientEnabled = False
        EmptyAdd1()
        ' Fuel Coupon Sales
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=47"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID47Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID47Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID47Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID47View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID47Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID47Edit") = False Then cmdEdit.ClientEnabled = False
        If Session("RoleID47Delete") = False Then cmdDelete.ClientEnabled = False

        If Session("RoleID47View") = False Then cmdSearcByDate.ClientEnabled = False
        If Session("RoleID47View") = False Then cmdViewSalesReport.ClientEnabled = False

        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

    End Sub


    Private Sub EmptyAdd()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""


        cboSiteAdd.SelectedIndex = -1
        cboAttendantAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub
    Private Sub EmptyAdd1()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        SqlDataSourceAttendantAdd.DataBind()
        cboAttendantAdd.DataBind()

        cboAttendantAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Private Sub EmptyAdd2()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        cboAttendantAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
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

        cboAttendantAdd.Text = ""
        cboAttendantAdd.SelectedIndex = -1
        txtAmountAdd.Value = 0
        txtRemarkAdd.Text = ""
        txtAmountAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()

    End Sub

    Private Sub EmptyView()

        txtSalesIDView.Text = 0
        txtSiteNameView.Text = ""
        txtSalesDateView.Text = ""
        txtAttendantView.Text = ""


        txtAmountView.Value = 0
        txtRemarkView.Text = ""

    End Sub

    Private Sub EmptyEdit1()
        cboAttendantEdit.Text = ""
        cboAttendantEdit.SelectedIndex = -1
        txtAmountEdit.Value = 0
        txtRemarkEdit.Text = ""
    End Sub

    Private Sub EmptyEdit()

        txtSalesIDEdit.Text = 0
        txtSiteIDEdit.Text = 0
        cboSiteEdit.SelectedIndex = -1
        cboAttendantEdit.Text = ""
        cboAttendantEdit.SelectedIndex = -1
        txtAmountEdit.Value = 0
        txtRemarkEdit.Text = ""
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intSiteID As Integer = 0, intAttendantID As Integer = 0, intCustomerID As Integer = 0


        Try

            If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
            If cboAttendantAdd.Text <> "" Then intAttendantID = cboAttendantAdd.Value



            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendantShortages_Insert"
            objCommand.CommandType = CommandType.StoredProcedure


            With objCommand.Parameters
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SalesCode", txtTransactionCode.Text))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@Remark", txtRemarkAdd.Text.Trim.ToUpper))
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

        Dim intSiteID As Integer = 0, intAttendantID As Integer = 0

        Try

            If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
            If cboAttendantEdit.Text <> "" Then intAttendantID = cboAttendantEdit.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendantShortages_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SalesID", CInt(Val(txtSalesIDEdit.Text))))
                .Add(New SqlParameter("@SalesDate", VB6.Format(dtpSalesDateEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@AttendantID", intAttendantID))
                .Add(New SqlParameter("@Remark", txtRemarkEdit.Text.Trim.ToUpper))
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

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantShortages WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtAttendantView.Text = .Item("AttendantName").ToString
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

    Private Sub cboSiteAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteAdd.ValueChanged
        Call CheckUserSession()
        SqlDataSourceAttendantAdd.DataBind()
        cboSiteAdd.DataBind()
        cboAttendantAdd.Text = ""
        EmptyAdd1()
    End Sub
    Private Sub cboSiteEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteEdit.ValueChanged
        Call CheckUserSession()
        SqlDataSourceAttendantEdit.DataBind()
        cboSiteEdit.DataBind()
        cboAttendantEdit.Text = ""
        EmptyEdit1()
    End Sub

    Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
        'On Error Resume Next
        'Call CheckUserSession()
        'Dim intSalesID = 0
        'intSalesID = 0
        'intSalesID = CInt(Val(txtSalesIDView.Text))
        'If intSalesID = 0 Then Exit Sub

        'objCommand = New SqlCommand
        'objCommand.Connection = objConnect
        'objCommand.CommandText = "usp_FuelAttendantShortages_Delete"
        'objCommand.CommandType = CommandType.StoredProcedure

        'With objCommand.Parameters
        '    .Add(New SqlParameter("@SalesID", CInt(Val(txtSalesIDEdit.Text))))
        '    .Add(New SqlParameter("@UserID", Session("UserID")))
        'End With
        'objCommand.ExecuteNonQuery()
        'objCommand.Parameters.Clear()


        'EmptyRec()
        'EmptyView()
        'popupViewSales.ShowOnPageLoad = False

        Call CheckUserSession()
        lblErrMsgView.ClientVisible = False
        lblSuccessMsgView.ClientVisible = False
        lblErrMsgView.Text = ""
        lblSuccessMsgView.Text = ""


        Try
            Dim intSalesID = 0
            intSalesID = 0
            intSalesID = CInt(Val(txtSalesIDView.Text))
            If intSalesID = 0 Then Exit Sub

            Dim strQuery As String = String.Format("DELETE FROM FuelAttendantShortages WHERE SalesID={0}", intSalesID)
            ExecuteMyQuery(strQuery)


            EmptyView()
            SqlDataSourceSales.DataBind()
            GridViewSales.DataBind()
            popupViewSales.ShowOnPageLoad = False
        Catch ex As Exception
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = True
            lblErrMsgView.Text = (ex.Message)
        End Try


    End Sub


    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        intSalesID = 0
        Dim intSalesIDTypeID = 0
        If txtSalesIDView.Text = 0 Then Exit Sub


        intSalesID = CLng(Val(txtSalesIDView.Text))
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantShortages WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtSalesIDEdit.Text = .Item("SalesID").ToString
                dtpSalesDateEdit.Value = CDate(VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy"))
                txtSiteIDEdit.Text = .Item("SiteID").ToString
                cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                cboAttendantEdit.Value = CInt(.Item("AttendantID").ToString)
                txtRemarkEdit.Text = .Item("Remark").ToString

                txtAmountEdit.Value = .Item("Amount")

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
        Dim report As New XtraRptFuelAttendantShortages
        Dim intSiteID = 0
        If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelAttendantShortages_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
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
        Dim intSalesIDTypeID = 0
        If GridViewSales.VisibleRowCount = 0 Then Exit Sub

        With GridViewSales
            Dim rowIndex As Integer = .FocusedRowIndex

            intSalesID = CLng(.GetRowValues(rowIndex, "SalesID").ToString)
        End With
        If intSalesID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendantShortages WHERE SalesID='{0}'", intSalesID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtSalesIDView.Text = .Item("SalesID").ToString
                txtSiteNameView.Text = .Item("SiteName").ToString
                txtSalesDateView.Text = VB6.Format(.Item("SalesDate").ToString, "dd-MMM-yyyy")
                txtAttendantView.Text = .Item("AttendantName").ToString
                txtAmountView.Value = .Item("Amount").ToString
                txtRemarkView.Text = .Item("Remark").ToString

            End With

            popupViewSales.ShowOnPageLoad = True
        End If



    End Sub
End Class