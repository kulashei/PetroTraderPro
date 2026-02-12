Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Imports DevExpress.Web

Public Class fuelSetup
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
        EmptyProductAdd()
        EmptyProductEdit()
        EmptySiteProductAdd()
        EmptyRateAdd()
        EmptyTankAdd()
        EmptyPumpAdd()
        EmptyAttendantAdd()
        EmptyAttendantEdit()


        If Session("RoleID35Add") = False Then cmdAddProduct.ClientEnabled = False
        If Session("RoleID35Add") = False Then cmdAddSiteProduct.ClientEnabled = False
        If Session("RoleID36Add") = False Then cmdAddRate.ClientEnabled = False
        If Session("RoleID37Add") = False Then cmdAddTank.ClientEnabled = False
        If Session("RoleID38Add") = False Then cmdAddPump.ClientEnabled = False
        If Session("RoleID39Add") = False Then cmdAddAttendant.ClientEnabled = False


    End Sub
    Private Sub CheckUserSession()
        'Session("UserID") = 0
        If IsNothing(Session("UserID")) Then
            Session.RemoveAll()
            Response.Redirect("~/SignIn.aspx", True)
        End If
    End Sub

    Private Sub EmptyProductAdd()
        txtProductCodeAdd.Text = ""
        txtProductNameAdd.Text = ""

        lblErrMsgProductAdd.ClientVisible = False
        lblSuccessMsgProductAdd.ClientVisible = False
        lblErrMsgProductAdd.Text = ""
        lblSuccessMsgProductAdd.Text = ""

        SqlDataSourceProduct.DataBind()
        GridViewProduct.DataBind()
    End Sub


    Private Sub EmptyProductEdit()
        txtProductIDEdit.Value = 0
        txtProductCodeEdit.Text = ""
        txtProductNameEdit.Text = ""

        lblErrMsgProductEdit.ClientVisible = False
        lblSuccessMsgProductEdit.ClientVisible = False
        lblErrMsgProductEdit.Text = ""
        lblSuccessMsgProductEdit.Text = ""

        SqlDataSourceProduct.DataBind()
        GridViewProduct.DataBind()
    End Sub

    Private Sub EmptySiteProductAdd()
        txtSiteNameSiteProductAdd.Text = ""
        txtSiteIDSiteProductAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDSiteProductAdd.Text = cboSiteSearch.Value
            txtSiteNameSiteProductAdd.Text = cboSiteSearch.Text
        End If


        cboSiteProductProductAdd.SelectedIndex = -1

        SqlDataSourceSiteFuelProduct.DataBind()
        GridViewSiteProduct.DataBind()
    End Sub

    Private Sub EmptyRateAdd()
        txtSiteNameRateAdd.Text = ""
        txtSiteIDRateAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDRateAdd.Text = cboSiteSearch.Value
            txtSiteNameRateAdd.Text = cboSiteSearch.Text

        End If

        cboRateProductAdd.SelectedIndex = -1
        dtpRateDateAdd.MaxDate = CDate(StrCurrentDate)
        dtpRateDateAdd.Value = CDate(StrCurrentDate)

        txtSellingPriceRateAdd.Value = 0
        txtCostPriceRateAdd.Value = 0

        lblErrMsgRateAdd.ClientVisible = False
        lblSuccessMsgRateAdd.ClientVisible = False
        lblErrMsgRateAdd.Text = ""
        lblSuccessMsgRateAdd.Text = ""


        SqlDataSourceSiteFuelProduct.DataBind()
        GridViewRate.DataBind()
    End Sub

    Private Sub EmptyTankAdd()
        txtSiteNameTankAdd.Text = ""
        txtSiteIDTankAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDTankAdd.Text = cboSiteSearch.Value
            txtSiteNameTankAdd.Text = cboSiteSearch.Text

        End If

        cboTankProductAdd.SelectedIndex = -1

        txtTankCodeAdd.Text = ""
        txtTankCapacityAdd.Value = 0

        lblErrMsgTankAdd.ClientVisible = False
        lblSuccessMsgTankAdd.ClientVisible = False
        lblErrMsgTankAdd.Text = ""
        lblSuccessMsgTankAdd.Text = ""


        SqlDataSourceTank.DataBind()
        GridViewTank.DataBind()
    End Sub

    Private Sub EmptyTankEdit()
        txtSiteNameTankEdit.Text = ""
        txtSiteIDTankEdit.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDTankEdit.Text = cboSiteSearch.Value
            txtSiteNameTankEdit.Text = cboSiteSearch.Text

        End If
        txtTankIDEdit.Text = 0

        cboTankProductEdit.SelectedIndex = -1

        txtTankCodeEdit.Text = ""
        txtTankCapacityEdit.Value = 0

        lblErrMsgTankEdit.ClientVisible = False
        lblSuccessMsgTankEdit.ClientVisible = False
        lblErrMsgTankEdit.Text = ""
        lblSuccessMsgTankEdit.Text = ""



        SqlDataSourceTank.DataBind()
        GridViewTank.DataBind()
    End Sub

    Private Sub EmptyPumpAdd()
        txtSiteNamePumpAdd.Text = ""
        txtSiteIDPumpAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDPumpAdd.Text = cboSiteSearch.Value
            txtSiteNamePumpAdd.Text = cboSiteSearch.Text

        End If

        cboPumpTankAdd.SelectedIndex = -1

        txtPumpCodeAdd.Text = ""

        lblErrMsgPumpAdd.ClientVisible = False
        lblSuccessMsgPumpAdd.ClientVisible = False
        lblErrMsgPumpAdd.Text = ""
        lblSuccessMsgPumpAdd.Text = ""



        SqlDataSourcePump.DataBind()
        GridViewPump.DataBind()
    End Sub

    Private Sub EmptyPumpEdit()
        txtSiteNamePumpEdit.Text = ""
        txtSiteIDPumpEdit.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDPumpEdit.Text = cboSiteSearch.Value
            txtSiteNamePumpEdit.Text = cboSiteSearch.Text

        End If

        cboPumpTankEdit.SelectedIndex = -1

        txtPumpCodeEdit.Text = ""


        lblErrMsgPumpEdit.ClientVisible = False
        lblSuccessMsgPumpEdit.ClientVisible = False
        lblErrMsgPumpEdit.Text = ""
        lblSuccessMsgPumpEdit.Text = ""



        SqlDataSourcePump.DataBind()
        GridViewPump.DataBind()
    End Sub

    Private Sub EmptyAttendantAdd()
        txtSiteNameAttendantAdd.Text = ""
        txtSiteIDAttendantAdd.Text = ""
        If cboSiteSearch.Text <> "" Then
            txtSiteIDAttendantAdd.Text = cboSiteSearch.Value
            txtSiteNameAttendantAdd.Text = cboSiteSearch.Text

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
        txtAttendantTransactionCode.Text = GenerateTransactionCode()


        lblErrMsgAttendantAdd.ClientVisible = False
        lblSuccessMsgAttendantAdd.ClientVisible = False
        lblErrMsgAttendantAdd.Text = ""
        lblSuccessMsgAttendantAdd.Text = ""


        Dim STR(0) As String
        STR(0) = "Exec Usp_FuelAttendants_GenerateCode"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        Dim dt = dsMany(0).Tables(0)
        txtStaffIDAdd.Text = dt.Rows(0).Item(0)
        SqlDataSourceAttendant.DataBind()
        GridViewAttendant.DataBind()
    End Sub


    Private Sub EmptyAttendantEdit()
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

        txtAttendantIDEdit.Text = 0


        lblErrMsgAttendantEdit.ClientVisible = False
        lblSuccessMsgAttendantEdit.ClientVisible = False
        lblErrMsgAttendantEdit.Text = ""
        lblSuccessMsgAttendantEdit.Text = ""


        SqlDataSourceAttendant.DataBind()
        GridViewAttendant.DataBind()
    End Sub

    Protected Sub cmdSaveYesProductAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesProductAdd.Click
        Call CheckUserSession()

        lblErrMsgProductAdd.ClientVisible = False
        lblSuccessMsgProductAdd.ClientVisible = False
        lblErrMsgProductAdd.Text = ""
        lblSuccessMsgProductAdd.Text = ""



        Try



            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelProducts_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ProductCode", txtProductCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ProductName", txtProductNameAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyProductAdd()
            lblErrMsgProductAdd.ClientVisible = False
            lblSuccessMsgProductAdd.ClientVisible = True
            lblSuccessMsgProductAdd.Text = "Product Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgProductAdd.ClientVisible = False
            lblErrMsgProductAdd.ClientVisible = True
            lblErrMsgProductAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesProductEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesProductEdit.Click
        Call CheckUserSession()

        lblErrMsgProductEdit.ClientVisible = False
        lblSuccessMsgProductEdit.ClientVisible = False
        lblErrMsgProductEdit.Text = ""
        lblSuccessMsgProductEdit.Text = ""



        Try



            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelProducts_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ProductID", CInt(Val(txtProductIDEdit.Text))))
                .Add(New SqlParameter("@ProductCode", txtProductCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@ProductName", txtProductNameEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyProductEdit()
            lblErrMsgProductEdit.ClientVisible = False
            lblSuccessMsgProductEdit.ClientVisible = True
            lblSuccessMsgProductEdit.Text = "Product Successfully Registered"
            popupProductEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgProductEdit.ClientVisible = False
            lblErrMsgProductEdit.ClientVisible = True
            lblErrMsgProductEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Sub cmdConfirmProductDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmProductDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intProductID = 0
        intProductID = 0
        intProductID = CInt(Val(txtProductIDDelete.Text))
        If intProductID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelProducts WHERE ProductID={0}", intProductID)
        ExecuteMyQuery(strQuery)
        txtProductIDDelete.Value = 0
        popupProductDelete.ShowOnPageLoad = False
        SqlDataSourceProduct.DataBind()
        GridViewProduct.DataBind()

    End Sub

    Private Sub EmptySiteLabel()
        txtSiteIDSiteProductAdd.Text = 0
        txtSiteNameSiteProductAdd.Text = ""

        txtSiteIDRateAdd.Text = 0
        txtSiteNameRateAdd.Text = ""

        txtSiteIDTankAdd.Text = 0
        txtSiteNameTankAdd.Text = ""

        txtSiteIDTankEdit.Text = 0
        txtSiteNameTankEdit.Text = ""

        txtSiteIDPumpAdd.Text = 0
        txtSiteNamePumpAdd.Text = ""

        txtSiteIDPumpEdit.Text = 0
        txtSiteNamePumpEdit.Text = ""

        txtSiteIDAttendantAdd.Text = 0
        txtSiteNameAttendantAdd.Text = ""

    End Sub
    Private Sub cboSiteSearch_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteSearch.ValueChanged
        Call CheckUserSession()

        If cboSiteSearch.Text = "" Then Exit Sub
        Dim intSiteID = 0
        intSiteID = CInt(Val(cboSiteSearch.Value))
        If intSiteID = 0 Then Exit Sub
        txtSiteSearch.Value = intSiteID
        EmptySiteLabel()

        txtSiteIDSiteProductAdd.Text = intSiteID.ToString
        txtSiteNameSiteProductAdd.Text = cboSiteSearch.Text

        txtSiteIDRateAdd.Text = intSiteID.ToString
        txtSiteNameRateAdd.Text = cboSiteSearch.Text

        txtSiteIDTankAdd.Text = intSiteID.ToString
        txtSiteNameTankAdd.Text = cboSiteSearch.Text

        txtSiteIDTankEdit.Text = intSiteID.ToString
        txtSiteNameTankEdit.Text = cboSiteSearch.Text

        txtSiteIDPumpAdd.Text = intSiteID.ToString
        txtSiteNamePumpAdd.Text = cboSiteSearch.Text

        txtSiteIDPumpEdit.Text = intSiteID.ToString
        txtSiteNamePumpEdit.Text = cboSiteSearch.Text

        txtSiteIDAttendantAdd.Text = intSiteID.ToString
        txtSiteNameAttendantAdd.Text = cboSiteSearch.Text

        txtSiteIDAttendantView.Text = intSiteID.ToString
        txtSiteNameAttendantView.Text = cboSiteSearch.Text

        'txtSiteIDAttendantEdit.Text = intSiteID.ToString
        'txtSiteNameAttendantEdit.Text = cboSiteSearch.Text


    End Sub

    Protected Sub cmdSaveYesSiteProductAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesSiteProductAdd.Click
        Call CheckUserSession()

        lblErrMsgSiteProductAdd.ClientVisible = False
        lblSuccessMsgSiteProductAdd.ClientVisible = False
        lblErrMsgSiteProductAdd.Text = ""
        lblSuccessMsgSiteProductAdd.Text = ""

        Dim intSiteID As Integer = 0, intProductID As Integer = 0


        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboSiteProductProductAdd.Text <> "" Then intProductID = cboSiteProductProductAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_SiteFuelProducts_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@ProductID", intProductID))
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptySiteProductAdd()
            lblErrMsgSiteProductAdd.ClientVisible = False
            lblSuccessMsgSiteProductAdd.ClientVisible = True
            lblSuccessMsgSiteProductAdd.Text = "Site Product Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgSiteProductAdd.ClientVisible = False
            lblErrMsgSiteProductAdd.ClientVisible = True
            lblErrMsgSiteProductAdd.Text = (ex.Message)
        End Try

    End Sub

    'Private Sub cboRateProductAdd_ValueChanged(sender As Object, e As EventArgs) Handles cboRateProductAdd.ValueChanged
    '    Call CheckUserSession()
    '    On Error Resume Next

    '    If cboRateProductAdd.Text = "" Then Exit Sub
    '    Dim dtTemp As System.Data.DataTable
    '    dtTemp = CType(SqlDataSourceRate.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

    '    dtTemp.DefaultView.RowFilter = "ProductID=" & cboRateProductAdd.Value
    '    Dim dtTemp1 = dtTemp.DefaultView.ToTable

    '    If dtTemp1.Rows.Count > 0 Then
    '        txtCostPriceRateAdd.Value = dtTemp1.Rows(0).Item("CostPrice")

    '    End If

    'End Sub

    Protected Sub cmdSaveYesRateAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesRateAdd.Click
        Call CheckUserSession()

        lblErrMsgRateAdd.ClientVisible = False
        lblSuccessMsgRateAdd.ClientVisible = False
        lblErrMsgRateAdd.Text = ""
        lblSuccessMsgRateAdd.Text = ""

        Dim intSiteID As Integer = 0, intProductID As Integer = 0


        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboRateProductAdd.Text <> "" Then intProductID = cboRateProductAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelRate_InsertOrUpdate"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SiteID", intSiteID))
                .Add(New SqlParameter("@ProductID", intProductID))
                .Add(New SqlParameter("@RateDate", VB6.Format(dtpRateDateAdd.Value.Date, "dd-MMM-yyyy")))
                .Add(New SqlParameter("@Rate", txtSellingPriceRateAdd.Value))
                .Add(New SqlParameter("@CostPrice", txtCostPriceRateAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyRateAdd()
            lblErrMsgRateAdd.ClientVisible = False
            lblSuccessMsgRateAdd.ClientVisible = True
            lblSuccessMsgRateAdd.Text = "Price Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgRateAdd.ClientVisible = False
            lblErrMsgRateAdd.ClientVisible = True
            lblErrMsgRateAdd.Text = (ex.Message)
        End Try

    End Sub


    Protected Sub cmdSaveYesTankAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesTankAdd.Click
        Call CheckUserSession()

        lblErrMsgTankAdd.ClientVisible = False
        lblSuccessMsgTankAdd.ClientVisible = False
        lblErrMsgTankAdd.Text = ""
        lblSuccessMsgTankAdd.Text = ""

        Dim intSiteID As Integer = 0, intSiteProductID As Integer = 0


        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboTankProductAdd.Text <> "" Then intSiteProductID = cboTankProductAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelTanks_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@SiteProductID", intSiteProductID))
                .Add(New SqlParameter("@TankCode", txtTankCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Capacity", txtTankCapacityAdd.Value))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyTankAdd()
            lblErrMsgTankAdd.ClientVisible = False
            lblSuccessMsgTankAdd.ClientVisible = True
            lblSuccessMsgTankAdd.Text = "Tank Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgTankAdd.ClientVisible = False
            lblErrMsgTankAdd.ClientVisible = True
            lblErrMsgTankAdd.Text = (ex.Message)
        End Try

    End Sub


    Protected Sub cmdSaveYesTankEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesTankEdit.Click
        Call CheckUserSession()

        lblErrMsgTankEdit.ClientVisible = False
        lblSuccessMsgTankEdit.ClientVisible = False
        lblErrMsgTankEdit.Text = ""
        lblSuccessMsgTankEdit.Text = ""

        Dim intSiteID As Integer = 0, intSiteProductID As Integer = 0, intTankID As Integer = 0, intDisabled = 0

        If Val(txtTankIDEdit.Text) = 0 Then Exit Sub
        intTankID = Val(txtTankIDEdit.Text)

        Dim dt As DataTable = LoadData(String.Format("EXEC usp_FuelTanks_CheckForExistingCode @TankID={0}, @NewTankCode='{1}'", intTankID, txtTankCodeEdit.Text.Trim.ToUpper)).Tables(0)
        If dt.Rows(0).Item(0) > 0 Then lblErrMsgTankEdit.ClientVisible = False : lblSuccessMsgTankEdit.ClientVisible = True : lblSuccessMsgTankEdit.Text = "Tank Code Already Exist For Another Tank" : Exit Sub

        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboTankProductEdit.Text <> "" Then intSiteProductID = cboTankProductEdit.Value
            If chkTankDisableEdit.CheckState = CheckState.Checked Then intDisabled = 1


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelTanks_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@SiteProductID", intSiteProductID))
                .Add(New SqlParameter("@TankCode", txtTankCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Capacity", txtTankCapacityEdit.Value))
                .Add(New SqlParameter("@Disabled", intDisabled))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyTankEdit()
            lblErrMsgTankEdit.ClientVisible = False
            lblSuccessMsgTankEdit.ClientVisible = True
            lblSuccessMsgTankEdit.Text = "Tank Successfully Registered"
            popupTankEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgTankEdit.ClientVisible = False
            lblErrMsgTankEdit.ClientVisible = True
            lblErrMsgTankEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Sub cmdConfirmTankDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmTankDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intTankID = 0
        intTankID = 0
        intTankID = CInt(Val(txtTankIDDelete.Text))
        If intTankID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelTanks WHERE TankID={0}", intTankID)
        ExecuteMyQuery(strQuery)
        txtTankIDDelete.Value = 0
        popupTankDelete.ShowOnPageLoad = False
        SqlDataSourceTank.DataBind()
        GridViewTank.DataBind()

    End Sub

    Protected Sub cmdSaveYesPumpAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesPumpAdd.Click
        Call CheckUserSession()

        lblErrMsgPumpAdd.ClientVisible = False
        lblSuccessMsgPumpAdd.ClientVisible = False
        lblErrMsgPumpAdd.Text = ""
        lblSuccessMsgPumpAdd.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0


        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboPumpTankAdd.Text <> "" Then intTankID = cboPumpTankAdd.Value


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelPumps_Insert"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@PumpCode", txtPumpCodeAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyPumpAdd()
            lblErrMsgPumpAdd.ClientVisible = False
            lblSuccessMsgPumpAdd.ClientVisible = True
            lblSuccessMsgPumpAdd.Text = "Pump Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgPumpAdd.ClientVisible = False
            lblErrMsgPumpAdd.ClientVisible = True
            lblErrMsgPumpAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesPumpEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesPumpEdit.Click
        Call CheckUserSession()

        lblErrMsgPumpEdit.ClientVisible = False
        lblSuccessMsgPumpEdit.ClientVisible = False
        lblErrMsgPumpEdit.Text = ""
        lblSuccessMsgPumpEdit.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0, intPumpID As Integer = 0, intDisabled = 0

        If Val(txtPumpIDEdit.Text) = 0 Then Exit Sub
        intPumpID = Val(txtPumpIDEdit.Text)

        Dim dt As DataTable = LoadData(String.Format("EXEC usp_FuelPumps_CheckForExistingCode @PumpID={0}, @NewPumpCode='{1}'", intPumpID, txtPumpCodeEdit.Text.Trim.ToUpper)).Tables(0)
        If dt.Rows(0).Item(0) > 0 Then lblErrMsgPumpEdit.ClientVisible = False : lblSuccessMsgPumpEdit.ClientVisible = True : lblSuccessMsgPumpEdit.Text = "Pump Code Already Exist For Another Pump" : Exit Sub

        Try

            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value
            If cboPumpTankEdit.Text <> "" Then intTankID = cboPumpTankEdit.Value
            If chkPumpDisableEdit.CheckState = CheckState.Checked Then intDisabled = 1


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelPumps_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@PumpID", intPumpID))
                .Add(New SqlParameter("@TankID", intTankID))
                .Add(New SqlParameter("@PumpCode", txtPumpCodeEdit.Text.Trim.ToUpper))
                .Add(New SqlParameter("@Disabled", intDisabled))
                .Add(New SqlParameter("@UserID", Session("UserID")))
            End With
            objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()


            EmptyPumpEdit()
            lblErrMsgPumpEdit.ClientVisible = False
            lblSuccessMsgPumpEdit.ClientVisible = True
            lblSuccessMsgPumpEdit.Text = "Pump Successfully Registered"
            popupPumpEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgPumpEdit.ClientVisible = False
            lblErrMsgPumpEdit.ClientVisible = True
            lblErrMsgPumpEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Sub cmdConfirmPumpDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmPumpDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intPumpID = 0
        intPumpID = 0
        intPumpID = CInt(Val(txtPumpIDDelete.Text))
        If intPumpID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelPumps WHERE PumpID={0}", intPumpID)
        ExecuteMyQuery(strQuery)
        txtPumpIDDelete.Value = 0
        popupPumpDelete.ShowOnPageLoad = False
        SqlDataSourcePump.DataBind()
        GridViewPump.DataBind()

    End Sub

    Private Sub WriteDocumentToResponse(ByVal documentData() As Byte, ByVal format As String, ByVal isInline As Boolean, ByVal fileName As String)

        Dim disposition As String = If(isInline, "inline", "attachment")

        Response.Clear()
        Response.ContentType = "application/pdf"
        Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}", disposition, fileName))
        Response.BinaryWrite(documentData)
        Response.End()
    End Sub

    Private Sub cmdPrintAttendant_Click(sender As Object, e As EventArgs) Handles cmdPrintAttendant.Click
        On Error Resume Next
        Call CheckUserSession()
        'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

        'Response.Redirect("~/paymentreceipt1.aspx")
        'If CLng(Session("PaymentID")) = 0 Then Exit Sub
        Dim printFlag As Boolean = Nothing
        Dim stream = New MemoryStream()
        Dim report As New XtraRptAttendantDetails
        Dim intAttendantID = 0
        If Val(txtAttendantIDView.Text) <> 0 Then intAttendantID = CInt(Val(txtAttendantIDView.Text))

        Dim dt As DataTable = LoadData(String.Format("EXEC Usp_FuelAttendants_RPTByAttendantID @AttendantID={0}", intAttendantID)).Tables(0)
        report.DataSource = dt
        'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
        report.XrPicLogo.ImageUrl = "~/img/logo1.png"
        report.XrPicPicture.ImageUrl = "~/employeePics/" & intAttendantID.ToString & ".jpg"

        Using ms As New MemoryStream()
            report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
            WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Attendant.pdf")
        End Using


    End Sub

    Protected Sub cmdSaveYesAttendantAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAttendantAdd.Click
        Call CheckUserSession()

        lblErrMsgAttendantAdd.ClientVisible = False
        lblSuccessMsgAttendantAdd.ClientVisible = False
        lblErrMsgAttendantAdd.Text = ""
        lblSuccessMsgAttendantAdd.Text = ""

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
                .Add(New SqlParameter("@TransactionCode", txtAttendantTransactionCode.Text.Trim.ToUpper))
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


            EmptyAttendantAdd()
            lblErrMsgAttendantAdd.ClientVisible = False
            lblSuccessMsgAttendantAdd.ClientVisible = True
            lblSuccessMsgAttendantAdd.Text = "Attendant Successfully Registered"


        Catch ex As Exception
            lblSuccessMsgAttendantAdd.ClientVisible = False
            lblErrMsgAttendantAdd.ClientVisible = True
            lblErrMsgAttendantAdd.Text = (ex.Message)
        End Try

    End Sub

    Protected Sub cmdSaveYesAttendantEdit_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAttendantEdit.Click
        Call CheckUserSession()

        lblErrMsgAttendantEdit.ClientVisible = False
        lblSuccessMsgAttendantEdit.ClientVisible = False
        lblErrMsgAttendantEdit.Text = ""
        lblSuccessMsgAttendantEdit.Text = ""

        Dim intSiteID As Integer = 0, intTankID As Integer = 0, intAttendantID As Integer = 0, intDisabled = 0

        If Val(txtAttendantID.Text) = 0 Then Exit Sub
        'If Val(lblAttendantIDEdit.Text) = 0 Then Exit Sub
        intAttendantID = Val(txtAttendantID.Text)
        'intAttendantID = Session("AttendantID")
        If intAttendantID = 0 Then Exit Sub
        'If intDisabled = 0 Then Exit Sub


        Try

            If cboSiteAttendantEdit.Text <> "" Then intSiteID = cboSiteAttendantEdit.Value
            If chkAttendantDisableEdit.CheckState = CheckState.Checked Then intDisabled = 1


            If objConnect.State = ConnectionState.Closed Then
                Call ConnectDBase()
            End If

            objCommand = New SqlCommand
            objCommand.Connection = objConnect
            objCommand.CommandText = "usp_FuelAttendants_Update"
            objCommand.CommandType = CommandType.StoredProcedure

            With objCommand.Parameters
                .Add(New SqlParameter("@AttendantID", intAttendantID))
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

            Dim strPicpath As String = "~/employeePics/" & intAttendantID.ToString & ".jpg"

            If FileUploadPictureEdit.HasFile Then
                FileUploadPictureEdit.SaveAs(Server.MapPath(strPicpath))
            End If

            EmptyAttendantEdit()
            lblErrMsgAttendantEdit.ClientVisible = False
            lblSuccessMsgAttendantEdit.ClientVisible = True
            lblSuccessMsgAttendantEdit.Text = "Attendant Successfully Registered"
            popupAttendantEdit.ShowOnPageLoad = False

        Catch ex As Exception
            lblSuccessMsgAttendantEdit.ClientVisible = False
            lblErrMsgAttendantEdit.ClientVisible = True
            lblErrMsgAttendantEdit.Text = (ex.Message)
        End Try

    End Sub

    Private Sub cmdConfirmAttendantDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmAttendantDeleteYes.Click
        On Error Resume Next
        Call CheckUserSession()
        Dim intAttendantID = 0
        intAttendantID = 0
        intAttendantID = CInt(Val(txtAttendantIDDelete.Text))
        If intAttendantID = 0 Then Exit Sub

        Dim strQuery As String = String.Format("DELETE FROM FuelAttendants WHERE AttendantID={0}", intAttendantID)
        ExecuteMyQuery(strQuery)
        txtAttendantIDDelete.Value = 0
        popupAttendantDelete.ShowOnPageLoad = False
        SqlDataSourceAttendant.DataBind()
        GridViewAttendant.DataBind()

    End Sub

    Private Sub fuelSetup_Init(sender As Object, e As EventArgs) Handles Me.Init
        '  New Fuel Product
        CheckUserSession()
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=35"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID35Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID35Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID35Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID35View") = Session("TempUserRole").Rows(0).Item("CanView")

        ' Change Fuel Rate
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=36"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID36Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID36Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID36Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID36View") = Session("TempUserRole").Rows(0).Item("CanView")

        '  Fuel Tank
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=37"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID37Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID37Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID37Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID37View") = Session("TempUserRole").Rows(0).Item("CanView")

        '  Fuel Pump
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=38"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID38Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID38Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID38Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID38View") = Session("TempUserRole").Rows(0).Item("CanView")

        '  Fuel Attendants
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=39"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID39Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID39Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID39Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID39View") = Session("TempUserRole").Rows(0).Item("CanView")

    End Sub

    Private Sub GridViewProduct_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewProduct.CustomButtonInitialize

        If Session("RoleID35Edit") = False Then
            If e.ButtonID = "cmdEditProduct" Then e.Enabled = False
        End If
        If Session("RoleID35Edit") = False Then
            If e.ButtonID = "cmdDeleteProduct" Then e.Enabled = False
        End If
    End Sub

    Private Sub GridViewRate_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewRate.CustomButtonInitialize

        If Session("RoleID36Edit") = False Then
            If e.ButtonID = "cmdDeleteSiteRate" Then e.Enabled = False
        End If
    End Sub

    Private Sub GridViewPump_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewPump.CustomButtonInitialize

        If Session("RoleID38Edit") = False Then
            If e.ButtonID = "cmdEditPump" Then e.Enabled = False
        End If
        If Session("RoleID38Edit") = False Then
            If e.ButtonID = "cmdDeletePump" Then e.Enabled = False
        End If
    End Sub

    Private Sub GridViewTank_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewTank.CustomButtonInitialize

        If Session("RoleID37Edit") = False Then
            If e.ButtonID = "cmdEditTank" Then e.Enabled = False
        End If
        If Session("RoleID37Edit") = False Then
            If e.ButtonID = "cmdDeleteTank" Then e.Enabled = False
        End If
    End Sub

    Private Sub GridViewAttendant_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewAttendant.CustomButtonInitialize

        If Session("RoleID39Edit") = False Then
            If e.ButtonID = "cmdEdit" Then e.Enabled = False
        End If
        If Session("RoleID39Edit") = False Then
            If e.ButtonID = "cmdDelete" Then e.Enabled = False
        End If
    End Sub

    Private Sub GridViewSiteProduct_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles GridViewSiteProduct.CustomButtonInitialize

        If Session("RoleID35Edit") = False Then
            If e.ButtonID = "cmdDeleteSiteProduct" Then e.Enabled = False
        End If
    End Sub

    'Private Sub GridViewAttendant_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewAttendant.CustomButtonCallback
    '    Call CheckUserSession()
    '    If e.ButtonID = "cmdEditAttendant" Then
    '        cmdViewAttendant_Click()
    '    End If

    'End Sub

    'Protected Sub cmdViewAttendant_Click()
    '    Call CheckUserSession()
    '    Dim intAttendantID = 0
    '    Dim intAttendantIDTypeID = 0
    '    If GridViewAttendant.VisibleRowCount = 0 Then Exit Sub

    '    With GridViewAttendant
    '        Dim rowIndex As Integer = .FocusedRowIndex

    '        intAttendantID = CLng(.GetRowValues(rowIndex, "AttendantID").ToString)
    '    End With
    '    If intAttendantID = 0 Then Exit Sub

    '    Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_FuelAttendants WHERE AttendantID='{0}'", intAttendantID)).Tables(0)

    '    If dt.Rows.Count > 0 Then

    '        EmptyAttendantEdit()
    '        popupAttendantEdit.ShowOnPageLoad = True

    '        With dt.Rows(0)
    '            'txtAttendantIDView.Text = .Item("AttendantID").ToString
    '            'cboSiteAttendantEdit.Value = CInt(.Item("SiteID").ToString)
    '            'txtStaffIDEdit.Text = .Item("AttendantCode").ToString
    '            'txtFirstNameEdit.Text = .Item("FirstName").ToString
    '            'txtOtherNamesEdit.Text = .Item("SiteName").ToString
    '            'cboGenderEdit.SelectedIndex = -1
    '            'dtpDateOfBirthEdit.Text = .Item("SiteName").ToString
    '            'txtAddressEdit.Text = .Item("SiteName").ToString
    '            'txtPhoneNumber1Edit.Text = .Item("SiteName").ToString
    '            'txtPhoneNumber2Edit.Text = .Item("SiteName").ToString
    '            'txtContactNameEdit.Text = .Item("SiteName").ToString
    '            'txtContactRelationEdit.Text = .Item("SiteName").ToString
    '            'txtContactAddressEdit.Text = .Item("SiteName").ToString
    '            'txtContactPhoneNumberEdit.Text = .Item("SiteName").ToString
    '            'picPictureEdit.ImageUrl = .Item("SiteName").ToString

    '            'txtAttendantIDEdit.Text = 0

    '        End With

    '    End If



    'End Sub

End Class