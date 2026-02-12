Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports PetrolTrader.Model
Imports DevExpress.Web
Public Class sales
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Call CheckUserSession()

            'EmptyFields()
        End If

    End Sub

    Private Sub CheckUserSession()
        ''Session("UserID") = 0
        'If IsNothing(Session("UserID")) Then
        '    Session.RemoveAll()
        '    Response.Redirect("~/SignIn.aspx", True)
        'End If
    End Sub

    Private Sub EmptyFields()
        On Error Resume Next
        fLoad = True

        Dim STR(0) As String
        STR(0) = "Exec Usp_GetCurrentDate"

        Dim dsMany() As DataSet = LoadManyDataSets(STR, 0)
        dsCurrentDate = dsMany(0)
        StrCurrentDate = dsCurrentDate.Tables(0).Rows(0).Item("CurrentDate")
        dtpSearchDateFrom.Date = CDate(StrCurrentDate)
        dtpSearchDateTo.Date = CDate(StrCurrentDate)

        dtpSearchDateFrom.MaxDate = CDate(StrCurrentDate)
        dtpSearchDateTo.MaxDate = CDate(StrCurrentDate)

        txtSearchDateFrom.Text = (StrCurrentDate)
        txtSearchDateTo.Text = (StrCurrentDate)
        txtSearchType.Text = 1


        SqlDataSourceSales.DataBind()
        GridViewSales.DataBind()
    End Sub


End Class