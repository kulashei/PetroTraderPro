Imports System.Data.SqlClient
Imports Microsoft.VisualBasic.Compatibility
Imports DevExpress.XtraPrinting
Imports System.IO
Public Class Expenditure

    Inherits System.Web.UI.Page
    Private NCount As Integer, intPaid As Integer, intExpenditureID As Long

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

            dtpExpenditureDateAdd.MaxDate = DateCurrendDate
            dtpExpenditureDateAdd.Value = DateCurrendDate

            dtpExpenditureDateEdit.MaxDate = DateCurrendDate
            dtpExpenditureDateEdit.Value = DateCurrendDate

            dtpSearchDateFrom.MaxDate = DateCurrendDate
            dtpSearchDateFrom.Value = DateCurrendDate
            dtpSearchDateTo.Value = DateCurrendDate
            dtpSearchDateFrom.MaxDate = DateCurrendDate


            txtSearchDateFrom.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
            txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")
            txtSearchDateTo.Text = VB6.Format(DateCurrendDate, "dd-MMM-yyyy")


            SqlDataSourceSites.DataBind()
            SqlDataSourceSearchSite.DataBind()

            cboSiteEdit.DataBind()
            cboSiteSearch.DataBind()

            cboSiteEdit.SelectedIndex = -1
            cboSiteSearch.SelectedIndex = -1
            txtSiteSearch.Text = 0


            'cboSite.SelectedIndex = 0
            'SqlDataSourceAccount.SelectParameters(0) = cboSite.Value

            If cboSiteEdit.Items.Count = 1 Then cboSiteEdit.SelectedIndex = 0
            If cboSiteSearch.Items.Count = 1 Then cboSiteSearch.SelectedIndex = 0 : txtSiteSearch.Text = cboSiteSearch.Value
            EmptyAdd1()

            If Session("RoleID1") = False Then dtpExpenditureDateAdd.ClientEnabled = False
            If Session("RoleID1") = False Then dtpExpenditureDateEdit.ClientEnabled = False

            '  Expenditure
            Session("TempUserRole") = New DataTable
            Session("AllUserRoles").DefaultView.RowFilter = "RoleID=31"
            Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

            Session("RoleID31Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
            Session("RoleID31Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
            Session("RoleID31Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
            Session("RoleID31View") = Session("TempUserRole").Rows(0).Item("CanView")

            If Session("RoleID31Add") = False Then MainMenu.Items.FindByName("New").ClientEnabled = False
            'If Session("RoleID31Edit") = False Then cmdEdit.ClientEnabled = False
            'If Session("RoleID31Edit") = False Then cmd.ClientEnabled = False
            If Session("RoleID31Delete") = False Then cmdDelete.ClientEnabled = False

            If Session("RoleID31View") = False Then cmdSearcByDate.ClientEnabled = False
            If Session("RoleID31View") = False Then cmdViewExpenditureReport.ClientEnabled = False

        End Sub


        Private Sub EmptyAdd()

            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.Text = ""
            lblSuccessMsgAdd.Text = ""

            cboSiteAdd.Text = ""
            dtpExpenditureDateAdd.Text = ""
            cboAccountAdd.Text = ""
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtTransactionDetailsAdd.Text = ""
            txtAuthorisedByAdd.Text = ""
            txtAmountAdd.Text = 0

            cboAccountAdd.SelectedIndex = -1
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtAmountAdd.Value = 0

            txtTransactionCode.Text = GenerateTransactionCode()

        End Sub
        Private Sub EmptyAdd1()

            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.Text = ""
            lblSuccessMsgAdd.Text = ""

            SqlDataSourceAccountAdd.DataBind()
            SqlDataSourceAccountEdit.DataBind()
            SqlDataSourceExpCategory.DataBind()
            SqlDataSourceAccountEdit.DataBind()


            cboSiteAdd.Text = ""
            dtpExpenditureDateAdd.Text = ""
            cboAccountAdd.Text = ""
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtTransactionDetailsAdd.Text = ""
            txtAuthorisedByAdd.Text = ""
            txtAmountAdd.Text = 0



            cboAccountAdd.SelectedIndex = -1
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtAmountAdd.Value = 0
        End Sub

        Private Sub EmptyAdd2()
            cboAccountAdd.SelectedIndex = -1
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtAmountAdd.Value = 0
            lblErrMsgGen.Text = ""
        End Sub
        Private Sub EmptyAdd3()

            cboSiteAdd.Text = ""
            dtpExpenditureDateAdd.Text = ""
            cboAccountAdd.Text = ""
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtTransactionDetailsAdd.Text = ""
            txtAuthorisedByAdd.Text = ""
            txtAmountAdd.Text = 0

            cboAccountAdd.SelectedIndex = -1
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtAmountAdd.Value = 0
            SqlDataSourceAccountAdd.DataBind()


            lblErrMsgGen.Text = ""
        End Sub

        Private Sub EmptyRec()
            EmptyView()
            EmptyAdd3()
            cboAccountAdd.SelectedIndex = -1
            txtTransactionNumberAdd.Text = ""
            txtReceiptNumberAdd.Text = ""
            txtAmountAdd.Value = 0

            SqlDataSourceExpenditure.DataBind()
            GridViewExpenditure.DataBind()

            SqlDataSourceExpenditure.DataBind()
            GridViewExpenditure.DataBind()


            txtTransactionCode.Text = GenerateTransactionCode()

        End Sub

        Private Sub EmptyView()

            txtExpenditureIDView.Text = 0
            txtSiteNameView.Text = ""
            txtExpenditureDateView.Text = ""
            txtAccountView.Text = ""
            txtCategoryView.Text = ""
            txtTransactionNumberView.Text = ""
            txtReceiptNumberView.Text = ""
            txtTransactionDetailsView.Text = ""
            txtAuthorisedByView.Text = ""
            txtAmountView.Value = 0

            txtAmountView.Value = 0
        End Sub

        Private Sub EmptyEdit()

            txtExpenditureIDEdit.Text = 0
            cboSiteEdit.SelectedIndex = -1
            cboAccountEdit.SelectedIndex = -1
            cboCategoryEdit.SelectedIndex = -1
            txtTransactionNumberEdit.Text = ""
            txtReceiptNumberEdit.Text = ""
            txtTransactionDetailsEdit.Text = ""
            txtAuthorisedByEdit.Text = ""
            txtAmountEdit.Value = 0
        End Sub

        Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
            Call CheckUserSession()

            lblErrMsgAdd.ClientVisible = False
            lblSuccessMsgAdd.ClientVisible = False
            lblErrMsgAdd.Text = ""
            lblSuccessMsgAdd.Text = ""

            Dim intAccountID As Integer = 0


            Dim intSiteID As Integer = 0, intCategoryID As Integer = 0

            If cboCategoryAdd.SelectedIndex = -1 Then lblSuccessMsgAdd.ClientVisible = False : lblErrMsgAdd.ClientVisible = True : lblErrMsgAdd.Text = ("Select the Category") : Exit Sub


            Try

                If cboSiteAdd.Text <> "" Then intSiteID = cboSiteAdd.Value
                If cboCategoryAdd.Text <> "" Then intCategoryID = cboCategoryAdd.Value

                If cboAccountAdd.Text <> "" Then intAccountID = cboAccountAdd.Value

                'txtNetQuantityAdd.Value = (NetQty)
                'txtAmountAdd.Value = (amount)


                If objConnect.State = ConnectionState.Closed Then
                    Call ConnectDBase()
                End If

                objCommand = New SqlCommand
                objCommand.Connection = objConnect
                objCommand.CommandText = "usp_Expenditure_Insert"
                objCommand.CommandType = CommandType.StoredProcedure

                With objCommand.Parameters
                    .Add(New SqlParameter("@ExpenditureCode", txtTransactionCode.Text))
                    .Add(New SqlParameter("@ExpenditureDate", VB6.Format(dtpExpenditureDateAdd.Value.Date, "dd-MMM-yyyy")))
                    .Add(New SqlParameter("@SiteID", intSiteID))
                    .Add(New SqlParameter("@CategoryID", intCategoryID))
                    .Add(New SqlParameter("@AccountID", intAccountID))
                    .Add(New SqlParameter("@TransactionNumber", txtTransactionNumberAdd.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@Details", txtTransactionDetailsAdd.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@ReceiptNo", txtReceiptNumberAdd.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@AuthorisedBy", txtAuthorisedByAdd.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@Amount", txtAmountAdd.Value))
                    .Add(New SqlParameter("@UserID", Session("UserID")))
                End With
                objCommand.ExecuteNonQuery()
                objCommand.Parameters.Clear()


                EmptyRec()
                lblErrMsgAdd.ClientVisible = False
                lblSuccessMsgAdd.ClientVisible = True
                lblSuccessMsgAdd.Text = "Expenditure Successfully Registered"


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

            Dim intSiteID As Integer = 0, intAccountID As Integer = 0, intCategoryID As Integer = 0


            Try

                If cboSiteEdit.Text <> "" Then intSiteID = cboSiteEdit.Value
                If cboAccountEdit.Text <> "" Then intAccountID = cboAccountEdit.Value
                If cboCategoryEdit.Text <> "" Then intCategoryID = cboCategoryEdit.Value

                'txtNetQuantityEdit.Value = (NetQty)
                'txtAmountEdit.Value = (amount)


                If objConnect.State = ConnectionState.Closed Then
                    Call ConnectDBase()
                End If

                objCommand = New SqlCommand
                objCommand.Connection = objConnect
                objCommand.CommandText = "usp_Expenditure_Update"
                objCommand.CommandType = CommandType.StoredProcedure

                With objCommand.Parameters
                    .Add(New SqlParameter("@ExpenditureID", CLng(Val(txtExpenditureIDEdit.Text))))
                    .Add(New SqlParameter("@ExpenditureDate", VB6.Format(dtpExpenditureDateEdit.Value.Date, "dd-MMM-yyyy")))
                    .Add(New SqlParameter("@SiteID", intSiteID))
                    .Add(New SqlParameter("@AccountID", intAccountID))
                    .Add(New SqlParameter("@CategoryID", intCategoryID))
                    .Add(New SqlParameter("@Details", txtTransactionDetailsEdit.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@TransactionNumber", txtTransactionNumberEdit.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@ReceiptNo", txtReceiptNumberEdit.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@AuthorisedBy", txtAuthorisedByEdit.Text.Trim.ToUpper))
                    .Add(New SqlParameter("@Amount", txtAmountEdit.Value))
                    .Add(New SqlParameter("@UserID", Session("UserID")))
                End With
                objCommand.ExecuteNonQuery()
                objCommand.Parameters.Clear()


                EmptyEdit()
                EmptyView()
                SqlDataSourceExpenditure.DataBind()
                GridViewExpenditure.DataBind()
                popupEditExpenditure.ShowOnPageLoad = False
                popupViewExpenditure.ShowOnPageLoad = False

            Catch ex As Exception
                lblErrMsgEdit.ClientVisible = False
                lblErrMsgEdit.ClientVisible = True
                lblErrMsgEdit.Text = (ex.Message)
            End Try

        End Sub

        Protected Sub cmdViewExpenditure_Click()
            Call CheckUserSession()

            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.Text = ""
            lblSuccessMsgView.Text = ""
            intExpenditureID = 0
            Dim intExpenditureIDTypeID = 0
            If GridViewExpenditure.VisibleRowCount = 0 Then Exit Sub

            With GridViewExpenditure
                Dim rowIndex As Integer = .FocusedRowIndex

                intExpenditureID = CLng(.GetRowValues(rowIndex, "ExpenditureID").ToString)
            End With
            If intExpenditureID = 0 Then Exit Sub

            Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Expenditure WHERE ExpenditureID='{0}'", intExpenditureID)).Tables(0)

            If dt.Rows.Count > 0 Then

                EmptyView()
                With dt.Rows(0)
                    txtExpenditureIDView.Text = .Item("ExpenditureID").ToString
                    txtSiteNameView.Text = .Item("SiteName").ToString
                    txtExpenditureDateView.Text = VB6.Format(.Item("ExpenditureDate").ToString, "dd-MMM-yyyy")
                    txtAccountView.Text = .Item("AccountCode").ToString
                    txtCategoryView.Text = .Item("CategoryDescription").ToString
                    txtTransactionNumberView.Text = .Item("TransactionNumber").ToString
                    txtReceiptNumberView.Text = .Item("ReceiptNo").ToString
                    txtTransactionDetailsView.Text = .Item("Details").ToString
                    txtAuthorisedByView.Text = .Item("AuthorisedBy").ToString
                    txtAmountView.Value = .Item("Amount").ToString

                End With

                popupViewExpenditure.ShowOnPageLoad = True
            End If



        End Sub


        Private Sub cmdSearcByDate_Click(sender As Object, e As EventArgs) Handles cmdSearcByDate.Click
            Call CheckUserSession()
            SqlDataSourceExpenditure.DataBind()
            GridViewExpenditure.DataBind()
        End Sub


        Private Sub cboSiteEdit_ValueChanged(sender As Object, e As EventArgs) Handles cboSiteEdit.ValueChanged
            Call CheckUserSession()
            SqlDataSourceAccountEdit.DataBind()
            cboSiteEdit.DataBind()
            cboAccountEdit.SelectedIndex = -1
            'EmptyEdit1()
        End Sub

        Protected Sub cmdConfirmDeleteYes_Click(sender As Object, e As EventArgs) Handles cmdConfirmDeleteYes.Click
            On Error Resume Next
            Call CheckUserSession()
            Dim intExpenditureID = 0
            intExpenditureID = 0
            intExpenditureID = CInt(Val(txtExpenditureIDView.Text))
            If intExpenditureID = 0 Then Exit Sub
            'Dim str As String = String.Format("SELECT [dbo].[ufn_Expenditure_CheckForExitingAccountLaterDate]({0})  AS RecCount", intExpenditureID)
            'dtTemp = LoadData(str).Tables(0)

            'If dtTemp.Rows(0).Item(0) > 0 Then PopupErrMsg.ShowOnPageLoad = True : lblErrMsgGen.Text = ("Expenditure Can not Deleted When There are Expenditure in a later date for Account") : Exit Sub

            Dim strQuery As String = String.Format("DELETE FROM Expenditure  WHERE ExpenditureID={0}", intExpenditureID)
            ExecuteMyQuery(strQuery)

            EmptyRec()
            EmptyView()
            popupEditExpenditure.ShowOnPageLoad = False

        End Sub


        Private Sub cmdEdit_Click(sender As Object, e As EventArgs) Handles cmdEdit.Click
            Call CheckUserSession()
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.Text = ""
            lblSuccessMsgView.Text = ""
            intExpenditureID = 0
            Dim intExpenditureIDTypeID = 0
            If txtExpenditureIDView.Text = 0 Then Exit Sub


            intExpenditureID = CLng(Val(txtExpenditureIDView.Text))
            If intExpenditureID = 0 Then Exit Sub

            Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Expenditure WHERE ExpenditureID='{0}'", intExpenditureID)).Tables(0)

            If dt.Rows.Count > 0 Then
                If dt.Rows(0).Item("StatusID").ToString = 3 Then lblErrMsgView.Text = "Please the Expenditure has beem expended" : lblErrMsgView.ClientVisible = True : Exit Sub
                EmptyEdit()
                With dt.Rows(0)
                    txtExpenditureIDEdit.Text = .Item("ExpenditureID").ToString
                    cboSiteEdit.Value = CInt(.Item("SiteID").ToString)
                    dtpExpenditureDateEdit.Value = CDate(VB6.Format(.Item("ExpenditureDate").ToString, "dd-MMM-yyyy"))
                    cboAccountEdit.Value = CInt(.Item("AccountID").ToString)
                    cboCategoryEdit.Value = CInt(.Item("CategoryID").ToString)
                    txtTransactionNumberEdit.Text = .Item("TransactionNumber").ToString
                    txtReceiptNumberEdit.Text = .Item("ReceiptNo").ToString
                    txtTransactionDetailsEdit.Text = .Item("Details").ToString
                    txtAuthorisedByEdit.Text = .Item("AuthorisedBy").ToString
                    txtAmountEdit.Value = .Item("Amount").ToString

                End With

                popupEditExpenditure.ShowOnPageLoad = True
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

        Private Sub cmdViewExpenditureReport_Click(sender As Object, e As EventArgs) Handles cmdViewExpenditureReport.Click
            On Error Resume Next
            Call CheckUserSession()
            'Session("PaymentCode") = txtPaymentCode.Text.Trim.ToUpper

            'Response.Redirect("~/paymentreceipt1.aspx")
            'If CLng(Session("PaymentID")) = 0 Then Exit Sub
            Dim printFlag As Boolean = Nothing
            Dim stream = New MemoryStream()
            Dim report As New XtraRptExpenditure
            Dim intSiteID = 0
            If cboSiteSearch.Text <> "" Then intSiteID = cboSiteSearch.Value

            Dim dt As DataTable = LoadData(String.Format("EXEC Usp_Expenditure_RPTByDateBySiteID @DateFrom='{0}',@DateTo='{1}', @SiteID={2}", txtSearchDateFrom.Text, txtSearchDateTo.Text, intSiteID)).Tables(0)
            report.DataSource = dt
            'report.XrPictureBox1.ImageUrl = "~/pilgrimpicture/" & Session("ApplicantID").ToString & ".jpg"
            report.XrPictureBox1.ImageUrl = "~/img/logo.jpg"

            Using ms As New MemoryStream()
                report.ExportToPdf(ms, New PdfExportOptions() With {.ShowPrintDialogOnOpen = True})
                WriteDocumentToResponse(ms.ToArray(), "pdf", True, "Expenditure.pdf")
            End Using


        End Sub

        Private Sub GridViewExpenditure_CustomButtonCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonCallbackEventArgs) Handles GridViewExpenditure.CustomButtonCallback
            Call CheckUserSession()

            lblErrMsgView.ClientVisible = False
            lblErrMsgView.ClientVisible = False
            lblErrMsgView.Text = ""
            lblSuccessMsgView.Text = ""
            intExpenditureID = 0
            Dim intExpenditureIDTypeID = 0
            If GridViewExpenditure.VisibleRowCount = 0 Then Exit Sub

            With GridViewExpenditure
                Dim rowIndex As Integer = .FocusedRowIndex

                intExpenditureID = CLng(.GetRowValues(rowIndex, "ExpenditureID").ToString)
            End With
            If intExpenditureID = 0 Then Exit Sub

            Dim dt As DataTable = LoadData(String.Format("SELECT * FROM View_Expenditure WHERE ExpenditureID='{0}'", intExpenditureID)).Tables(0)

            If dt.Rows.Count > 0 Then

                EmptyView()
                With dt.Rows(0)
                    txtExpenditureIDView.Text = .Item("ExpenditureID").ToString
                    txtSiteNameView.Text = .Item("SiteName").ToString
                    txtExpenditureDateView.Text = VB6.Format(.Item("ExpenditureDate").ToString, "dd-MMM-yyyy")
                    txtAccountView.Text = .Item("AccountCode").ToString
                    txtCategoryView.Text = .Item("CategoryDescription").ToString
                    txtTransactionNumberView.Text = .Item("TransactionNumber").ToString
                    txtReceiptNumberView.Text = .Item("ReceiptNo").ToString
                    txtTransactionDetailsView.Text = .Item("Details").ToString
                    txtAuthorisedByView.Text = .Item("AuthorisedBy").ToString
                    txtAmountView.Value = .Item("Amount").ToString

                End With

                popupViewExpenditure.ShowOnPageLoad = True
            End If

        End Sub

    End Class
    