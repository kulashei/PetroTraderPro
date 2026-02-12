<%@ Page Title="Accounts Setup" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="accountSetup.aspx.vb" Inherits="PetroTraderPro.accountSetup" %>

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
            GridViewAccounts.GetRowValues(GridViewAccounts.GetFocusedRowIndex(), 'AccountID;AccountCategoryID;SiteID;AccountTypeID;AccountCode;AccountName;Description;BankID;BankAccountNumber;BankBranch;SiteCode;SiteName;AccountCategory;AccountType;BankType;BankName;BankTypeID', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { Cancel; };
            if (values[0] == null) { Cancel; };
            EmptyEdit;

            popupEdit.Show();

            //lblErrMsgEdit.SetVisible(false)
            //lblSuccessMsgEdit.SetVisible(false)
            //lblErrMsgEdit.SetText("");
            //lblSuccessMsgEdit.SetText("");

            txtAccountIDEdit.SetValue(values[0]);
            cboSiteEdit.SetValue(values[2]);
            cboAccountTypeEdit.SetValue(values[3]);
            ShowDetailsEdit();
            txtAccountCodeEdit.SetText(values[4]);
            txtAccountNameEdit.SetText(values[5]);
            txtAccountDescriptionEdit.SetText(values[6]);

            cboBankEdit.SetValue(values[7]);
            txtBankAccountNumberEdit.SetText(values[8]);
            txtBankBranchEdit.SetText(values[9]);

            cboMobileOperatorEdit.SetValue(values[7]);
            txtMobileNumberEdit.SetText(values[8]);


        };

        function EmptyAdd() {
            //cboSiteAdd.SetText("");
            cboAccountTypeAdd.SetSelectedIndex(-1);
            txtAccountCodeAdd.SetText("");
            txtAccountNameAdd.SetText("");
            txtAccountDescriptionAdd.SetText("");

            FormLayoutAdd.GetItemByName('bankGroupAdd').SetVisible(false);
            FormLayoutAdd.GetItemByName('MobileGroupAdd').SetVisible(false);

            cboBankAdd.SetSelectedIndex(-1);
            txtBankAccountNumberAdd.SetText("");
            txtBankBranchAdd.SetText("");

            cboMobileOperatorAdd.SetSelectedIndex(-1);
            txtMobileNumberAdd.SetText("");

            dtpBalanceDateAdd.SetText("");
            cboBalanceTypeAdd.SetSelectedIndex(-1);
            txtBalanceAmountAdd.SetValue(0);

            lblErrMsgAdd.SetVisible(false)
            lblSuccessMsgAdd.SetVisible(false)
            lblErrMsgAdd.SetText("");
            lblSuccessMsgAdd.SetText("");

            GenerateTransCode();

        };

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };

        function EmptyBankAdd() {
            cboBankAdd.SetSelectedIndex(-1);
            txtBankAccountNumberAdd.SetText("");
            txtBankBranchAdd.SetText("");
        };

        function EmptyMobileAdd() {
            cboMobileOperatorAdd.SetSelectedIndex(-1);
            txtMobileNumberAdd.SetText("");
        };


        function ShowDetailsAdd() {
            FormLayoutAdd.GetItemByName('bankGroupAdd').SetVisible(false);
            FormLayoutAdd.GetItemByName('MobileGroupAdd').SetVisible(false);
            var intAccountType = cboAccountTypeAdd.GetValue();
            if (intAccountType == 1) {

                FormLayoutAdd.GetItemByName('bankGroupAdd').SetVisible(false);
                FormLayoutAdd.GetItemByName('MobileGroupAdd').SetVisible(false);
                EmptyBankAdd();
                EmptyMobileAdd();

            } else if (intAccountType == 2) {
                FormLayoutAdd.GetItemByName('bankGroupAdd').SetVisible(true);
                FormLayoutAdd.GetItemByName('MobileGroupAdd').SetVisible(false);
                EmptyBankAdd();
                EmptyMobileAdd();
            } else if (intAccountType == 3) {
                FormLayoutAdd.GetItemByName('bankGroupAdd').SetVisible(false);
                FormLayoutAdd.GetItemByName('MobileGroupAdd').SetVisible(true);
                EmptyBankAdd();
                EmptyMobileAdd();
            };
        };
        function OnSaveAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAdd.Show();
            }
        };

        function EmptyEdit() {
            lblErrMsgEdit.SetText("");
            lblSuccessMsgEdit.SetText("");
            lblErrMsgEdit.SetVisible(false)
            lblSuccessMsgEdit.SetVisible(false)
            txtAccountIDEdit.SetValue(0);
            cboSiteEdit.SetText("");
            cboAccountTypeEdit.SetSelectedIndex(-1);
            txtAccountCodeEdit.SetText("");
            txtAccountNameEdit.SetText("");
            txtAccountDescriptionEdit.SetText("");

            cboBankEdit.SetSelectedIndex(-1);
            txtBankAccountNumberEdit.SetText("");
            txtBankBranchEdit.SetText("");

            cboMobileOperatorEdit.SetSelectedIndex(-1);
            txtMobileNumberEdit.SetText("");



        };

        function EmptyBankEdit() {
            cboBankEdit.SetSelectedIndex(-1);
            txtBankAccountNumberEdit.SetText("");
            txtBankBranchEdit.SetText("");
        };

        function EmptyMobileEdit() {
            cboMobileOperatorEdit.SetSelectedIndex(-1);
            txtMobileNumberEdit.SetText("");
        };


        function ShowDetailsEdit() {
            FormLayoutEdit.GetItemByName('bankGroupEdit').SetVisible(false);
            FormLayoutEdit.GetItemByName('MobileGroupEdit').SetVisible(false);
            var intAccountType = cboAccountTypeEdit.GetValue();
            if (intAccountType == 1) {

                FormLayoutEdit.GetItemByName('bankGroupEdit').SetVisible(false);
                FormLayoutEdit.GetItemByName('MobileGroupEdit').SetVisible(false);
                EmptyBankEdit();
                EmptyMobileEdit();

            } else if (intAccountType == 2) {
                FormLayoutEdit.GetItemByName('bankGroupEdit').SetVisible(true);
                FormLayoutEdit.GetItemByName('MobileGroupEdit').SetVisible(false);
                EmptyBankEdit();
                EmptyMobileEdit();
            } else if (intAccountType == 3) {
                FormLayoutEdit.GetItemByName('bankGroupEdit').SetVisible(false);
                FormLayoutEdit.GetItemByName('MobileGroupEdit').SetVisible(true);
                EmptyBankEdit();
                EmptyMobileEdit();
            };
        };
        function OnSaveEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveEdit.Show();
            }
        };


        function get_del_focused_row() {
            GridViewAccounts.GetRowValues(GridViewAccounts.GetFocusedRowIndex(), 'AccountID;AccountName', on_get_delete_row);
        };
        function on_get_delete_row(values) {

            txtAccountIDDelete.SetValue(values[0]);
            lblAccountDelete.SetText(values[1]);

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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Accounts</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New Account" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" Height="20px" Width="20px" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
    <dx:ASPxPanel runat="server" ID="FilterPanel" ClientInstanceName="filterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit"  Caption="Search" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="onFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <dx:ASPxCallbackPanel runat="server" ID="cbpList" ClientInstanceName="cbpList" Height="2px"
                Width="100%">
                <SettingsLoadingPanel ImagePosition="Top" Text="Please Wait...." />
                <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                <PanelCollection>
                    <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
                <Items>
                    <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridView ID="GridViewAccounts" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAccounts" DataSourceID="SqlDataSourceAccounts" Width="100%" KeyFieldName="AccountID">
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
                                        <dx:GridViewDataTextColumn Caption=" " ShowInCustomizationForm="True" VisibleIndex="0" Width="20px">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="cmdView" runat="server" OnClick="cmdView_Click" RenderMode="Link" Theme="SoftOrange" Width="100%">
                                                    <Image Height="16px" Url="../img/view-20.png">
                                                    </Image>
                                                    <ClientSideEvents Click="function(s, e) { cbpList.PerformCallback();}" />
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn FieldName="AccountType" VisibleIndex="4" Width="30px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountID" ReadOnly="True" VisibleIndex="6" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountTypeID" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountCode" VisibleIndex="2" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountName" VisibleIndex="3" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="10" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankName" VisibleIndex="11" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankAccountNumber" VisibleIndex="12" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankBranch" VisibleIndex="13" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="BalanceDate" VisibleIndex="14" Visible="False" Width="50px"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="BalanceTypeID" VisibleIndex="15" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="OpeningBalance" VisibleIndex="16" Visible="False" Width="50px"></dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="17" Width="30px" Visible="False">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankType" Visible="False" VisibleIndex="18"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankTypeID" Visible="False" VisibleIndex="19"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BankID" Visible="False" VisibleIndex="20" Width="20px"></dx:GridViewDataTextColumn>
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

            <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New Account"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="1100px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {ShowDetailsAdd();}"></ClientSideEvents>

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="FormLayoutAdd" runat="server" ClientInstanceName="FormLayoutAdd" Width="100%" ColCount="3" ColumnCount="3">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutGroup Caption="Account" ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Account Type" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceAccountType" TextField="AccountType" ValueField="AccountTypeID" ClientInstanceName="cboAccountTypeAdd" ID="cboAccountTypeAdd">
                                                                <ClientSideEvents ValueChanged="function(s, e) {ShowDetailsAdd();}"></ClientSideEvents>

                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="LoadSite">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account Code" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtAccountCodeAdd" ID="txtAccountCodeAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>


                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account Name" ColSpan="2" ColumnSpan="2">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtAccountNameAdd" ID="txtAccountNameAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Description" ColSpan="2" ColumnSpan="2">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxMemo runat="server" ClientInstanceName="txtAccountDescriptionAdd" ID="txtAccountDescriptionAdd"></dx:ASPxMemo>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="Bank" Name="bankGroupAdd" ColSpan="2" ColumnSpan="2">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Bank" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceBank" TextField="BankName" ValueField="BankID" ClientInstanceName="cboBankAdd" ID="cboBankAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account No" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtBankAccountNumberAdd" ID="txtBankAccountNumberAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Bank Branch" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtBankBranchAdd" ID="txtBankBranchAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>


                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="Mobile Money" Name="MobileGroupAdd" ColSpan="2" ColumnSpan="2">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Operator" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceMobileMoney" TextField="BankName" ValueField="BankID" ClientInstanceName="cboMobileOperatorAdd" ID="cboMobileOperatorAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>


                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Phone No" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtMobileNumberAdd" ID="txtMobileNumberAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="Opening Balance" ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Balance Date" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpBalanceDateAdd" ID="dtpBalanceDateAdd">
                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxDateEdit>

                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Balance Type" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32" ClientInstanceName="cboBalanceTypeAdd" ID="cboBalanceTypeAdd">
                                                                <Items>
                                                                    <dx:ListEditItem Text="Debit" Value="1"></dx:ListEditItem>
                                                                    <dx:ListEditItem Text="Credit" Value="2"></dx:ListEditItem>
                                                                    <dx:ListEditItem Text="Nill" Value="3"></dx:ListEditItem>
                                                                </Items>

                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                    <RequiredField IsRequired="True"></RequiredField>
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>



                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Amount" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxSpinEdit runat="server" MaxValue="10000000000000000000000000000" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtBalanceAmountAdd" ID="txtBalanceAmountAdd">
                                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                                <ClientSideEvents GotFocus="function(s, e) { if (txtBalanceAmountAdd.GetValue() == 0)  txtBalanceAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtBalanceAmountAdd.GetText() == &#39;&#39;)  txtBalanceAmountAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom"></ValidationSettings>
                                                            </dx:ASPxSpinEdit>


                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="1" Caption="Bank Branch" RowSpan="2">
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxGridView ID="GridViewAccountSiteAdd" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAccountSiteAdd" DataSourceID="SqlDataSourceSite" EnableTheming="True" KeyFieldName="SiteID" Width="270px">
                                                        <SettingsPager Mode="ShowAllRecords">
                                                        </SettingsPager>
                                                        <Settings VerticalScrollableHeight="280" VerticalScrollBarMode="Visible" />
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
                                    </Items>
                                </dx:LayoutGroup>
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
                                <dx:LayoutItem ColSpan="2" ShowCaption="False" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtTransactionCode" ClientInstanceName="txtTransactionCode" ClientVisible="false"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                            <Styles>
                                <LayoutItem>
                                    <Caption Font-Bold="True" ForeColor="Black">
                                    </Caption>
                                </LayoutItem>
                            </Styles>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupView" runat="server" AllowDragging="True" ClientInstanceName="popupView" CloseAction="CloseButton" HeaderText="View New Account" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="1100px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <%--<ClientSideEvents PopUp="function(s, e) {ShowDetailsView();}" />--%>
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="FormLayoutView" runat="server" ClientInstanceName="FormLayoutView" ColCount="3" ColumnCount="3" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="3" ColSpan="3" ColumnCount="3" ShowCaption="False" ColumnSpan="3" Border-BorderStyle="None">
                                    <Border BorderStyle="None" />
                                    <GroupBoxStyle>
                                        <Border BorderStyle="None"></Border>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">

                                                    <dx:ASPxButton ID="cmdEditAccount" runat="server" Text="Edit Account" Width="120px" BackColor="#ff9933"></dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">

                                                    <dx:ASPxButton ID="cmdEditSite" runat="server" AutoPostBack="false" Text="Edit Site" Width="120px" BackColor="#ff9933">
                                                        <ClientSideEvents Click="function(s, e) {popupAssignSite.Show();}"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdDeleteAccount" runat="server" Text="Delete" Width="100px" BackColor="Red"></dx:ASPxButton>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>

                                <dx:LayoutGroup ColCount="2" ColSpan="2" ColumnCount="2" ColumnSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutGroup Caption="Account" ColCount="2" ColSpan="2" ColumnCount="2" ColumnSpan="2">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68">
                                                </Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Account Type" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblAccountTypeView" runat="server" ClientInstanceName="lblAccountTypeView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account Code" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblAccountCodeView" runat="server" ClientInstanceName="lblAccountCodeView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account Name" ColSpan="2" ColumnSpan="2">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblAccountNameView" runat="server" ClientInstanceName="lblAccountNameView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Description" ColSpan="2" ColumnSpan="2">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblAccountDescriptionView" runat="server" ClientInstanceName="lblAccountDescriptionView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="Bank" ColSpan="2" ColumnSpan="2" Name="bankGroupView">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68">
                                                </Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Bank" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblBankView" runat="server" ClientInstanceName="lblBankView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Account No" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblBankAccountNumberView" runat="server" ClientInstanceName="lblBankAccountNumberView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Bank Branch" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblBankBranchView" runat="server" ClientInstanceName="lblBankBranchView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="Mobile Money" ColSpan="2" ColumnSpan="2" Name="MobileGroupView">
                                            <GroupBoxStyle>
                                                <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68">
                                                </Caption>
                                            </GroupBoxStyle>
                                            <Items>
                                                <dx:LayoutItem Caption="Operator" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblMobileOperatorView" runat="server" ClientInstanceName="lblMobileOperatorView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Phone No" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <div style="text-align: left; vertical-align: middle;">
                                                                <dx:ASPxLabel ID="lblMobileNumberView" runat="server" ClientInstanceName="lblMobileNumberView" Font-Bold="True" ForeColor="#003399" Width="100%">
                                                                </dx:ASPxLabel>
                                                            </div>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Site" ColSpan="1" RowSpan="2">
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxGridView ID="GridViewAccountSiteView" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAccountSiteView" DataSourceID="SqlDataSourceAssignedSite" EnableTheming="True" KeyFieldName="SiteID" Width="270px" Theme="Youthful">
                                                        <SettingsPager Mode="ShowAllRecords">
                                                        </SettingsPager>
                                                        <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" />
                                                        <SettingsBehavior  AllowFocusedRow="false" AllowSort="false" />
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
                                                            <Header Font-Bold="True" ForeColor="Black">
                                                            </Header>
                                                        </Styles>
                                                    </dx:ASPxGridView>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgView" runat="server" ClientInstanceName="lblErrMsgView" Font-Bold="true" ForeColor="Red" Text="">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgView" runat="server" ClientInstanceName="lblSuccessMsgView" Font-Bold="true" ForeColor="Blue" Text="">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                            <Styles>
                                <LayoutItem>
                                    <Caption Font-Bold="True" ForeColor="Black">
                                    </Caption>
                                </LayoutItem>
                            </Styles>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEdit" CloseAction="CloseButton" HeaderText="Edit Account"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <%--        <ClientSideEvents PopUp="function(s, e) {ShowDetailsEdit();}"></ClientSideEvents>--%>

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                         <dx:ASPxCallbackPanel runat="server" ID="cbpEdit" ClientInstanceName="cbpEdit" Height="2px"
                            Width="100%">
                            <SettingsLoadingPanel ImagePosition="Top" Text="Please Wait...." />
                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                        <dx:ASPxFormLayout ID="FormLayoutEdit" runat="server" ClientInstanceName="FormLayoutEdit" Width="100%" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutGroup Caption="Account" ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem Caption="Account Type" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceAccountType" TextField="AccountType" ValueField="AccountTypeID" ClientInstanceName="cboAccountTypeEdit" ID="cboAccountTypeEdit">
                                                        <%--                                                <ClientSideEvents ValueChanged="function(s, e) {ShowDetailsEdit();}"></ClientSideEvents>--%>

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="LoadSite">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Account Code" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtAccountCodeEdit" ID="txtAccountCodeEdit">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Account Name" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtAccountNameEdit" ID="txtAccountNameEdit">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Description" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo runat="server" ClientInstanceName="txtAccountDescriptionEdit" ID="txtAccountDescriptionEdit"></dx:ASPxMemo>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>


                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Bank" ColSpan="2" ColumnSpan="2" Name="bankGroupEdit">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem Caption="Bank" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ID="cboBankEdit" ClientInstanceName="cboBankEdit" ValueType="System.Int32" DataSourceID="SqlDataSourceBank" TextField="BankName" ValueField="BankID">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Account No" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtBankAccountNumberEdit" ID="txtBankAccountNumberEdit">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Bank Branch" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtBankBranchEdit" ID="txtBankBranchEdit">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Mobile Money" ColSpan="2" ColumnSpan="2" Name="MobileGroupEdit">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" Font-Size="Large" ForeColor="#0D6B68"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem Caption="Operator" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ID="cboMobileOperatorEdit" ClientInstanceName="cboMobileOperatorEdit" ValueType="System.Int32" DataSourceID="SqlDataSourceMobileMoney" TextField="BankName" ValueField="BankID">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Phone No" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtMobileNumberEdit" ID="txtMobileNumberEdit">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>


                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Edit" Width="120px" ID="cmdSubmitEdit">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveEdit(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshEdit">
                                                            <ClientSideEvents Click="function(s, e) { EmptyEdit();}"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                </tr>
                                            </table>

                                            <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveEdit">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout7">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Edit" Width="120px" ID="cmdSaveYesEdit">
                                                                                <ClientSideEvents Click="function(s, e) {cbpEdit.PerformCallback();  PopupConfirmSaveEdit.Hide();}"></ClientSideEvents>
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
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtAccountIDEdit" ClientInstanceName="txtAccountIDEdit" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                            <Styles>
                                <LayoutItem>
                                    <Caption Font-Bold="True" ForeColor="Black">
                                    </Caption>
                                </LayoutItem>
                            </Styles>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Are you sure you want DELETE the Account?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" HeaderStyle-ForeColor="#CC3300">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ShowCaption="False" HorizontalAlign="Center" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ID="lblAccountDelete" ClientInstanceName="lblAccountDelete" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtAccountIDDelete" ClientInstanceName="txtAccountIDDelete" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
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
                                            <dx:ASPxButton ID="cmdDeleteNo" runat="server" Text="No" Width="120px" ValidationGroup="Delete" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgDelete" runat="server" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgDelete" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
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

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Medium" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxCallbackPanel ID="cbpAssignSite" runat="server" ClientInstanceName="cbpAssignSite" Height="2px" Width="100%">
                            <SettingsLoadingPanel ImagePosition="Top" Text="Assigning Site. Please Wait...." />
                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                        <dx:ASPxCallbackPanel ID="cbpUnAssignSite" runat="server" ClientInstanceName="cbpUnAssignSite" Height="2px" Width="100%">
                            <SettingsLoadingPanel ImagePosition="Top" Text="Assigning Site. Please Wait...." />
                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="6" ColumnCount="6">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>

                                <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Unassigned">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxGridView ID="GridViewSiteUnassigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSiteUnassigned" Width="100%" KeyFieldName="SiteID" Theme="Youthful" DataSourceID="SqlDataSourceUnassignedSite">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                </SettingsAdaptivity>
                                                <SettingsPager Mode="ShowAllRecords">
                                                </SettingsPager>
                                                <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False">
                                                    </FilterControl>
                                                </SettingsPopup>
                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Caption=" " Width="40px">
                                                        <DataItemTemplate>
                                                            <dx:ASPxButton ID="cmdView" runat="server" Theme="Youthful" OnClick="cmdAssignSite_Click" Height="10px"
                                                                Text="Add" Width="100%" Image-Url="~/img/Add2.png" Image-Height="16px">
                                                                <ClientSideEvents Click="function(s, e) {cbpAssignSite.PerformCallback(); }"></ClientSideEvents>
                                                            </dx:ASPxButton>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="80px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="4" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                </Columns>


                                                <Styles>
                                                    <Header Font-Bold="True" ForeColor="Black">
                                                    </Header>
                                                </Styles>


                                            </dx:ASPxGridView>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top"></CaptionSettings>
                                    <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Assigned">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridView ID="GridViewSiteAssigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSiteAssigned" Width="100%" Theme="Youthful" DataSourceID="SqlDataSourceAssignedSite" KeyFieldName="SiteID">
                                                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                </SettingsAdaptivity>
                                                <SettingsPager Mode="ShowAllRecords">
                                                </SettingsPager>
                                                <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False">
                                                    </FilterControl>
                                                </SettingsPopup>
                                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Caption=" " Width="40px">
                                                        <DataItemTemplate>
                                                            <dx:ASPxButton ID="cmdRemove" runat="server" Theme="Youthful" OnClick="cmdUnAssignSite_Click" Height="10px"
                                                                Text="Remove" Width="100%" Image-Url="~/img/Delete.png">
                                                                <ClientSideEvents Click="function(s, e) {cbpUnAssignSite.PerformCallback(); }"></ClientSideEvents>
                                                            </dx:ASPxButton>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="80px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                                </Columns>


                                                <Styles>
                                                    <Header Font-Bold="True" ForeColor="Black">
                                                    </Header>
                                                </Styles>


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

            <dx:ASPxTextBox runat="server" ID="txtAccountIDView" ClientInstanceName="txtAccountIDView" AutoPostBack="true" ClientVisible="false"></dx:ASPxTextBox>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceUnassignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM   Sites WHERE SiteID NOT IN (SELECT SiteID FROM View_AccountSite WHERE AccountID =@AccountID) AND SiteID>0 ORDER BY SiteName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccountIDView" PropertyName="Text" DefaultValue="-1" Name="AccountID"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceAssignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM View_AccountSite WHERE (AccountID = @AccountID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccountIDView" PropertyName="Text" DefaultValue="-1" Name="AccountID" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSite" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID, SiteName FROM Sites WHERE SiteID>0 ORDER BY SiteName"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_Accounts WHERE AccountID>0 ORDER BY AccountCode"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceAccountType" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM AccountType WHERE AccountTypeID>0 ORDER BY AccountTypeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceBank" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM View_Banks WHERE BankTypeID IN(1,2,4) ORDER BY BankTypeID,BankType"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceMobileMoney" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM View_Banks WHERE BankTypeID IN(3) ORDER BY BankTypeID"></asp:SqlDataSource>
            <div style="height: 50px;"></div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

