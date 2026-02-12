<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="userProfile.aspx.vb" Inherits="PetroTraderPro.userProfile" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>
    <script src="../Content/myjs/jquery-3.6.0.js"></script>
    <script type="text/javascript">

        function EmptyPassword() {
            txtOldPassword.SetText("");
            txtPassword.SetText("");
            txtConfirmPassword.SetText("");

            lblErrMsgPassword.SetVisible(false)
            lblSuccessMsgPassword.SetVisible(false)
            lblErrMsgPassword.SetText("");
            lblSuccessMsgPassword.SetText("");

        };
        function EmptyPassword1() {
            txtOldPassword.SetText("");
            txtPassword.SetText("");
            txtConfirmPassword.SetText("");
            //cboUserGroupAdd.SetSelectedIndex(-1);
            //txtPhoneNumberAdd.SetText("");
            //txtPasswordAdd.SetText("");
            //txtConfirmPasswordAdd.SetText("");
            //picPictureAdd.SetImageUrl("");
            //picPictureAdd.SetHeight(150);
            //picPictureAdd.SetWidth(150);

            //lblErrMsgAdd.SetVisible(false)
            //lblSuccessMsgAdd.SetVisible(false)
            //lblErrMsgAdd.SetText("");
            //lblSuccessMsgAdd.SetText("");

            GenerateTransCode();
        };

        function get_del_focused_row() {
            GridViewUsers.GetRowValues(GridViewUsers.GetFocusedRowIndex(), 'ItemID;ItemName', on_get_delete_row);
        };

        function on_get_delete_row(values) {

            txtItemIDDelete.SetValue(values[0]);
            lblItemDelete.SetText(values[1]);

            PopupConfirmDelete.Show();
        };

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };

        function SetTarget() {
            document.forms[0].target = "_blank";
        }

