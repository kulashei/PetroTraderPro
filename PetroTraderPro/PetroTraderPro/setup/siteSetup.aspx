<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="siteSetup.aspx.vb" Inherits="PetroTraderPro.siteSetup" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">
        function getCustomButtonClick(s, e) {
            page_toolbar_item_clicked(e.buttonID);
        };
        function page_toolbar_item_clicked(itm) {
            if (itm == "New") {
                get_new_form();
            } else if (itm == "Edit") {
                get_edit_focused_row();
            } else if (itm == "Delete") {
                get_del_focused_row();
            } else if (itm == "Print") {
                PopupConfirmPrint.Show();
            };
        };

        function get_new_form() {
            popupAdd.Show();
            EmptyAdd();
        };

        function get_edit_focused_row() {
            GridViewSites.GetRowValues(GridViewSites.GetFocusedRowIndex(), 'SiteID;RegDate;SiteCode;SiteName;Main;CompanyName;CompanyAddress;BusinessInfo', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { Cancel; };
            if (values[0] == null) { Cancel; };
            EmptyEdit;
  
            txtSiteIDEdit.SetValue(values[0]);
            txtSiteCodeEdit.SetText(values[2]);
            dtpRegDateEdit.SetValue(values[1]);
            txtSiteNameEdit.SetText(values[3]);
            txtAddressEdit.SetText(values[6]);
            txtCompanyEdit.SetText(values[5]);
            txtBusinessInfoEdit.SetText(values[7]);


            popupEdit.Show();
        };

        function EmptyAdd() {
            txtSiteCodeAdd.SetText("");
            dtpRegDateAdd.SetText("");
            txtSiteNameAdd.SetText("");
            txtAddressAdd.SetText("");
            txtCompanyAdd.SetText("");
            txtBusinessInfoAdd.SetText("");
        };
        function EmptyEdit() {
            txtSiteCodeEdit.SetText("");
            dtpRegDateEdit.SetText("");
            txtSiteNameEdit.SetText("");
            txtAddressEdit.SetText("");
            txtCompanyEdit.SetText("");
            txtBusinessInfoEdit.SetText("");
        };


        function OnSaveAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAdd.Show();
            }
        };

        function OnSaveEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveEdit.Show();
            }
        };

        function get_del_focused_row() {
            GridViewSites.GetRowValues(GridViewSites.GetFocusedRowIndex(), 'SiteID;SiteName', on_get_delete_row);
        };
        function on_get_delete_row(values) {

            txtSiteIDDelete.SetValue(values[0]);
            lblSiteDelete.SetText(values[1]);

            PopupConfirmDelete.Show();
        };


        function SetTarget() {
            document.forms[0].target = "_blank";
        }

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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Sites</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New Site" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Edit Site" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/edit-20.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Delete" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/Delete.png" Height="20" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
    <dx:ASPxPanel runat="server" ID="FilterPanel" ClientInstanceName="filterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Search" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="onFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewSites" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSites" DataSourceID="SqlDataSourceSites" Width="100%" KeyFieldName="SiteID">
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
                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" ReadOnly="True" Visible="False">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataDateColumn FieldName="RegDate" VisibleIndex="1" Width="50px"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="2" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="3" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn FieldName="Main" Width="50px" Visible="False" VisibleIndex="4"></dx:GridViewDataCheckColumn>

                                <dx:GridViewDataTextColumn FieldName="CompanyName" VisibleIndex="5" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CompanyAddress" VisibleIndex="6" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="BusinessInfo" VisibleIndex="7" Width="100px"></dx:GridViewDataTextColumn>
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

    <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New Site"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Site Code" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtSiteCodeAdd" ClientInstanceName="txtSiteCodeAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>

                                    </dx:ASPxTextBox>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Reg Date" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit runat="server" ClientInstanceName="dtpRegDateAdd" ID="dtpRegDateAdd" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Site Name" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSiteNameAdd" runat="server" ClientInstanceName="txtSiteNameAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" Width="100%" ClientInstanceName="txtAddressAdd" ID="txtAddressAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Company Name" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtCompanyAdd" ID="txtCompanyAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Bus. Info" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" ID="txtBusinessInfoAdd" ClientInstanceName="txtBusinessInfoAdd"></dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Add" Width="120px" ID="cmdSubmitAdd">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveAdd(s,e);}"></ClientSideEvents>
                                                </dx:ASPxButton>

                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshAdd">
                                                    <ClientSideEvents Click="function(s, e) { EmptyAdd();}"></ClientSideEvents>
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
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No"  Width="120px" BackColor="#FF3300" ID="cmdSaveNoAdd">
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
                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>



    <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEdit" CloseAction="CloseButton" HeaderText="Edit New Site"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Site Code" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtSiteCodeEdit" ClientInstanceName="txtSiteCodeEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>

                                    </dx:ASPxTextBox>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Reg Date" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit runat="server" ClientInstanceName="dtpRegDateEdit" ID="dtpRegDateEdit" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxDateEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Site Name" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSiteNameEdit" runat="server" ClientInstanceName="txtSiteNameEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" Width="100%" ClientInstanceName="txtAddressEdit" ID="txtAddressEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Company Name" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtCompanyEdit" ID="txtCompanyEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Bus. Info" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" ID="txtBusinessInfoEdit" ClientInstanceName="txtBusinessInfoEdit"></dx:ASPxMemo>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Edit" Width="120px" ID="cmdSubmitEdit">
                                        <ClientSideEvents Click="function(s,e){ OnSaveEdit(s,e);}"></ClientSideEvents>
                                    </dx:ASPxButton>

                                    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveEdit">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout8">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Edit" Width="120px" ID="cmdSaveYesEdit">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEdit.Hide();}"></ClientSideEvents>
                                                                    </dx:ASPxButton>

                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No"  Width="120px" BackColor="#FF3300" ID="cmdSaveNoEdit">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEdit.Hide();}"></ClientSideEvents>
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
                                    <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
         
                                    <dx:ASPxTextBox runat="server" ID="txtSiteIDEdit" ClientInstanceName="txtSiteIDEdit" ClientVisible="False">

                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>



    <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Are you sure you want DELETE the Site?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" HeaderStyle-ForeColor="#CC3300">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="" ShowCaption="False" HorizontalAlign="Center" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel runat="server" ID="lblSiteDelete" ClientInstanceName="lblSiteDelete" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxLabel>
                                    <dx:ASPxTextBox runat="server" ID="txtSiteIDDelete" ClientInstanceName="txtSiteIDDelete" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="cmdDeleteYes" runat="server" Text="Yes" Width="120px" ValidationGroup="Delete" BackColor="#FF3300">
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="cmdDeleteNo" runat="server" Text="No" Width="120px" ValidationGroup="Delete" AutoPostBack="False" >
                                        <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                    </dx:ASPxButton>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <asp:Label ID="lblErrMsgDelete" runat="server" ForeColor="Red" Visible="False" CssClass="dxe-day-has-appointments"></asp:Label>
                                    <asp:Label ID="lblSuccessMsgDelete" runat="server" Font-Bold="True" ForeColor="Blue" Visible="False"></asp:Label>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>



    <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [Sites] WHERE SiteID>0 ORDER BY [SiteName]"></asp:SqlDataSource>
</asp:Content>

