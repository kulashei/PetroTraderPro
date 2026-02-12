Imports System.Data.SqlClient
Imports DevExpress.Web
Imports Microsoft.VisualBasic.Compatibility
Public Class busInfoSetup
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
        STR(0) = "SELECT * FROM BusinessInfo"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        Dim dt = dsMany(0).Tables(0)

        Call EmptyAdd()
        If dt.Rows.Count > 0 Then

            With dt.Rows(0)
                txtCompanyAdd.Text = .Item("CompanyName").ToString
                txtAddressAdd.Text = .Item("CompanyAddress").ToString
                txtBusinessInfoAdd.Text = .Item("BusinessInfo").ToString
            End With
        End If


        ' Edit Business Information
        Session("TempUserRole") = New DataTable
        Session("AllUserRoles").DefaultView.RowFilter = "RoleID=41"
        Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

        Session("RoleID41Add") = Session("TempUserRole").Rows(0).Item("CanAdd")
        Session("RoleID41Edit") = Session("TempUserRole").Rows(0).Item("CanEdit")
        Session("RoleID41Delete") = Session("TempUserRole").Rows(0).Item("CanDelete")
        Session("RoleID41View") = Session("TempUserRole").Rows(0).Item("CanView")

        If Session("RoleID41Add") = False Then cmdSubmitAdd.ClientEnabled = False
        If Session("RoleID41Edit") = False Then cmdSubmitAdd.ClientEnabled = False


    End Sub
    Private Sub EmptyAdd()
        On Error Resume Next
        txtAddressAdd.Text = ""
        txtCompanyAdd.Text = ""
        txtBusinessInfoAdd.Text = ""
        picLogo.ImageUrl = "~/img/logo.jpg"

    End Sub


    Protected Sub cmdSaveYesAdd_Click(sender As Object, e As EventArgs) Handles cmdSaveYesAdd.Click
            Call CheckUserSession()
        lblErrMsgAdd.ClientVisible = False
        lblSuccessMsgAdd.clientVisible = False
            lblErrMsgAdd.Text = ""
            lblSuccessMsgAdd.Text = ""

            Dim intSiteTypeID As Integer = 0, intSiteID As Integer = 0, intBalanceType As Integer = 0


            Try

                If objConnect.State = ConnectionState.Closed Then
                    Call ConnectDBase()
                End If
                objCommand = New SqlCommand
                objCommand.Connection = objConnect
            objCommand.CommandText = "usp_BusinessInfo_InsertOrUpdate"
            objCommand.CommandType = CommandType.StoredProcedure

                With objCommand.Parameters
                .Add(New SqlParameter("@CompanyName", txtCompanyAdd.Text.Trim.ToUpper))
                .Add(New SqlParameter("@CompanyAddress", txtAddressAdd.Text.Trim))
                    .Add(New SqlParameter("@BusinessInfo", txtBusinessInfoAdd.Text.Trim))
                    .Add(New SqlParameter("@UserID", Session("UserID")))
                End With
                objCommand.ExecuteNonQuery()
            objCommand.Parameters.Clear()

            Dim strPicpath As String = "~/img/logo.jpg"

            If FileUploadPicture.HasFile Then
                FileUploadPicture.SaveAs(Server.MapPath(strPicpath))
            End If

            EmptyFields()
                lblErrMsgAdd.ClientVisible = False
                lblSuccessMsgAdd.clientVisible = true
            lblSuccessMsgAdd.Text = "Business Information Successfully Saved"


        Catch ex As Exception
                lblSuccessMsgAdd.clientVisible = False
                lblErrMsgAdd.ClientVisible = True
                lblErrMsgAdd.Text = (ex.Message)
            End Try

        End Sub

    Private Sub cmdRefreshAdd_Click(sender As Object, e As EventArgs) Handles cmdRefreshAdd.Click
        EmptyFields()
    End Sub
End Class