<%--        function LoadPicture(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#<%=picPictureAdd.ClientID%>').prop('src', e.target.result)
                        .Width(150)
                        .Height(150)
                };
                reader.readAsDataURL(input.files[0]);
            }
        }--%>

        function OnSavePassword(s, e) {
            lblErrMsgPassword.SetVisible(false);
            lblErrMsgPassword.SetText("");
            lblSuccessMsgPassword.SetVisible(false);
            lblSuccessMsgPassword.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                var varOld1 = lblOldPasswordView.SetText();
                var varOld2 = txtOldPassword.SetText();
                if (varOld1 != varOld2) { lblErrMsgPassword.SetVisible(true); lblErrMsgPassword.SetText('Please The Current is not correct '); txtOldPassword.Focus(); return; };
                PopupConfirmSavePassword.Show();
            }
        };

    </script>

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <dx:ASPxMenu runat="server" ID="MainMenu" ClientInstanceName="actionToolbar"
        ItemAutoWidth="false" ApplyItemStyleToTemplates="true" ItemWrap="false"
        AllowSelectItem="false" SeparatorWidth="0"
        Width="100%" CssClass="page-toolbar" Font-Bold="True" Font-Size="Larger">
        <ClientSideEvents ItemClick="function(s, e) {page_toolbar_item_clicked(e.item.name);}" />
        <SettingsAdaptivity Enabled="true" EnableAutoHideRootItems="true"
            EnableCollapseRootItemsToIcons="true" CollapseRootItemsToIconsAtWindowInnerWidth="600" />
        <ItemStyle CssClass="item" VerticalAlign="Middle" />
        <ItemImage Width="16px" Height="16px" />
        <Items>
            <dx:MenuItem Enabled="false">
                <Template>
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">User Profile</h1>
                </Template>
            </dx:MenuItem>
            <%--            <dx:MenuItem Name="New" Text="New User" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-user-20.png" />
            </dx:MenuItem>--%>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" Style="text-align: center">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                </SettingsAdaptivity>

                <Items>
                    <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="1" ShowCaption="False">
                        <Items>
                            <dx:LayoutGroup ColCount="4" ColumnCount="4" ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                <Items>
                                    <dx:EmptyLayoutItem ColSpan="1" HorizontalAlign="Center"></dx:EmptyLayoutItem>
                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Right">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxButton runat="server" AutoPostBack="false" Text="Change Password" Width="100%" ID="cmdChangeGroup">
                                                    <ClientSideEvents Click="function(s, e) {popupchangePassword.Show();}"></ClientSideEvents>
                                                </dx:ASPxButton>

                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>

                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Left">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxButton runat="server" Text="Change Picture" Width="100%" ID="cmdBlockUser">
                                                    <ClientSideEvents Click="function(s, e) {popupChangePicture.Show();}"></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>

                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem ColSpan="1" HorizontalAlign="Center"></dx:EmptyLayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutItem ColumnSpan="2" ColSpan="2" HorizontalAlign="Center" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxImage runat="server" ShowLoadingImage="True" Width="150px" Height="150px" ClientInstanceName="picPictureView" ID="picPictureView">
                                            <Border BorderStyle="Solid" BorderWidth="2px"></Border>
                                        </dx:ASPxImage>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutGroup Caption="User Information" ColCount="2" ColSpan="1" ColumnCount="2">
                                <GroupBoxStyle>
                                    <Caption Font-Bold="True" ForeColor="#0D6B68">
                                    </Caption>
                                </GroupBoxStyle>
                                <Items>
                                    <dx:LayoutItem Caption="Full Name" ColSpan="2" ColumnSpan="2">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxLabel ID="lblFullNameView" runat="server" ClientInstanceName="lblFirstNameView" Font-Bold="True" ForeColor="#0D6B68">
                                                </dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxLabel ID="lblPhoneNumberView" runat="server" ClientEnabled="False" ClientInstanceName="lblPhoneNumberView" Font-Bold="True" ForeColor="#0D6B68" Width="100%">
                                                </dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="User Group" ColSpan="2" ColumnSpan="2">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxLabel ID="lblUserGroupView" runat="server" ClientEnabled="False" ClientInstanceName="lblUserGroupView" Font-Bold="True" ForeColor="#0D6B68">
                                                </dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="User Status" ColSpan="2" ColumnSpan="2">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxLabel ID="lblUserStatusView" runat="server" ClientEnabled="False" ClientInstanceName="lblOtherNamesView" Font-Bold="True" ForeColor="#0D6B68">
                                                </dx:ASPxLabel>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutGroup Caption="User Site" ColSpan="1">
                                <GroupBoxStyle>
                                    <Caption Font-Bold="True" ForeColor="#0D6B68">
                                    </Caption>
                                </GroupBoxStyle>
                                <Items>
                                    <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxGridView ID="GridViewUserSitesView" ClientInstanceName="GridViewUserSitesView" runat="server" DataSourceID="SqlDataSourceUserSite" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Visible="False"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Caption="Site"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="UserID" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutItem ColSpan="2" ShowCaption="False" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <dx:ASPxLabel runat="server" AutoPostBack="false" ClientInstanceName="lblUserIDView" ClientVisible="False" ID="lblUserIDView" Text="-1"></dx:ASPxLabel>
                                        <asp:SqlDataSource ID="SqlDataSourceUserSite" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteCode], [SiteName], [UserID] FROM [View_UserSites] WHERE ([UserID] = @UserID) ORDER BY [SiteName]">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblUserIDView" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>
                                            </SelectParameters>
                                            <SelectParameters>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <dx:ASPxLabel ID="lblOldPasswordView" runat="server" ClientVisible="false" ClientEnabled="False" ClientInstanceName="lblOldPasswordView" Font-Bold="True" ForeColor="#0D6B68">
                                        </dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>

                </Items>
            </dx:ASPxFormLayout>

            <dx:ASPxPopupControl ID="popupchangePassword" runat="server" AllowDragging="True" ClientInstanceName="popupchangePassword" CloseAction="CloseButton" HeaderText="Change Password" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="600px" Modal="true">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

