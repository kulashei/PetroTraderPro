Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class items
    Inherits System.Web.UI.Page
    Private dtNew As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Call CheckUserSession()
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
        Call EmptyAdd()
        Call EmptyEdit()
        SqlDataSourceItems.DataBind()
        GridViewItems.DataBind()

    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next

        txtItemNameAdd.Text = ""
        cboUnitAdd.SelectedIndex = -1
        cboCategotyAdd.SelectedIndex = -1
        txtDescriptionAdd.Text = ""
        cboItemTypeAdd.SelectedIndex = -1
        txtBarcodeAdd.Text = ""
        cboUnitAdd.SelectedIndex = -1
        cboUnitAdd.SelectedIndex = -1
        cboUnitAdd.SelectedIndex = -1
        txtRetailPriceAdd.Text = 0
        txtCostPriceAdd.Text = 0
        txtReQuantityAdd.Text = 0
        chkProducedAdd.CheckState = DevExpress.Web.CheckState.Unchecked
        txtTransactionCode.Text = GenerateTransactionCode()
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtItemID.Text = 0

        txtItemNameEdit.Text = ""
        cboUnitEdit.SelectedIndex = -1
        cboCategotyEdit.SelectedIndex = -1
        txtDescriptionEdit.Text = ""
        cboItemTypeEdit.SelectedIndex = -1
        txtBarcodeEdit.Text = ""
        cboUnitEdit.SelectedIndex = -1
        cboUnitEdit.SelectedIndex = -1
        cboUnitEdit.SelectedIndex = -1
        txtRetailPriceEdit.Text = 0
        txtCostPriceEdit.Text = 0
        txtReQuantityEdit.Text = 0
        chkProducedEdit.CheckState = DevExpress.Web.CheckState.Unchecked
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Item name Already Exist") : txtItemNameAdd.Focus() : Exit Sub

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intItemTypeID As Integer = 0, intCategoryID As Integer = 0, intProduced As Integer = 0


        Try

            If cboItemTypeAdd.Text <> "" Then intItemTypeID = cboItemTypeAdd.Value
            If cboCategotyAdd.Text <> "" Then intCategoryID = cboCategotyAdd.Value
            If chkProducedAdd.CheckState = DevExpress.Web.CheckState.Checked Then intProduced = 1

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_POSItems_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ItemTypeID", intItemTypeID))
                .Add(New SqlParameter("@CategoryID", intCategoryID))
                .Add(New SqlParameter("@ItemCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ItemName", txtItemNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UPC", txtBarcodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ItemDescription", txtDescriptionAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UM", cboUnitAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@RetailPrice", VB6.Format(txtRetailPriceAdd.Value, "##0.#0")))
                .Add(New SqlParameter("@CostPrice", VB6.Format(txtCostPriceAdd.Value, "##0.#0")))
                .Add(New SqlParameter("@ReorderLevel", VB6.Format(txtReQuantityAdd.Value, "##0.#0")))
                .Add(New SqlParameter("@Produced", chkProducedAdd.CheckState))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Item Successfully Registered"


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

        Dim intItemTypeID As Integer = 0, intCategoryID As Integer = 0, intProduced As Integer = 0


        Try
            Dim NameExist As Boolean = CheckItenNameEdit()
            If NameExist = True Then lblErrMsgEdit.ClientVisible = true : lblErrMsgEdit.Text = ("Please Item name Already Exist") : txtItemNameEdit.Focus() : Exit Sub

            If cboItemTypeEdit.Text <> "" Then intItemTypeID = cboItemTypeEdit.Value
            If cboCategotyEdit.Text <> "" Then intCategoryID = cboCategotyEdit.Value
            If chkProducedEdit.CheckState = DevExpress.Web.CheckState.Checked Then intProduced = 1

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_POSItems_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ItemID", CLng(Val(txtItemID.Text))))
                .Add(New SqlParameter("@ItemTypeID", intItemTypeID))
                .Add(New SqlParameter("@CategoryID", intCategoryID))
                .Add(New SqlParameter("@ItemName", txtItemNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UPC", txtBarcodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ItemDescription", txtDescriptionEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UM", cboUnitEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@RetailPrice", VB6.Format(txtRetailPriceEdit.Value, "##0.#0")))
                .Add(New SqlParameter("@CostPrice", VB6.Format(txtCostPriceEdit.Value, "##0.#0")))
                .Add(New SqlParameter("@ReorderLevel", VB6.Format(txtReQuantityEdit.Value, "##0.#0")))
                .Add(New SqlParameter("@Produced", chkProducedEdit.CheckState))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
           lblErrMsgedit.ClientVisible = true
            lblSuccessMsgEdit.Text = "Item Successfully Registered"
            popupEdit.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub
    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim STRQ = "SELECT * FROM POSitems Where ItemName='" & txtItemNameAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            CheckItenNameAdd = True
        Else
            CheckItenNameAdd = False
        End If

        Return CheckItenNameAdd()
    End Function

    Private Function CheckItenNameEdit() As Boolean
        dtNew = New DataTable
        Dim STRQ = "SELECT * FROM POSitems Where ItemName='" & txtItemNameEdit.Text.Trim.ToUpper & "' AND ItemID<>" & CLng(Val(txtItemID.Text))
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            CheckItenNameEdit = True
        Else
            CheckItenNameEdit = False
        End If

        Return CheckItenNameEdit
    End Function

    Protected Sub cmdDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdDeleteYes.Click
        Call CheckUserSession()
        lblErrMsgDelete.Visible = False
        lblSuccessMsgDelete.Visible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewItems.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from POSItems Where ItemID={0}", CLng(Val(txtItemIDDelete.Text))))
            EmptyFields()
            lblErrMsgDelete.Visible = False
            lblSuccessMsgDelete.Visible = True
            lblSuccessMsgDelete.Text = "Item Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.Visible = False
            lblErrMsgDelete.Visible = True
            lblErrMsgDelete.Text = ("Items Can Not Be Deleted")
        End Try


    End Sub


    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub

    Private Sub cmdPrintYes_Click(sender As Object, e As EventArgs) Handles cmdPrintYes.Click
        Call CheckUserSession()

        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New rptItemList
        Dim str As String = String.Format("SELECT * FROM View_POSItems ORDER BY CategoryName,ItemName")

        Dim dt As DataTable = LoadData(str).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "ItemList.pdf")
        End Using


    End Sub
End Class