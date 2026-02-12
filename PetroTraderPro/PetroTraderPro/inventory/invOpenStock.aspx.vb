Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Public Class invOpenStock
    Inherits System.Web.UI.Page

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
        dtpStockDate.MaxDate = CDate(StrCurrentDate)
        dtpStockDate.Value = CDate(StrCurrentDate)

        cboSite.SelectedIndex = -1
        cboSite1.SelectedIndex = -1
        cboItem.SelectedIndex = -1
        txtBatchNumber.Text = ""
        dtpExpDate.Text = ""
        txtQtyInStock.Text = 0

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        GridUpdate()

    End Sub
    Private Sub GridUpdate()
        SqlDataSourceItems.DataBind()
        cboItem.DataBind()

        SqlDataSourceStock.DataBind()
        GridViewStock.DataBind()

        SqlDataSourceSites.DataBind()
        cboSite.DataBind()

        SqlDataSourceSite1.DataBind()
        cboSite1.DataBind()

    End Sub
    Private Sub EmptyRec()

        cboItem.SelectedIndex = -1
        txtBatchNumber.Text = ""
        dtpExpDate.Text = ""
        txtQtyInStock.Text = 0

        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        GridUpdate()

    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intItemID As Int64 = 0, intSiteID As Integer = 0, strExpDate As String = ""


        Try

            If cboItem.Text <> "" Then intItemID = cboItem.Value
            If cboSite1.Text <> "" Then intSiteID = cboSite1.Value
            If dtpExpDate.Text = "" Then
                strExpDate = "01-01-1900"
            ElseIf dtpExpDate.Text <> "" Then
                strExpDate = VB6.Format(dtpExpDate.Value.Date, "dd-MMM-yyyy")
            End If


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_POSOpenStock_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@StockDate", VB6.Format(dtpStockDate.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@ItemID", intItemID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@Stock", VB6.Format(txtQtyInStock.Value, "##0.#0")))
                .Add(New SqlParameter("@ExpiryDate", strExpDate))
                .Add(New SqlParameter("@BatchNumber", txtBatchNumber.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyRec()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Stock Successfully Entered"


        Catch ex As Exception
            lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Private Sub GridViewStock_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewStock.CustomButtonCallback
        'On Error Resume Next
        Call CheckUserSession()

        Select Case e.ButtonID

            Case "cmdDelete"

                Call CheckUserSession()
                If GridViewStock.VisibleRowCount = 0 Then Exit Sub
                Dim intItemID = 0
                With GridViewStock
                    Dim RowIndx As Integer = .FocusedRowIndex
                    txtItemIDDelete.Text = (.GetRowValues(RowIndx, "ItemName").ToString)
                    lblItemDelete.Text = CLng(.GetRowValues(RowIndx, "ItemID").ToString)
                    intItemID = CLng(.GetRowValues(RowIndx, "ItemID").ToString)
                End With
                If intItemID = 0 Then Exit Sub
                PopupConfirmDelete.ShowOnPageLoad = True

        End Select
    End Sub


End Class