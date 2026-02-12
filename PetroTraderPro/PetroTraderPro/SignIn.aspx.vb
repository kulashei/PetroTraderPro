Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web
Imports PetrolTrader.Model
Partial Public Class SignInModule
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session.RemoveAll()
        End If
    End Sub



    Protected Sub SignInButton_Click(ByVal sender As Object, ByVal e As EventArgs) Handles SignInButton.Click
        Session.RemoveAll()
        Try
            lblErrMsg.InnerText = ""
            lblErrMsg.Visible = False

            dsTemp = LoadData(String.Format("EXEC Usp_Users_UserLogin @PhoneNumber='{0}' , @UserPassword='{1}'", txtPhoneNumber.Value.ToString.Trim, Encrypt(txtpassword.Value.ToString.Trim)))
            If dsTemp.Tables(0).Rows.Count <> 0 Then
                With dsTemp.Tables(0).Rows(0)

                    If .Item("UserStatusID") = 1 Then

                        Session("userFullName") = .Item("FullName").ToString
                        Session("userFirstName") = .Item("FirstName").ToString
                        Session("UserGroupID") = .Item("UserGroupID")
                        Session("UserID") = .Item("UserID")

                        Dim cCount As Integer = 1
                        Dim STR(cCount) As String
                        STR(0) = "SELECT * FROM View_UserGroupRole WHERE UserGroupID= " & CInt(Session("UserGroupID"))
                        STR(1) = "SELECT * FROM BusinessInfo"

                        Dim dsMany() As DataSet = LoadManyDataSets(STR, cCount)
                        Session("AllUserRoles") = dsMany(0).Tables(0)
                        If dsMany(1).Tables(0).Rows.Count > 0 Then
                            Session("BusinessName") = dsMany(1).Tables(0).Rows(0).Item("CompanyName")

                        End If

                        Response.Redirect("~/Default.aspx")

                    ElseIf .Item("UserStatusID") = 2 Then
                        lblErrMsg.InnerText = ("User Account is Blocked.")
                        lblErrMsg.Visible = True
                    End If
                End With
            Else
                lblErrMsg.InnerText = ("User Name or Password not Valid")
                lblErrMsg.Visible = True
            End If

        Catch ex As Exception
            lblErrMsg.Visible = True
            lblErrMsg.InnerText = ("An error has occured " & ex.Message.ToString)
        End Try
    End Sub
End Class