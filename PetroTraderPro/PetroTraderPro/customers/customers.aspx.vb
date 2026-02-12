Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class customers
    Inherits System.Web.UI.Page
    Private dtNew As DataTable
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
        dtpBalanceDateAdd.MaxDate = DateCurrendDate
        dtpBalanceDateAdd.Value = DateCurrendDate

        Call EmptyAdd()
        Call EmptyEdit()
        Call EmptyView()
        SqlDataSourceCustomers.DataBind()
        GridViewCustomers.DataBind()

        'If Session("RoleID1") = False Then dtpBalanceDateAdd.ClientEnabled = False
        'If Session("RoleID1") = False Then dtpBalanceDateedit.ClientEnabled = False

        '  New Customer
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=12"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID12Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID12Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID12Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID12View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID12Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID12Edit") = False Then MainMenu.Items.FindByName("Edit").ClientEnabled = False
        If Session("RoleID12Delete") = False Then MainMenu.Items.FindByName("Delete").ClientEnabled = False
        If Session("RoleID12View") = False Then MainMenu.Items.FindByName("Print").ClientEnabled = False



    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next

        cboCustomerTypeAdd.SelectedIndex = -1
        'cboSiteAdd.SelectedIndex = -1
        txtCustomerNameAdd.Text = ""
        txtCustomerAddressAdd.Text = ""
        txtEmailAdd.Text = ""
        txtPhoneNumber1Add.Text = ""
        txtPhoneNumber2Add.Text = ""
        txtCreditLimitAdd.Value = 0
        txtCreditPeriodAdd.Value = 0
        dtpBalanceDateAdd.Text = ""
        cboBalanceTypeAdd.SelectedIndex = -1
        txtBalanceAmountAdd.Value = 0
        txtTransactionCode.Text = GenerateTransactionCode()
        SqlDataSourceSites.DataBind()
        GridViewCustomerSitesAdd.DataBind()
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtCustomerIDEdit.Text = 0
        txtCustomerCodeEdit.Text = ""


        cboCustomerTypeEdit.SelectedIndex = -1
        txtCustomerNameEdit.Text = ""
        txtCustomerAddressEdit.Text = ""
        txtEmailEdit.Text = ""
        txtPhoneNumber1Edit.Text = ""
        txtPhoneNumber2Edit.Text = ""
        txtCreditLimitEdit.Value = 0
        txtCreditPeriodEdit.Value = 0
    End Sub

    Private Sub EmptyView()
        On Error Resume Next
        txtCustomerIDView.Text = 0
        txtCustomerCodeView.Text = ""
        txtBalanceView.Text = 0


        txtCustomerTypeView.Text = ""
        'txtSiteView.Text = ""
        txtCustomerNameView.Text = ""
        txtCustomerAddressView.Text = ""
        txtEmailView.Text = ""
        txtPhoneNumber1View.Text = ""
        txtPhoneNumber2View.Text = ""
        txtCreditLimitView.Value = 0
        txtCreditPeriodView.Value = 0
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Customer name Already Exist") : txtCustomerNameAdd.Focus() : Exit Sub
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""
        If GridViewCustomerSitesAdd.Selection.Count = 0 Then lblErrMsgAdd.Text = ("Please Please the Customer's Site Exist") : GridViewCustomerSitesAdd.Focus() : Exit Sub

        Dim intCustomerTypeID As Integer = 0, intSiteID As Integer = 0, intBalanceType As Integer = 0


        Try
            If cboCustomerTypeAdd.Text <> "" Then intCustomerTypeID = cboCustomerTypeAdd.Value

            If cboBalanceTypeAdd.Text <> "" Then intBalanceType = cboBalanceTypeAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            Dim da As New SqlDataAdapter("", strCon)
            da.SelectCommand.CommandText = "usp_Customers_Insert"
            da.SelectCommand.CommandType = CommandType.StoredProcedure

            With da.SelectCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CustomerTypeID", intCustomerTypeID))
                .Add(New SqlParameter("@CustomerName", txtCustomerNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CustomerAddress", txtCustomerAddressAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@EmailAddress", txtEmailAdd.Text.Trim.ToLower))
                .Add(New SqlParameter("@CreditLimit", txtCreditLimitAdd.Value))
                .Add(New SqlParameter("@CreditPeriod", txtCreditPeriodAdd.Value))
                .Add(New SqlParameter("@BalanceDate", VB6.Format(dtpBalanceDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@BalanceTypeID", intBalanceType))
                .Add(New SqlParameter("@OpeningBalance", txtBalanceAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            Dim dt As New DataTable
            da.Fill(dt)

            Dim ItmSiteID As Integer = 0
            Dim ItmItemID As Long = 0
            Dim strQuery = ""
            With GridViewCustomerSitesAdd

                For i = 0 To .VisibleRowCount - 1
                    If .Selection.IsRowSelected(i) = True Then
                        ItmSiteID = .GetRowValues(i, "SiteID").ToString

                        strQuery = strQuery & " EXEC usp_CustomerSites_Insert " &
                        "@TransactionCode='" & txtTransactionCode.Text.Trim.ToUpper & "'," &
                        "@SiteID=" & ItmSiteID & "," &
                        "@UserID=" & Session("UserID")
                    End If
                Next
            End With
            ExecuteMyQuery(strQuery)

            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Customer Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

        End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameEdit()
        If NameExist = True Then lblErrMsgEdit.ClientVisible = true : lblErrMsgEdit.Text = ("Please Customer name Already Exist") : txtCustomerNameEdit.Focus() : Exit Sub

        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = false
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intCustomerTypeID As Integer = 0, intSiteID As Integer = 0, intCustomerID As Integer = 0


        Try

            If cboCustomerTypeEdit.Text <> "" Then intCustomerTypeID = cboCustomerTypeEdit.Value
            intCustomerID = CInt(Val(txtCustomerIDEdit.Text))
            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Customers_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@CustomerTypeID", intCustomerTypeID))
                .Add(New SqlParameter("@CustomerName", txtCustomerNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CustomerAddress", txtCustomerAddressEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@EmailAddress", txtEmailEdit.Text.Trim.ToLower))
                .Add(New SqlParameter("@CreditLimit", txtCreditLimitEdit.Value))
                .Add(New SqlParameter("@CreditPeriod", txtCreditPeriodEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
           lblErrMsgedit.ClientVisible = true
            lblSuccessMsgEdit.Text = "Customer Successfully Registered"
            popupEdit.ShowOnPageLoad = False
            popupView.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = false
            lblErrMsgEdit.ClientVisible = true
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Customers Where CustomerName='" & txtCustomerNameAdd.Text.Trim.ToUpper & "'"
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Function CheckItenNameEdit() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Customers Where CustomerName='" & txtCustomerNameEdit.Text.Trim.ToUpper & "' AND CustomerID<>" & CLng(Val(txtCustomerIDEdit.Text))
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Protected Sub cmdDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdDeleteYes.Click
        Call CheckUserSession()
        lblErrMsgDelete.Visible = False
        lblSuccessMsgDelete.Visible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewCustomers.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from Customers Where CustomerID={0}", CLng(Val(txtCustomerIDDelete.Text))))
            EmptyFields()
            popupView.ShowOnPageLoad = False

            lblErrMsgDelete.Visible = False
            lblSuccessMsgDelete.Visible = True
            lblSuccessMsgDelete.Text = "Customer Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.Visible = False
            lblErrMsgDelete.Visible = True
            lblErrMsgDelete.Text = ("Customers Can Not Be Deleted")
        End Try


    End Sub

    Protected Sub cmdViewCustomer_Click()
        Call CheckUserSession()
        Dim intCustomerID = 0
        Dim intCustomerIDTypeID = 0
        If GridViewCustomers.VisibleRowCount = 0 Then Exit Sub

        With GridViewCustomers
            Dim rowIndex As Integer = .FocusedRowIndex

            intCustomerID = CLng(.GetRowValues(rowIndex, "CustomerID").ToString)
        End With
        If intCustomerID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers WHERE CustomerID='{0}'", intCustomerID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtCustomerIDView.Text = .Item("CustomerID").ToString
                txtCustomerCodeView.Text = .Item("CustomerCode").ToString
                txtBalanceView.Text = .Item("Balance").ToString


                txtCustomerTypeView.Text = .Item("CustomerType").ToString
                'txtSiteView.Text = .Item("SiteName").ToString
                txtCustomerNameView.Text = .Item("CustomerName").ToString
                txtCustomerAddressView.Text = .Item("CustomerAddress").ToString
                txtEmailView.Text = .Item("EmailAddress").ToString
                txtPhoneNumber1View.Text = .Item("PhoneNumber1").ToString
                txtPhoneNumber2View.Text = .Item("PhoneNumber2").ToString
                txtCreditLimitView.Value = .Item("CreditLimit").ToString
                txtCreditPeriodView.Value = .Item("CreditPeriod").ToString


            End With

            popupView.ShowOnPageLoad = True
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

    Private Sub cmdPrint_Click(sender As Object, e As EventArgs) Handles cmdPrint.Click
        Call CheckUserSession()

        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptCustomerList
        Dim intSiteID = 0
        'If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
        Dim str As String = String.Format("Usp_Customers_GetBySiteByUser @SiteID={0}, @UserID={1}", intSiteID, Session("UserID"))

        Dim dt As DataTable = LoadData(str).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "CustomerList.pdf")
        End Using


    End Sub

    Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
        Call CheckUserSession()
        Dim intCustomerID = 0

        intCustomerID = CLng(Val(txtCustomerIDView.Text.ToString))
        If intCustomerID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers WHERE CustomerID='{0}'", intCustomerID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyEdit()
            With dt.Rows(0)
                txtCustomerIDEdit.Text = .Item("CustomerID").ToString
                txtCustomerCodeEdit.Text = .Item("CustomerCode").ToString
                'txtBalanceEdit.Text = .Item("Balance").ToString


                cboCustomerTypeEdit.Value = CInt(.Item("CustomerTypeID").ToString)
                txtCustomerNameEdit.Text = .Item("CustomerName").ToString
                txtCustomerAddressEdit.Text = .Item("CustomerAddress").ToString
                txtEmailEdit.Text = .Item("EmailAddress").ToString
                txtPhoneNumber1Edit.Text = .Item("PhoneNumber1").ToString
                txtPhoneNumber2Edit.Text = .Item("PhoneNumber2").ToString
                txtCreditLimitEdit.Value = .Item("CreditLimit").ToString
                txtCreditPeriodEdit.Value = .Item("CreditPeriod").ToString


            End With

            popupEdit.ShowOnPageLoad = True
        End If

    End Sub

    Protected Sub cmdAssignSite_Click()

        Call CheckUserSession()
        'lblMsgPopup.Text = ""
        Try

            Dim intSiteID = 0
            If GridViewUnassigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewUnassigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intCustomerID As Integer = -1
            intCustomerID = CInt(Val(txtCustomerIDView.Text))

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_CustomerSites_Insert1"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@CustomerID", intCustomerID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@UserRegID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            'LoadUserInfo(intUserID)
            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewUnassigned.DataBind()
            GridViewAssigned.DataBind()

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = True
            lblSuccessMsgAssign.Text = "Successfully Assigned"


        Catch ex As Exception
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Visible = True
            lblErrMsgAssign.Text = (ex.Message)
        End Try


    End Sub

    Protected Sub cmdUnAssignSite_Click()

        Call CheckUserSession()
        'lblMsgPopup.Text = ""
        Try

            Dim intSiteID = 0
            If GridViewAssigned.VisibleRowCount = 0 Then Exit Sub

            With GridViewAssigned
                Dim rowIndex As Integer = .FocusedRowIndex

                intSiteID = CLng(.GetRowValues(rowIndex, "SiteID").ToString)
            End With
            If intSiteID = 0 Then Exit Sub

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Text = ""
            lblSuccessMsgAssign.Text = ""

            Dim intCustomerID As Integer = -1
            intCustomerID = CInt(Val(txtCustomerIDView.Text))

            Dim strQ As String = "DELETE FROM  CustomerSites WHERE CustomerID =" & intCustomerID & " And SiteID= " & intSiteID
            ExecuteMyQuery(strQ)

            'LoadUserInfo(intUserID)
            SqlDataSourceUnassignedSite.DataBind()
            SqlDataSourceAssignedSite.DataBind()
            GridViewUnassigned.DataBind()
            GridViewAssigned.DataBind()

            lblErrMsgAssign.Visible = False
            lblSuccessMsgAssign.Visible = True
            lblSuccessMsgAssign.Text = "Successfully Removed"


        Catch ex As Exception
            lblSuccessMsgAssign.Visible = False
            lblErrMsgAssign.Visible = True
            lblErrMsgAssign.Text = (ex.Message)
        End Try


    End Sub

    Private Sub GridViewCustomers_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewCustomers.CustomButtonCallback
        Call CheckUserSession()
        Dim intCustomerID = 0
        Dim intCustomerIDTypeID = 0
        If GridViewCustomers.VisibleRowCount = 0 Then Exit Sub

        With GridViewCustomers
            Dim rowIndex As Integer = .FocusedRowIndex

            intCustomerID = CLng(.GetRowValues(rowIndex, "CustomerID").ToString)
        End With
        If intCustomerID = 0 Then Exit Sub

        Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Customers WHERE CustomerID='{0}'", intCustomerID)).Tables(0)

        If dt.Rows.Count > 0 Then

            EmptyView()
            With dt.Rows(0)
                txtCustomerIDView.Text = .Item("CustomerID").ToString
                txtCustomerCodeView.Text = .Item("CustomerCode").ToString
                txtBalanceView.Text = .Item("Balance").ToString


                txtCustomerTypeView.Text = .Item("CustomerType").ToString
                'txtSiteView.Text = .Item("SiteName").ToString
                txtCustomerNameView.Text = .Item("CustomerName").ToString
                txtCustomerAddressView.Text = .Item("CustomerAddress").ToString
                txtEmailView.Text = .Item("EmailAddress").ToString
                txtPhoneNumber1View.Text = .Item("PhoneNumber1").ToString
                txtPhoneNumber2View.Text = .Item("PhoneNumber2").ToString
                txtCreditLimitView.Value = .Item("CreditLimit").ToString
                txtCreditPeriodView.Value = .Item("CreditPeriod").ToString


            End With

            popupView.ShowOnPageLoad = True
        End If
    End Sub

    Private Sub GridViewUnassigned_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewUnassigned.CustomButtonCallback
        Call cmdAssignSite_Click()
    End Sub

    Private Sub GridViewAssigned_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewAssigned.CustomButtonCallback
        Call cmdUnAssignSite_Click()
    End Sub
End Class