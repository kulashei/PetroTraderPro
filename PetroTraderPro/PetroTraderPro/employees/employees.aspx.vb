Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Imports DevExpress.Web
Public Class employees
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CheckUserSession()
            EmptyFields()
        End If
    End Sub

    Private Sub EmptyFields()
        On Error Resume Next

        Dim STR(0) As String
        STR(0) = "Exec Usp_GetCurrentDate"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        dsCurrentDate = dsMany(0)

        StrCurrentDate = dsCurrentDate.Tables(0).Rows(0).Item("CurrentDate")
        SqlDataSourceSearchSite.DataBind()
        cboSiteSearch.DataBind()
        If cboSiteSearch.Items.Count = 1 Then
            cboSiteSearch.SelectedIndex = 0
            txtSiteSearch.Text = cboSiteSearch.Value

        End If
        EmptyEmployeeAdd()
        EmptyEmployeeEdit()


        'If Session("RoleID35Add") = False Then cmdAddProduct.ClientEnabled = False
        'If Session("RoleID35Add") = False Then cmdAddSiteProduct.ClientEnabled = False
        'If Session("RoleID36Add") = False Then cmdAddRate.ClientEnabled = False
        'If Session("RoleID37Add") = False Then cmdAddTank.ClientEnabled = False
        'If Session("RoleID38Add") = False Then cmdAddPump.ClientEnabled = False
        'If Session("RoleID39Add") = False Then cmdAddEmployee.ClientEnabled = False


    End Sub
    Private Sub CheckUserSession()
        'Session("UserID") = 0
        If IsNothing(Session("UserID")) Then
            Session.RemoveAll()
            Response.Redirect("~/SignIn.aspx", True)
        End If
    End Sub
    Private Sub EmptyEmployeeAdd()
        txtSiteNameEmployeeAdd.Text = ""
        txtSiteIDEmployeeAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDEmployeeAdd.Text = cboSiteSearch.Value
            txtSiteNameEmployeeAdd.Text = cboSiteSearch.Text

        End If

        txtStaffIDAdd.Text = ""
        txtFirstNameAdd.Text = ""
        txtOtherNamesAdd.Text = ""
        cboGenderAdd.SelectedIndex = -1
        dtpDateOfBirthAdd.Text = ""
        txtAddressAdd.Text = ""
        txtPhoneNumber1Add.Text = ""
        txtPhoneNumber2Add.Text = ""
        txtContactNameAdd.Text = ""
        txtContactRelationAdd.Text = ""
        txtContactAddressAdd.Text = ""
        txtContactPhoneNumberAdd.Text = ""
        picPictureAdd.ImageUrl = ""
        txtEmployeeTransactionCode.Text = GenerateTransactionCode()


        lblErrMsgEmployeeAdd.ClientVisible = False
        lblSuccessMsgEmployeeAdd.ClientVisible = False
        lblErrMsgEmployeeAdd.Text = ""
        lblSuccessMsgEmployeeAdd.Text = ""


        Dim STR(0) As String
        STR(0) = "Exec Usp_FuelAttendants_GenerateCode"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        Dim dt = dsMany(0).Tables(0)
        txtStaffIDAdd.Text = dt.Rows(0).Item(0)
        SqlDataSourceEmployee.DataBind()
        GridViewEmployee.DataBind()
    End Sub


    Private Sub EmptyEmployeeEdit()
        txtStaffIDEdit.Text = ""
        txtFirstNameEdit.Text = ""
        txtOtherNamesEdit.Text = ""
        cboGenderEdit.SelectedIndex = -1
        dtpDateOfBirthEdit.Text = ""
        txtAddressEdit.Text = ""
        txtPhoneNumber1Edit.Text = ""
        txtPhoneNumber2Edit.Text = ""
        txtContactNameEdit.Text = ""
        txtContactRelationEdit.Text = ""
        txtContactAddressEdit.Text = ""
        txtContactPhoneNumberEdit.Text = ""
        picPictureEdit.ImageUrl = ""

        txtEmployeeIDEdit.Text = 0


        lblErrMsgEmployeeEdit.ClientVisible = False
        lblSuccessMsgEmployeeEdit.ClientVisible = False
        lblErrMsgEmployeeEdit.Text = ""
        lblSuccessMsgEmployeeEdit.Text = ""


        SqlDataSourceEmployee.DataBind()
        GridViewEmployee.DataBind()
    End Sub

    Private Sub cboSiteSearch_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteSearch.ValueChanged
        Call CheckUserSession()

        If cboSiteSearch.Text = "" Then Exit Sub
        Dim intSiteID = 0
        intSiteID = CInt(Val(cboSiteSearch.Value))
        If intSiteID = 0 Then Exit Sub
        txtSiteSearch.Value = intSiteID
        txtSiteIDEmployeeAdd.Text = 0
        txtSiteNameEmployeeAdd.Text = ""

        txtSiteIDEmployeeAdd.Text = intSiteID.ToString
        txtSiteNameEmployeeAdd.Text = cboSiteSearch.Text

        txtSiteIDEmployeeView.Text = intSiteID.ToString
        txtSiteNameEmployeeView.Text = cboSiteSearch.Text

        SqlDataSourceEmployee.DataBind()
        GridViewEmployee.DataBind()

        'txtSiteIDEmployeeEdit.Text = intSiteID.ToString
        'txtSiteNameEmployeeEdit.Text = cboSiteSearch.Text


    End Sub

    Protected Sub cmdSaveYesEmployeeAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEmployeeAdd.Click
        Call CheckUserSession()

        lblErrMsgEmployeeAdd.ClientVisible = False
        lblSuccessMsgEmployeeAdd.ClientVisible = False
        lblErrMsgEmployeeAdd.Text = ""
        lblSuccessMsgEmployeeAdd.Text = ""

        Dim intSiteID As Integer = 0, intBalanceType As Integer = 0


        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboBalanceTypeAdd.Text <> "" Then intBalanceType = cboBalanceTypeAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            Dim da As New SqlDataAdapter("", strCon)
            da.SelectCommand.CommandText = "usp_FuelAttendants_Insert"
            da.SelectCommand.CommandType = CommandType.StoredProcedure

            With da.SelectCommand.Parameters
                .Add(New SqlParameter("@TransactionCode", txtEmployeeTransactionCode.Text.Trim.ToUpper))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@FirstName", txtFirstNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@OtherNames", txtOtherNamesAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Gender", cboGenderAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@BirthDate", VB6.Format(dtpDateOfBirthAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@Address", txtAddressAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Add.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactName", txtContactNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactRelationship", txtContactRelationAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactAddress", txtContactAddressAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactPhoneNumber", txtContactPhoneNumberAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@BalanceDate", VB6.Format(dtpBalanceDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@BalanceTypeID", intBalanceType))
                .Add(New SqlParameter("@OpeningBalance", txtBalanceAmountAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            Dim dt As New DataTable
            da.Fill(dt)

            If dt.Rows.Count > 0 Then

                Dim strPicpath As String = "~/employeePics/" & dt.Rows(0).Item("AttendantID") & ".jpg"

                If FileUploadPictureAdd.HasFile Then
                    FileUploadPictureAdd.SaveAs(Server.MapPath(strPicpath))
                End If

            End If


            EmptyEmployeeAdd()
            lblErrMsgEmployeeAdd.ClientVisible = False
            lblSuccessMsgEmployeeAdd.ClientVisible = True
            lblSuccessMsgEmployeeAdd.Text = "Employee Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgEmployeeAdd.ClientVisible = False
            lblErrMsgEmployeeAdd.ClientVisible = True
            lblErrMsgEmployeeAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesEmployeeEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesEmployeeEdit.Click
        Call CheckUserSession()

        lblErrMsgEmployeeEdit.ClientVisible = False
        lblSuccessMsgEmployeeEdit.ClientVisible = False
        lblErrMsgEmployeeEdit.Text = ""
        lblSuccessMsgEmployeeEdit.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0, intEmployeeID As Integer = 0, intDisabled = 0

        If Val(txtEmployeeID.Text) = 0 Then Exit Sub
        'If Val(lblEmployeeIDEdit.Text) = 0 Then Exit Sub
        intEmployeeID = Val(txtEmployeeID.Text)
        'intEmployeeID = Session("EmployeeID")
        If intEmployeeID = 0 Then Exit Sub
        'If intDisabled = 0 Then Exit Sub


        Try

            If cboSiteEmployeeEdit.Text <> "" Then intSiteID = cboSiteEmployeeEdit.Value
            If chkEmployeeDisableEdit.CheckState = CheckState.Checked Then intDisabled = 1


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendants_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@EmployeeID", intEmployeeID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@FirstName", txtFirstNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@OtherNames", txtOtherNamesEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Gender", cboGenderEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@BirthDate", VB6.Format(dtpDateOfBirthEdit.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@Address", txtAddressEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber1", txtPhoneNumber1Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@PhoneNumber2", txtPhoneNumber2Edit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactName", txtContactNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactRelationship", txtContactRelationEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactAddress", txtContactAddressEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ContactPhoneNumber", txtContactPhoneNumberEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Disabled", intDisabled))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            Dim strPicpath As String = "~/employeePics/" & intEmployeeID.ToString & ".jpg"

            If FileUploadPictureEdit.HasFile Then
                FileUploadPictureEdit.SaveAs(Server.MapPath(strPicpath))
            End If

            EmptyEmployeeEdit()
            lblErrMsgEmployeeEdit.ClientVisible = False
            lblSuccessMsgEmployeeEdit.ClientVisible = True
            lblSuccessMsgEmployeeEdit.Text = "Employee Successfully Registered"
            popupEmployeeEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgEmployeeEdit.ClientVisible = False
            lblErrMsgEmployeeEdit.ClientVisible = True
            lblErrMsgEmployeeEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Sub cmdConfirmEmployeeDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmEmployeeDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intEmployeeID = 0
        intEmployeeID = 0
        intEmployeeID = CInt(Val(txtEmployeeIDDelete.Text))
        If intEmployeeID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelAttendants WHERE EmployeeID={0}", intEmployeeID)
        ExecuteMyQuery(strQuery)
        txtEmployeeIDDelete.Value = 0
        popupEmployeeDelete.ShowOnPageLoad = False
        SqlDataSourceEmployee.DataBind()
        GridViewEmployee.DataBind()

    End Sub

End Class