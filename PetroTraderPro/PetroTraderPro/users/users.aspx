<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="users.aspx.vb" Inherits="PetroTraderPro.users" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>
    <script src="../Content/myjs/jquery-3.6.0.js"></script>
    <script type="text/javascript">
        function getCustomButtonClick(s, e) {
            page_toolbar_item_clicked(e.buttonID);
        };
        function page_toolbar_item_clicked(itm) {
            if (itm == "New") {
                get_new_form();
            };
        };

        function get_new_form() {
            popupAdd.Show();
        };


        function EmptyAdd() {
            txtFirstNameAdd.SetText("");
            txtOtherNamesAdd.SetText("");
            cboGenderAdd.SetSelectedIndex(-1);
            txtUserNameAdd.SetText("");
            cboUserGroupAdd.SetSelectedIndex(-1);
            txtPhoneNumberAdd.SetText("");
            txtPasswordAdd.SetText("");
            txtConfirmPasswordAdd.SetText("");
            picPictureAdd.SetImageUrl("");
            picPictureAdd.SetHeight(150);
            picPictureAdd.SetWidth(150);

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

        function LoadPicture(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#<%=picPictureAdd.ClientID%>').prop('src', e.target.result)
                        .Width(150)
                        .Height(150)
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function OnSaveAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAdd.Show();
            }
        };
        function LoadChangeGroup() {
            popupChangeGroup.Show();
            //lblChangeGroupCurrent.SetText("");
            //lblChangeGroupCurrentID.SetText(-1);

            //lblChangeGroupCurrent.SetText(lblUserGroupView.GetText());
            //lblChangeGroupCurrentID.SetText(lblUserGroupIDView.GetText());

        }
        function OnSaveChangeGroup(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveChangeGroup.Show();
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">USERS</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New User" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-user-20.png" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">

    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewUsers" DataSourceID="SqlDataSourceUsers" Width="100%" KeyFieldName="UserID">
                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                            </SettingsAdaptivity>
                            <SettingsPager PageSize="50">
                            </SettingsPager>
                            <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="450" />
                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" AllowGroup="False" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                            <SettingsPopup>
                                <HeaderFilter MinHeight="140px">
                                </HeaderFilter>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>
                            <SettingsSearchPanel Visible="True" />

                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="UserID" VisibleIndex="0" Caption=" " Width="30px">
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="cmdView" runat="server" OnClick="cmdView_Click" BackColor="#3366cc"
                                            Text="View" Width="100px" Image-Url="~/img/view-20.png" Image-Height="16px">
                                        </dx:ASPxButton>
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataImageColumn FieldName="UserID" VisibleIndex="1" Caption="  " Width="30px">
                                    <PropertiesImage ImageUrlFormatString="/users/userpics/{0}.jpg" ImageHeight="50px" ImageWidth="50px">
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                                <dx:GridViewDataTextColumn FieldName="UserGroup" VisibleIndex="40" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UserID" VisibleIndex="43" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TransactionCode" VisibleIndex="44" Visible="False" Width="50px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="46" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="LastName" VisibleIndex="47" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="FullName" VisibleIndex="38" ReadOnly="True" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Status_Name" VisibleIndex="42" Width="30px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PhoneNumber" VisibleIndex="41" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UserGroupID" VisibleIndex="48" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PhotoUrl" ReadOnly="True" VisibleIndex="50" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                            </Columns>

                            <Styles>
                                <HeaderPanel Font-Bold="True">
                                </HeaderPanel>
                            </Styles>
                        </dx:ASPxGridView>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New User"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <ClientSideEvents PopUp="function(s, e) {EmptyAdd();}"></ClientSideEvents>

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="First Name" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtFirstNameAdd" ClientInstanceName="txtFirstNameAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Other Names" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" Width="100%" ClientInstanceName="txtOtherNamesAdd" ID="txtOtherNamesAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Phone Number" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" Width="100%" ClientInstanceName="txtPhoneNumberAdd" ID="txtPhoneNumberAdd">
                                        <MaskSettings Mask="0000000000"></MaskSettings>

                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="User Group" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceUserGroups" TextField="UserGroup" ValueField="UserGroupID" ClientInstanceName="cboUserGroupAdd" ID="cboUserGroupAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Password" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtPasswordAdd" runat="server" ClientInstanceName="txtPasswordAdd" Password="True">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
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
                                    <dx:ASPxTextBox runat="server" Password="True" ClientInstanceName="txtConfirmPasswordAdd" ID="txtConfirmPasswordAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutGroup Caption="Picture Upload" ColSpan="2" ColumnSpan="2">
                            <GroupBoxStyle>
                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68">
                                </Caption>
                            </GroupBoxStyle>
                            <Items>
                                <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td class="auto-style1">
                                                        <dx:ASPxImage ID="picPictureAdd" runat="server" ClientInstanceName="picPictureAdd" ShowLoadingImage="true" Height="150px" Width="150px" BorderTop-BorderStyle="NotSet" Border-BorderStyle="Solid" Border-BorderWidth="2">
                                                            <Border BorderStyle="Solid" BorderWidth="2px"></Border>
                                                        </dx:ASPxImage>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style1">
                                                        <asp:FileUpload ID="FileUploadPictureAdd" runat="server" accept=".jpg, .jpeg, .png, .gif" onchange="LoadPicture(this);" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </table>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxGridView ID="GridViewUserSitesAdd" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewUserSitesAdd" DataSourceID="SqlDataSourceSites" EnableTheming="True" KeyFieldName="SiteID" Width="350px">
                                        <SettingsPager Mode="ShowAllRecords">
                                        </SettingsPager>
                                        <Settings VerticalScrollableHeight="150" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowSelectByRowClick="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <SettingsPopup>
                                            <FilterControl AutoUpdatePosition="False">
                                            </FilterControl>
                                        </SettingsPopup>
                                        <Columns>
                                            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" Width="10px">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Site" FieldName="SiteName" ShowInCustomizationForm="True" VisibleIndex="2" Width="30px">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px" ID="cmdSubmitAdd">
                                                    <ClientSideEvents Click="function(s,e){ OnSaveAdd(s,e);}"></ClientSideEvents>

                                                </dx:ASPxButton>

                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshAdd">
                                                </dx:ASPxButton>

                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveAdd">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout6">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Add" Width="120px" ID="cmdSaveYesAdd">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}"></ClientSideEvents>
                                                                    </dx:ASPxButton>

                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoAdd">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}"></ClientSideEvents>
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
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgAdd" ClientInstanceName="lblErrMsgAdd" runat="server" Font-Bold="true" ForeColor="Red" Text="" ClientVisible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgAdd" ClientInstanceName="lblSuccessMsgAdd" runat="server" Font-Bold="true" ForeColor="Blue" Text="" ClientVisible="false"></dx:ASPxLabel>

                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False" ID="txtTransactionCode"></dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxPopupControl ID="popupView" runat="server" AllowDragging="True" ClientInstanceName="popupView" CloseAction="CloseButton" HeaderText="User Details"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="850px" Modal="true">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" ColCount="4" ColumnCount="4" Style="text-align: center">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutGroup ColCount="4" ColumnCount="4" ColSpan="4" ColumnSpan="4" ShowCaption="False">
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" Text="Reset Password" Width="100%" ID="cmdResetPassword"></dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" Text="Change User Group" AutoPostBack="false" Width="100%" ID="cmdChangeGroup">
                                                <ClientSideEvents Click="function(s, e) {LoadChangeGroup();}"></ClientSideEvents>
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" Text="Change User Site" Width="100%" ID="cmdChangeSite" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) {popupAssignSite.Show();}"></ClientSideEvents>
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" Text="Block User" Width="100%" AutoPostBack="false" ID="cmdBlockUser">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmBlockUser.Show();}"></ClientSideEvents>
                                            </dx:ASPxButton>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>


                        <dx:LayoutItem Caption="Full Name" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel runat="server" ID="lblFullNameView" ClientInstanceName="lblFullNameView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="User Group" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblUserGroupView" runat="server" ClientInstanceName="lblUserGroupView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblUserGroupIDView" runat="server" ClientInstanceName="lblUserGroupIDView" ClientVisible="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Phone Number" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblPhoneNumberView" runat="server" ClientInstanceName="lblPhoneNumberView" Height="50px" Width="100%" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Status" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblUserStatusView" runat="server" ClientInstanceName="lblUserStatusView" Height="50px" Width="100%" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutGroup Caption="" ColSpan="2" ColumnSpan="2">
                            <GroupBoxStyle>
                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68">
                                </Caption>
                            </GroupBoxStyle>
                            <Items>
                                <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxImage ID="picPictureView" runat="server" ClientInstanceName="picPictureView" ShowLoadingImage="true" Height="150px" Width="150px" BorderTop-BorderStyle="NotSet" Border-BorderStyle="Solid" Border-BorderWidth="2"></dx:ASPxImage>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxGridView ID="GridViewUserSitesView" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewUserSitesView" DataSourceID="SqlDataSourceUserSite" EnableTheming="True" KeyFieldName="SiteID" Width="350px">
                                        <SettingsPager Mode="ShowAllRecords">
                                        </SettingsPager>
                                        <Settings VerticalScrollableHeight="150" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowSelectByRowClick="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <SettingsPopup>
                                            <FilterControl AutoUpdatePosition="False">
                                            </FilterControl>
                                        </SettingsPopup>
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Site" FieldName="SiteName" ShowInCustomizationForm="True" VisibleIndex="2" Width="30px">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <Styles>
                                            <SelectedRow>
                                                <BackgroundImage Repeat="NoRepeat" />
                                            </SelectedRow>
                                            <Footer Font-Bold="True" Font-Size="Larger" ForeColor="#0D6B68">
                                            </Footer>
                                        </Styles>
                                    </dx:ASPxGridView>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="4" ShowCaption="False" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <asp:SqlDataSource ID="SqlDataSourceUserSite" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteCode], [SiteName], [UserID] FROM [View_UserSites] WHERE ([UserID] = @UserID) ORDER BY [SiteName]">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblUserIDView" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                        <SelectParameters>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <dx:ASPxLabel ID="lblErrMsgView" ClientInstanceName="lblErrMsgView" runat="server" Font-Bold="true" ForeColor="Red" Text="" ClientVisible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgView" ClientInstanceName="lblSuccessMsgView" runat="server" Font-Bold="true" ForeColor="Blue" Text="" ClientVisible="false"></dx:ASPxLabel>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="popupChangeGroup" runat="server" AllowDragging="True" ClientInstanceName="popupChangeGroup" CloseAction="CloseButton" HeaderText="User Details" PopupElementID="cmdChangeGroupNew" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="600px" Modal="true">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" ColCount="4" ColumnCount="4" Style="text-align: center">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>

                        <dx:LayoutItem ColSpan="2" Caption="Current Group" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblChangeGroupCurrent" runat="server" ClientInstanceName="lblChangeGroupCurrent" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblChangeGroupCurrentID" runat="server" ClientInstanceName="lblChangeGroupCurrentID" ClientVisible="False" Font-Bold="True" ForeColor="#0D6B68">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="New Group" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceUserGroups" TextField="UserGroup" ValueField="UserGroupID" ClientInstanceName="cboUserGroupChangeGroup" ID="cboUserGroupChangeGroup">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="ChangeGroup">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="ChangeGroup" Width="120px" ID="cmdSubmitChangeGroup">
                                                    <ClientSideEvents Click="function(s,e){ OnSaveChangeGroup(s,e);}"></ClientSideEvents>

                                                </dx:ASPxButton>

                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshChangeGroup">
                                                </dx:ASPxButton>

                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveChangeGroup" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveChangeGroup">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout4">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="ChangeGroup" Width="120px" ID="cmdSaveYesChangeGroup">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveChangeGroup.Hide();}"></ClientSideEvents>
                                                                    </dx:ASPxButton>

                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoChangeGroup">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveChangeGroup.Hide();}"></ClientSideEvents>
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
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgChangeGroup" ClientInstanceName="lblErrMsgChangeGroup" runat="server" Font-Bold="true" ForeColor="Red" Text="" ClientVisible="false"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgChangeGroup" ClientInstanceName="lblSuccessMsgChangeGroup" runat="server" Font-Bold="true" ForeColor="Blue" Text="" ClientVisible="false"></dx:ASPxLabel>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxPopupControl ID="popupAssignSite" runat="server" AllowDragging="True" ClientInstanceName="popupAssignSite" CloseAction="CloseButton" HeaderText="Assign Site" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px" Modal="True">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout8" runat="server" Width="100%" ColCount="6" ColumnCount="6">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>

                        <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Unassigned">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxGridView ID="GridViewUnassigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewUnassigned" Width="100%" KeyFieldName="SiteID" Theme="Aqua" DataSourceID="SqlDataSourceUnassignedSite">
                                        <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                        </SettingsAdaptivity>
                                        <SettingsPager Mode="ShowAllRecords">
                                        </SettingsPager>
                                        <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Caption=" " Width="40px">
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="cmdView" runat="server" Theme="Aqua" OnClick="cmdAssignSite_Click" Height="10px"
                                                        Text="Add" Width="100%" Image-Height="16px" Image-Url="~/img/add-100.png">
                                                    </dx:ASPxButton>
                                                </DataItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="80px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="4" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        </Columns>


                                    </dx:ASPxGridView>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top"></CaptionSettings>
                            <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Assigned">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxGridView ID="GridViewAssigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAssigned" Width="100%" Theme="Aqua" DataSourceID="SqlDataSourceAssignedSite" KeyFieldName="SiteID">
                                        <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                        </SettingsAdaptivity>
                                        <SettingsPager Mode="ShowAllRecords">
                                        </SettingsPager>
                                        <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" />
                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Caption=" " Width="40px">
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="cmdRemove" runat="server" Theme="Aqua" OnClick="cmdUnAssignSite_Click" Height="10px"
                                                        Text="Remove" Width="100%" Image-Height="16px" Image-Url="~/img/Delete.png">
                                                    </dx:ASPxButton>
                                                </DataItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="80px"></dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                            <%--                                                    <dx:GridViewDataTextColumn FieldName="UserID" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>--%>
                                        </Columns>


                                    </dx:ASPxGridView>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top"></CaptionSettings>
                            <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="6" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <asp:Label ID="lblErrMsgAssign" runat="server" ForeColor="Red" Visible="False" CssClass="dxe-day-has-appointments"></asp:Label>
                                    <asp:Label ID="lblSuccessMsgAssign" runat="server" Font-Bold="True" ForeColor="Blue" Visible="False"></asp:Label>
                                    <dx:ASPxTextBox runat="server" ID="txtItemID" ClientInstanceName="txtItemID" ClientVisible="false"></dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmBlockUser" HeaderText="Confirm Block User?" ShowCloseButton="False" Width="300px" ID="PopupConfirmBlockUser">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout9">
                    <Items>
                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="BlockUser" Width="120px" ID="cmdConfirmBlockUserYes">
                                        <ClientSideEvents Click="function(s, e) {PopupConfirmBlockUser.Hide();}"></ClientSideEvents>
                                    </dx:ASPxButton>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdConfirmBlockUserNo">
                                        <ClientSideEvents Click="function(s, e) {PopupConfirmBlockUser.Hide();}"></ClientSideEvents>
                                    </dx:ASPxButton>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_Users_GetByUserGroupIDByUserID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="-1" Name="UserID"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceUserGroups" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM UserGroups WHERE UserGroupID>0 ORDER BY UserGroup"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID,SiteCode, SiteName FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceUnassignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM   Sites WHERE SiteID NOT IN (SELECT SiteID FROM View_UserSites WHERE UserID =@UserID) AND SiteID>0 ORDER BY [SiteName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblUserIDView" PropertyName="Text" DefaultValue="-1" Name="UserID"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceAssignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM [View_UserSites] WHERE ([UserID] = @UserID) ORDER BY [SiteName]">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblUserIDView" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxLabel runat="server" AutoPostBack="false" ClientInstanceName="lblUserIDView" ClientVisible="False" ID="lblUserIDView" Text="-1"></dx:ASPxLabel>

</asp:Content>

