Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports PetroTrader.Model
Imports DevExpress.Web

Partial Public Class Root
    Inherits MasterPage
    Private privateEnableBackButton As Boolean
    Public Property EnableBackButton() As Boolean
        Get
            Return privateEnableBackButton
        End Get
        Set(ByVal value As Boolean)
            privateEnableBackButton = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If (Not String.IsNullOrEmpty(Page.Header.Title)) Then
            Page.Header.Title &= " - "
        End If
        Call CheckUserSession()
        Page.Header.Title = Session("BusinessName").ToString & "-" & Page.Header.Title & "Fuel Station MIS"

        Page.Header.DataBind()
        UpdateUserMenuItemsVisible()
        UpdateUserInfo()

        'RightAreaMenu.Items.FindByName("AccountItem").Image.Url = "~/users/userpics/" & Session("UserID") & ".jpg"

        ' Fuel Sales Menu
        If IsNothing(Session("RoleID49ViewMenu")) Then

            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=49"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID49ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID49ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuFuelSales").ClientVisible = False

            'Account Menu
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=50"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID50ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")
            Session("RoleID50View") = Session("TempUserRole").Rows(0).Item("CanView")

            If Session("RoleID50ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuAccount").ClientVisible = False
            If Session("RoleID50View") = False Then ASPxNavBar1.Items.FindByName("smnuAccountReports").ClientVisible = False

            ''Customer Menu

            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=51"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID51ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")
            Session("RoleID51View") = Session("TempUserRole").Rows(0).Item("CanView")

            If Session("RoleID51ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuCustomers").ClientVisible = False
            If Session("RoleID51View") = False Then ASPxNavBar1.Items.FindByName("smnuCustomerReports").ClientVisible = False


            'Supplier Menu

            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=52"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID52ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")
            Session("RoleID52ViewM") = Session("TempUserRole").Rows(0).Item("CanView")

            If Session("RoleID52ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuSuppliers").ClientVisible = False
            If Session("RoleID52View") = False Then ASPxNavBar1.Items.FindByName("smnuSupplierReports").ClientVisible = False

            ''Setup Menu

            Session("TempUserRole") = New DataTable
            Session("AllUserRoles").DefaultView.RowFilter = "RoleID=53"
            Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

            Session("RoleID53ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID53ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuGenSetup").ClientVisible = False

            'User Menu

            Session("TempUserRole") = New DataTable
            Session("AllUserRoles").DefaultView.RowFilter = "RoleID=54"
            Session("TempUserRole") = Session("AllUserRoles").DefaultView.ToTable

            Session("RoleID54ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID52ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuUserSetup").ClientVisible = False

            'Fuel sales
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=2"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID2ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID2ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelSales").ClientVisible = False

            ' Fuel Stock
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=3"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID3ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID3ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelStock").ClientVisible = False

            ' Fuel Receipt
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=4"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID4ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID4ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelReceipt").ClientVisible = False

            ' Fuel Consumption
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=5"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID5ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID5ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelConsumptionk").ClientVisible = False

            ' Fuel E-Payment
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=6"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID6ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID6ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelEpayment").ClientVisible = False

            ' Fuel Coupon Sales
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=7"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID7ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID7ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelCouponSales").ClientVisible = False

            ' Fuel Tranfer
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=8"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID8ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID8ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelTranfer").ClientVisible = False

            'Attendant Shortage
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=47"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID47ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID47ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelAttentShortage").ClientVisible = False

            ' New Customer
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=12"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID12ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID12ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuCustomers").ClientVisible = False

            '  Customer Fuel Supply
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=13"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID13ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID13ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuCustomerFuelCredit").ClientVisible = False

            ' Customer Inventory Supply
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=14"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID14ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID14ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuCustomerInvSupply").ClientVisible = False

            ' Customer Payments
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=15"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID15ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID15ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuCustomerPayment").ClientVisible = False

            ' Debit/Credit Customer Account
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=16"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID16ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID16ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuCustomerDrCr").ClientVisible = False

            ' New Supplier
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=19"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID19ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID19ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSuppliers").ClientVisible = False

            ' Supplier Fuel Receipt
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=20"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID20ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID20ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSupplierFuelRec").ClientVisible = False

            ' Supplier Inventory Receipt
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=21"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID21ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID21ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSupplierInvRec").ClientVisible = False

            ' Supplier Payments
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=22"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID22ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID22ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSupplierPayment").ClientVisible = False

            ' Debit/Credit Supplier Account
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=23"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID23ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID23ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSupplierDrCr").ClientVisible = False

            ' New Account
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=26"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID26ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID26ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountSetup").ClientVisible = False

            ' Account Deposits(Sales)
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=27"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID27ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID27ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountDepostSales").ClientVisible = False

            ' Account Deposits
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=28"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID28ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID28ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountDeposit").ClientVisible = False

            ' Account Tranfers
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=29"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID29ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID29ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountTransfer").ClientVisible = False

            ' Account Debit/Credit
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=30"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID30ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID30ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountDrCr").ClientVisible = False

            ' Expenditure
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=31"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID31ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID31ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuAccountExp").ClientVisible = False


            ' Expenditure Category
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=32"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID32ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID32ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuExpenditureSetup").ClientVisible = False

            'New Site
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=40"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID40ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID40ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuSiteSetup").ClientVisible = False

            'Edit Business Information
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=41"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID41ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID41ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuBusInfoSetup").ClientVisible = False

            'User Setup
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=43"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID43ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID43ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuUser").ClientVisible = False

            'User Group
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=44"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID44ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID44ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuUserGroups").ClientVisible = False

            '
            Session("TempUserRole") = New DataTable
            Session("TempAllUserRoles") = New DataTable
            Session("TempAllUserRoles") = Session("AllUserRoles")
            Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=45"
            Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            Session("RoleID45ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            If Session("RoleID45ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuUser").ClientVisible = False

            If Session("RoleID45ViewMenu") = False And Session("RoleID44ViewMenu") = False Then ASPxNavBar1.Groups.FindByName("mnuUserSetup").ClientVisible = False

            ''
            'Session("TempUserRole") = New DataTable
            'Session("TempAllUserRoles") = New DataTable
            'Session("TempAllUserRoles") = Session("AllUserRoles")
            'Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=2"
            'Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            'Session("RoleID2ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            'If Session("RoleID2ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelSales").ClientVisible = False

            ''
            'Session("TempUserRole") = New DataTable
            'Session("TempAllUserRoles") = New DataTable
            'Session("TempAllUserRoles") = Session("AllUserRoles")
            'Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=2"
            'Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            'Session("RoleID2ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            'If Session("RoleID2ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelSales").ClientVisible = False

            ''
            'Session("TempUserRole") = New DataTable
            'Session("TempAllUserRoles") = New DataTable
            'Session("TempAllUserRoles") = Session("AllUserRoles")
            'Session("TempAllUserRoles").DefaultView.RowFilter = "RoleID=2"
            'Session("TempUserRole") = Session("TempAllUserRoles").DefaultView.ToTable

            'Session("RoleID2ViewMenu") = Session("TempUserRole").Rows(0).Item("CanViewMenu")

            'If Session("RoleID2ViewMenu") = False Then ASPxNavBar1.Items.FindByName("smnuFuelSales").ClientVisible = False

        End If

    End Sub

    Private Sub CheckUserSession()
        ''Session("UserID") = 0
        If IsNothing(Session("UserID")) Then
            Session.RemoveAll()
            Response.Redirect("~/SignIn.aspx", True)
        End If
    End Sub

    Protected Function HasContent(ByVal ContentPlaceHolder As Control) As Boolean
        If ContentPlaceHolder Is Nothing Then
            Return False
        End If

        Dim childControls As ControlCollection = ContentPlaceHolder.Controls
        If childControls.Count = 0 Then
            Return False
        End If

        Return True
    End Function

    ' SignIn/Register

    Protected Sub UpdateUserMenuItemsVisible()
        'Dim isAuthenticated = AuthHelper.IsAuthenticated()
        'RightAreaMenu.Items.FindByName("SignInItem").Visible = Not isAuthenticated
        'RightAreaMenu.Items.FindByName("RegisterItem").Visible = Not isAuthenticated
        'RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated
        'RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated
    End Sub

    Protected Sub UpdateUserInfo()
        'If AuthHelper.IsAuthenticated() Then
        '    Dim user = AuthHelper.GetLoggedInUserInfo()
        '    Dim myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem")
        '    Dim userName = CType(myAccountItem.FindControl("UserNameLabel"), ASPxLabel)
        '    Dim email = CType(myAccountItem.FindControl("EmailLabel"), ASPxLabel)
        '    Dim accountImage = CType(RightAreaMenu.Items(0).FindControl("AccountImage"), HtmlGenericControl)
        '    userName.Text = String.Format("{0} ({1} {2})", user.UserName, user.FirstName, user.LastName)
        '    email.Text = user.Email
        '    accountImage.Attributes("class") = "account-image"

        '    If String.IsNullOrEmpty(user.AvatarUrl) Then
        '        accountImage.InnerHtml = String.Format("{0}{1}", user.FirstName(0), user.LastName(0)).ToUpper()
        '    Else
        '        Dim avatarUrl = CType(myAccountItem.FindControl("AvatarUrl"), HtmlImage)
        '        avatarUrl.Attributes("src") = ResolveUrl(user.AvatarUrl)
        '        accountImage.Style("background-image") = ResolveUrl(user.AvatarUrl)
        '    End If
        'End If
    End Sub

    Protected Sub RightAreaMenu_ItemClick(ByVal source As Object, ByVal e As DevExpress.Web.MenuItemEventArgs)
        If e.Item.Name = "SignOutItem" Then
            'AuthHelper.SignOut() ' DXCOMMENT: Your Signing out logic
            Response.Redirect("~/")
        End If
    End Sub

    Protected Sub ApplicationMenu_ItemDataBound(ByVal source As Object, ByVal e As MenuItemEventArgs)
        e.Item.Image.Url = String.Format("Content/Images/{0}.svg", e.Item.Text)
        e.Item.Image.UrlSelected = String.Format("Content/Images/{0}-white.svg", e.Item.Text)
    End Sub
End Class