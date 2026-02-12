<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="supList.aspx.vb" Inherits="PetroTraderPro.supList" %>

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
            GridViewSuppliers.GetRowValues(GridViewSuppliers.GetFocusedRowIndex(), 'SupplierID;SupplierCode;SupplierName;SupplierAddress;PhoneNumber1;PhoneNumber2;EmailAddress;CreditPeriod', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { Cancel; };
            if (values[0] == null) { Cancel; };
            EmptyEdit;
            popupEdit.Show();

            txtSupplierIDEdit.SetValue(values[0]);
            txtSupplierCodeEdit.SetValue(values[1]);
            txtSupplierNameEdit.SetText(values[2]);
            txtSupplierAddressEdit.SetText(values[3]);
            txtPhoneNumber1Edit.SetText(values[4]);
            txtPhoneNumber2Edit.SetText(values[5]);
            txtEmailEdit.SetText(values[6]);
            txtCreditPeriodEdit.SetText(values[7]);


        };

        function EmptyAdd() {
            txtSupplierCodeAdd.SetText("");
            txtSupplierNameAdd.SetText("");
            txtSupplierAddressAdd.SetText("");
            txtEmailAdd.SetText("");
            txtPhoneNumber1Add.SetText("");
            txtPhoneNumber2Add.SetText("");
            txtCreditPeriodAdd.SetText(0);
            dtpBalanceDateAdd.SetText("");
            cboBalanceTypeAdd.SetSelectedIndex(-1);
            txtBalanceAmountAdd.SetValue(0);


            lblErrMsgAdd.SetText("");
            lblSuccessMsgAdd.SetText("");
            lblErrMsgAdd.SetVisibe(False);
            lblSuccessMsgAdd.SetVisibe(False);
        };
        function EmptyEdit() {
            cboSupplierTypeEdit.SetSelectedIndex(-1);
            cboSiteEdit.SetSelectedIndex(-1);
            txtSupplierNameEdit.SetText("");
            txtSupplierAddressEdit.SetText("");
            txtEmailEdit.SetText("");
            txtPhoneNumber1Edit.SetText("");
            txtPhoneNumber2Edit.SetText("");
            txtCreditPeriodEdit.SetText(0);
            dtpBalanceDateEdit.SetText("");
            cboBalanceTypeEdit.SetSelectedIndex(-1);
            txtBalanceAmountEdit.SetValue(0);

            lblErrMsgEdit.SetText("");
            lblSuccessMsgEdit.SetText("");
            lblErrMsgEdit.SetVisibe(False);
            lblSuccessMsgEdit.SetVisibe(False);

        };

        function get_del_focused_row() {
            GridViewSuppliers.GetRowValues(GridViewSuppliers.GetFocusedRowIndex(), 'SupplierID;SupplierName', on_get_delete_row);
        };
        function on_get_delete_row(values) {

            txtSupplierIDDelete.SetValue(values[0]);
            lblSupplierDelete.SetText(values[1]);

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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">SUPPLIERS</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Add New" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Edit" Alignment="Right" AdaptivePriority="2">
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
                        <dx:ASPxGridView ID="GridViewSuppliers" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSuppliers" DataSourceID="SqlDataSourceSuppliers" Width="100%" KeyFieldName="SupplierID">
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
                                <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="5" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SupplierCode" VisibleIndex="1" Width="40px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SupplierName" VisibleIndex="0" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SupplierAddress" VisibleIndex="7" Caption="Address" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="8" Caption="Phone No." Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PhoneNumber2" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="10" Caption="Email" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CreditPeriod" VisibleIndex="13" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="BalanceDate" VisibleIndex="14" Visible="False" Width="50px"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="BalanceTypeID" VisibleIndex="16" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="OpeningBalance" VisibleIndex="17" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="18" Width="50px">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TransactionType" VisibleIndex="15" Visible="False" Width="50px">
                                </dx:GridViewDataTextColumn>
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
    <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New Supplier"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                        <Items>
                        <dx:LayoutItem Caption="Supplier Code" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox  ID="txtSupplierCodeAdd" runat="server" ClientInstanceName="txtSupplierCodeAdd"  Font-Bold="True" ForeColor="#0D6B68">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                            <dx:LayoutItem Caption="Supplier Name" ColSpan="4" ColumnSpan="4">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="txtSupplierNameAdd" runat="server" ClientInstanceName="txtSupplierNameAdd">
                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxMemo runat="server" ID="txtSupplierAddressAdd" ClientInstanceName="txtSupplierAddressAdd" Width="100%">
                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </dx:ASPxMemo>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Email" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox runat="server" ID="txtEmailAdd" ClientInstanceName="txtEmailAdd">
                                        </dx:ASPxTextBox>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox runat="server" ID="txtPhoneNumber1Add" ClientInstanceName="txtPhoneNumber1Add" Width="150px">
                                            <MaskSettings Mask="0000000000"></MaskSettings>

                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox runat="server" Width="150px" ClientInstanceName="txtPhoneNumber2Add" ID="txtPhoneNumber2Add">
                                        </dx:ASPxTextBox>



                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Credit Period(days)" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxSpinEdit runat="server" MaxValue="99999999999999" DecimalPlaces="2" Number="0" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0" ClientInstanceName="txtCreditPeriodAdd" ID="txtCreditPeriodAdd">
                                            <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                            <ClientSideEvents GotFocus="function(s, e) {if (txtCreditPeriodAdd.GetValue() == 0)  txtCreditPeriodAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCreditPeriodAdd.GetText() == &#39;&#39;)  txtCreditPeriodAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>
                                        </dx:ASPxSpinEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Opening Balance" ColSpan="4" ColumnSpan="4">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <hr style="height: 2px" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionSettings Location="Top"></CaptionSettings>

                                <CaptionStyle Font-Bold="True" Font-Size="Large" ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Balance Date" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpBalanceDateAdd" ID="dtpBalanceDateAdd" Width="150px">
                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Balance Type" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceTransactionType" TextField="TransactionType" ValueField="TransactionTypeID" ClientInstanceName="cboBalanceTypeAdd" ID="cboBalanceTypeAdd" Width="150px">
                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                <RequiredField IsRequired="True"></RequiredField>
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>

                                        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [TransactionType]" ID="SqlDataSourceBalanceTypeAdd"></asp:SqlDataSource>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Amount" ColSpan="2" ColumnSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxSpinEdit runat="server" MaxValue="10000000000000000000000000000" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtBalanceAmountAdd" ID="txtBalanceAmountAdd">
                                            <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                            <ClientSideEvents GotFocus="function(s, e) { if (txtBalanceAmountAdd.GetValue() == 0)  txtBalanceAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtBalanceAmountAdd.GetText() == &#39;&#39;)  txtBalanceAmountAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom"></ValidationSettings>
                                        </dx:ASPxSpinEdit>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                            </dx:EmptyLayoutItem>
                            <dx:LayoutItem ColSpan="2" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 130px">
                                                    <dx:ASPxButton ID="cmdSubmitAdd" runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Add" Width="120px">
                                                    </dx:ASPxButton>
                                                </td>
                                                <td>
                                                    <dx:ASPxButton ID="cmdRefreshAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                        <ClientSideEvents Click="function(s, e) { EmptyAdd();}"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <dx:ASPxPopupControl ID="PopupConfirmSaveAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupElementID="cmdSubmitAdd" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                            <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ContentCollection>
                                                <dx:PopupControlContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout6" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                        <Items>
                                                            <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton ID="cmdSaveYesAdd" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                            <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton ID="cmdSaveNoAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                            <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}" />
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
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>
                            <dx:LayoutItem ColSpan="2" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <CaptionStyle ForeColor="Black"></CaptionStyle>
                            </dx:LayoutItem>

                        </Items>
                                                <Styles>
                                <LayoutGroupBox>
                                    <Caption Font-Bold="True" ForeColor="Black">
                                    </Caption>
                                </LayoutGroupBox>
                                <LayoutItem>
                                    <Caption Font-Bold="True" ForeColor="Black">
                                    </Caption>
                                </LayoutItem>
                            </Styles>

                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>




    <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEdit" CloseAction="CloseButton" HeaderText="Edit Supplier"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Supplier Code" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtSupplierCodeEdit" ID="txtSupplierCodeEdit" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:EmptyLayoutItem ColSpan="1"></dx:EmptyLayoutItem>
                        <dx:LayoutItem Caption="Supplier Name" ColSpan="4" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSupplierNameEdit" runat="server" ClientInstanceName="txtSupplierNameEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" ID="txtSupplierAddressEdit" ClientInstanceName="txtSupplierAddressEdit" Width="100%">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxMemo>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Email" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtEmailEdit" ClientInstanceName="txtEmailEdit">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtPhoneNumber1Edit" ClientInstanceName="txtPhoneNumber1Edit" Width="150px">
                                        <MaskSettings Mask="0000000000"></MaskSettings>

                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" Width="150px" ClientInstanceName="txtPhoneNumber2Edit" ID="txtPhoneNumber2Edit">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Credit Period(days)">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit runat="server" MaxValue="99999999999999" DecimalPlaces="2" Number="0" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0" ClientInstanceName="txtCreditPeriodEdit" ID="txtCreditPeriodEdit">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                        <ClientSideEvents GotFocus="function(s, e) {if (txtCreditPeriodEdit.GetValue() == 0)  txtCreditPeriodEdit.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCreditPeriodEdit.GetText() == &#39;&#39;)  txtCreditPeriodEdit.SetText(&#39;0&#39;);}"></ClientSideEvents>
                                    </dx:ASPxSpinEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Edit" Width="120px" ID="cmdSubmitEdit"></dx:ASPxButton>

                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshEdit">
                                                    <ClientSideEvents Click="function(s, e) { EmptyEdit();}"></ClientSideEvents>
                                                </dx:ASPxButton>

                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" PopupElementID="cmdSubmitEdit" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveEdit">
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
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoEdit">
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
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>

                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtSupplierIDEdit" ClientVisible="False" ID="txtSupplierIDEdit"></dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Are you sure you want DELETE the Item?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" HeaderStyle-ForeColor="#CC3300">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="" ShowCaption="False" HorizontalAlign="Center" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel runat="server" ID="lblSupplierDelete" ClientInstanceName="lblSupplierDelete" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxLabel>
                                    <dx:ASPxTextBox runat="server" ID="txtSupplierIDDelete" ClientInstanceName="txtSupplierIDDelete" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
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
                                    <dx:ASPxLabel ID="lblErrMsgDelete" runat="server" ClientInstanceName="lblErrMsgDelete" ForeColor="Red" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgDelete" runat="server" ClientInstanceName="lblSuccessMsgDelete" ForeColor="Blue" Font-Bold="true" ClientVisible="false" ></dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>




    <asp:SqlDataSource ID="SqlDataSourceSuppliers" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM Suppliers ORDER BY SupplierName" SelectCommandType="Text">
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceTransactionType" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM TransactionType WHERE TransactionTypeID>0 ORDER BY TransactionTypeID"></asp:SqlDataSource>
</asp:Content>