<%--                <ClientSideEvents PopUp="function(s, e) {EmptyPassword();}"></ClientSideEvents>--%>

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Current Password" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtOldPassword" ClientInstanceName="txtOldPassword" Password="True">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Password">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="New Password" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtPassword" ID="txtPassword" Password="True">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Password">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="2" Caption="Confirm Password" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Password="True" ClientInstanceName="txtConfirmPassword" ID="txtConfirmPassword">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Password">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Password" Width="120px" ID="cmdSubmitPassword">
                                                            <ClientSideEvents Click="function(s,e){ OnSavePassword(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>


                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshPassword">
                                                            <ClientSideEvents Click="function(s, e) {EmptyPassword();}"></ClientSideEvents>
                                                        </dx:ASPxButton>


                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSavePassword" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSavePassword">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout6">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Password" Width="120px" ID="cmdSaveYesPassword">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePassword.Hide();}"></ClientSideEvents>
                                                                            </dx:ASPxButton>


                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoPassword">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePassword.Hide();}"></ClientSideEvents>
                                                                            </dx:ASPxButton>

                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:ASPxFormLayout>


                                                    </dx:PopupControlContentControl>
                                                </ContentCollection>
                                            </dx:ASPxPopupControl>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblErrMsgPassword" ClientVisible="False" Font-Bold="True" ForeColor="Red" ID="lblErrMsgPassword"></dx:ASPxLabel>

                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblSuccessMsgPassword" ClientVisible="False" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgPassword"></dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True" HeaderText="Change Picture" Width="600px" ID="popupChangePicture" ClientInstanceName="popupChangePicture" Modal="true" CloseAction="CloseButton">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="600"></SettingsAdaptivity>


                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                                <GridSettings WrapCaptionAtWidth="700"></GridSettings>
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup Caption="CURRENT PICTURE" SettingsItemCaptions-Location="Top" ColSpan="2" ColumnSpan="2">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" ForeColor="#003399"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxImage ID="picPictureChangePictureView" runat="server" ShowLoadingImage="true" Width="150px" Height="150px" ClientInstanceName="picPictureChangePictureView">
                                                        <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                                    </dx:ASPxImage>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>

                                <dx:LayoutGroup Caption="NEW PICTURE" SettingsItemCaptions-Location="Top" ColSpan="2" ColumnSpan="2">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" ForeColor="#003399"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <dx:ASPxImage ID="picPictureChangePicture" runat="server" ShowLoadingImage="true" Width="150px" Height="150px" ClientInstanceName="picPictureChangePicture">
                                                                    <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="2px"></Border>
                                                                </dx:ASPxImage>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <asp:FileUpload ID="FileUploadPictureChangePicture" runat="server" onchange="LoadPicture(this);" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>

                                <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Add" Width="120px" ID="cmdSaveChangePicture">
                                                <ClientSideEvents Click="function(s,e){ OnSaveChangePicture(s,e);}"></ClientSideEvents>
                                            </dx:ASPxButton>

                                            <dx:ASPxPopupControl ID="PopupConfirmSaveChangePicture" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveChangePicture" HeaderText="Confirm Save" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="300px" Modal="true">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout5" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesChangePicture" runat="server" Text="Yes" ValidationGroup="ChangePicture" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveChangePicture.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoChangePicture" runat="server" AutoPostBack="False" BackColor="#FF3300" CausesValidation="False" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveChangePicture.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                            </Items>
                                                        </dx:ASPxFormLayout>
                                                    </dx:PopupControlContentControl>
                                                </ContentCollection>
                                            </dx:ASPxPopupControl>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgChangePicture" ClientInstanceName="lblErrMsgChangePicture" runat="server" Text="" Font-Bold="true" ForeColor="Red"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgChangePicture" runat="server" ClientInstanceName="lblSuccessMsgChangePicture" Text="" Font-Bold="true" ForeColor="Blue"></dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:ASPxFormLayout>

                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>





            <asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT *  FROM  View_Users WHERE UserID IN (SELECT UserID FROM UserSites WHERE  SiteID>0 AND SiteID IN(SELECT SiteID FROM UserSites WHERE UserID =@UserID)) AND UserGroupID>0">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="-1" Name="UserID"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID,SiteCode, SiteName FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

