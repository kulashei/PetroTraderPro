Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Public Class supList
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
        Call EmptyAdd()
        Call EmptyEdit()
        SqlDataSourceSuppliers.DataBind()
        GridViewSuppliers.DataBind()

        '   New Supplier
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=19"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID19Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID19Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID19Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID19View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID19Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
        If Session("RoleID19Edit") = False Then MainMenu.Items.FindByName("Edit").ClientEnabled = False
        If Session("RoleID19Delete") = False Then MainMenu.Items.FindByName("Delete").ClientEnabled = False
        If Session("RoleID19View") = False Then MainMenu.Items.FindByName("Print").ClientEnabled = False

    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next

        txtSupplierCodeAdd.Text = ""
        txtSupplierNameAdd.Text = ""
        txtSupplierAddressAdd.Text = ""
        txtEmailAdd.Text = ""
        txtPhoneNumber1Add.Text = ""
        txtPhoneNumber2Add.Text = ""
        txtCreditPeriodAdd.Value = 0
        dtpBalanceDateAdd.Text = ""
        cboBalanceTypeAdd.SelectedIndex = -1
        txtBalanceAmountAdd.Value = 0
    End Sub

    Private Sub EmptyEdit()
        On Error Resume Next
        txtSupplierIDEdit.Text = 0
        txtSupplierCodeEdit.Text = ""


        txtSupplierNameEdit.Text = ""
        txtSupplierAddressEdit.Text = ""
        txtEmailEdit.Text = ""
        txtPhoneNumber1Edit.Text = ""
        txtPhoneNumber2Edit.Text = ""
        txtCreditPeriodEdit.Value = 0
    End Sub

    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameAdd()
        If NameExist = True Then lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Please Supplier name Already Exist") : txtSupplierNameAdd.Focus() : Exit Sub
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.ClientVisible = False
        lblErrMsgAdd.Text = ""
        lblSuccessMsgAdd.Text = ""

        Dim intBalanceType As Integer = 0


        Try

            If cboBalanceTypeAdd.Text <> "" Then intBalanceType = cboBalanceTypeAdd.Value

            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Suppliers_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SupplierCode", txtSupplierCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SupplierName", txtSupplierNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SupplierAddress", txtSupplierAddressAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@EmailAddress", txtEmailAdd.Text.Trim.ToLower))
                .Add(New SqlParameter("@CreditPeriod", txtCreditPeriodAdd.Value))
                .Add(New SqlParameter("@BalanceDate", VB6.Format(dtpBalanceDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@BalanceTypeID", intBalanceType))
                .Add(New SqlParameter("@OpeningBalance", txtBalanceAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = True
            lblSuccessMsgAdd.Text = "Supplier Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.ClientVisible = True
            lblErrMsgAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEdit.Click
        Call CheckUserSession()
        Dim NameExist As Boolean = CheckItenNameEdit()
        If NameExist = True Then lblErrMsgEdit.ClientVisible = True : lblErrMsgEdit.Text = ("Please Supplier name Already Exist") : txtSupplierNameEdit.Focus() : Exit Sub

        Dim CodeExist As Boolean = CheckItenCodeEdit()
        If CodeExist = True Then lblErrMsgEdit.ClientVisible = True : lblErrMsgEdit.Text = ("Please Supplier Code Already Exist") : txtSupplierNameEdit.Focus() : Exit Sub

        lblErrMsgEdit.ClientVisible = False
       lblErrMsgedit.ClientVisible = False
        lblErrMsgEdit.Text = ""
        lblSuccessMsgEdit.Text = ""

        Dim intSupplierID As Integer = 0


        Try

            intSupplierID = CInt(Val(txtSupplierIDEdit.Text))
            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If
            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_Suppliers_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SupplierID", intSupplierID))
                .Add(New SqlParameter("@SupplierCode", txtSupplierCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SupplierName", txtSupplierNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SupplierAddress", txtSupplierAddressEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@EmailAddress", txtEmailEdit.Text.Trim.ToLower))
                .Add(New SqlParameter("@CreditPeriod", txtCreditPeriodEdit.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()
            EmptyFields()
            lblErrMsgEdit.ClientVisible = False
            lblSuccessMsgEdit.ClientVisible = True
            lblSuccessMsgEdit.Text = "Supplier Successfully Registered"
            popupEdit.ShowOnPageLoad = False

        Catch ex As Exception
           lblErrMsgedit.ClientVisible = False
            lblErrMsgEdit.ClientVisible = True
            lblErrMsgEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Function CheckItenNameAdd() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Suppliers Where SupplierName='" & txtSupplierNameAdd.Text.Trim.ToUpper & "'"
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
        Dim STRQ = "SELECT * FROM Suppliers Where SupplierName='" & txtSupplierNameEdit.Text.Trim.ToUpper & "' AND SupplierID<>" & CLng(Val(txtSupplierIDEdit.Text))
        dtNew = LoadData(STRQ).Tables(0)
        If dtNew.Rows.Count > 0 Then
            Exist = True
        Else
            Exist = False
        End If

        Return Exist
    End Function

    Private Function CheckItenCodeEdit() As Boolean
        dtNew = New DataTable
        Dim Exist As Boolean = False
        Dim STRQ = "SELECT * FROM Suppliers Where SupplierCode='" & txtSupplierCodeEdit.Text.Trim.ToUpper & "' AND SupplierID<>" & CLng(Val(txtSupplierIDEdit.Text))
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
        lblErrMsgDelete.ClientVisible = False
        lblSuccessMsgDelete.ClientVisible = False
        lblErrMsgDelete.Text = ""
        lblSuccessMsgDelete.Text = ""

        'On Error Resume Next
        If GridViewSuppliers.VisibleColumns.Count = 0 Then Exit Sub

        'If Me..Text.Trim = "" Then MsgBox("Please Select The Record to be deleted") : Exit Sub
        Try
            ExecuteMyQuery(String.Format("Delete from Suppliers Where SupplierID={0}", CLng(Val(txtSupplierIDDelete.Text))))
            EmptyFields()
            lblErrMsgDelete.ClientVisible = False
            lblSuccessMsgDelete.ClientVisible = True
            lblSuccessMsgDelete.Text = "Supplier Successfully Deleted"
            PopupConfirmDelete.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgDelete.ClientVisible = False
            lblErrMsgDelete.ClientVisible = True
            lblErrMsgDelete.Text = ("Suppliers Can Not Be Deleted")
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



End Class