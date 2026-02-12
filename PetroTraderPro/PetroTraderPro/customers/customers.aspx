<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="customers.aspx.vb" Inherits="PetroTraderPro.customers" %>

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
            EmptyAdd();
            popupAdd.Show();
        };

        function get_edit_focused_row() {
            GridViewCustomers.GetRowValues(GridViewCustomers.GetFocusedRowIndex(), 'CustomerID;CustomerTypeID;CustomerCode;CustomerName;CustomerAddress;PhoneNumber1;PhoneNumber2;EmailAddress;SiteID;CreditLimit;CreditPeriod', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { Cancel; };
            if (values[0] == null) { Cancel; };
            EmptyEdit;

            txtCustomerIDEdit.SetValue(values[0]);
            txtCustomerCodeEdit.SetValue(values[2]);
            cboCustomerTypeEdit.SetValue(values[1]);
            cboSiteEdit.SetValue(values[8]);
            txtCustomerNameEdit.SetText(values[3]);
            txtCustomerAddressEdit.SetText(values[4]);
            txtEmailEdit.SetText(values[7]);
            txtPhoneNumber1Edit.SetText(values[5]);
            txtPhoneNumber2Edit.SetText(values[6]);
            txtCreditLimitEdit.SetText(values[9]);
            txtCreditPeriodEdit.SetText(values[10]);


            popupEdit.Show();
        };

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };
        function EmptyAdd() {
            cboCustomerTypeAdd.SetSelectedIndex(-1);
            //cboSiteAdd.SetSelectedIndex(-1);
            txtCustomerNameAdd.SetText("");
            txtCustomerAddressAdd.SetText("");
            txtEmailAdd.SetText("");
            txtPhoneNumber1Add.SetText("");
            txtPhoneNumber2Add.SetText("");
            txtCreditLimitAdd.SetText(0);
            txtCreditPeriodAdd.SetText(0);
            dtpBalanceDateAdd.SetText("");
            cboBalanceTypeAdd.SetSelectedIndex(-1);
            txtBalanceAmountAdd.SetValue(0);
        };
        function EmptyEdit() {
            cboCustomerTypeEdit.SetSelectedIndex(-1);
            //cboSiteEdit.SetSelectedIndex(-1);
            txtCustomerNameEdit.SetText("");
            txtCustomerAddressEdit.SetText("");
            txtEmailEdit.SetText("");
            txtPhoneNumber1Edit.SetText("");
            txtPhoneNumber2Edit.SetText("");
            txtCreditLimitEdit.SetText(0);
            txtCreditPeriodEdit.SetText(0);
            dtpBalanceDateEdit.SetText("");
            cboBalanceTypeEdit.SetSelectedIndex(-1);
            txtBalanceAmountEdit.SetValue(0);
        };

        function get_del_focused_row() {
            GridViewCustomers.GetRowValues(GridViewCustomers.GetFocusedRowIndex(), 'CustomerID;CustomerName', on_get_delete_row);
        };
        function on_get_delete_row(values) {

            txtCustomerIDDelete.SetValue(values[0]);
            lblCustomerDelete.SetText(values[1]);

            PopupConfirmDelete.Show();
        };

        function OnSaveAdd(s, e) {
            lblErrMsgAdd.SetVisible(false);
            lblErrMsgAdd.SetText("");
            lblSuccessMsgAdd.SetVisible(false);
            lblSuccessMsgAdd.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                //var amnt = txtAmountAdd.GetValue();
                //if (parseFloat(amnt) <= 0) { lblErrMsgAdd.SetVisible(true); lblErrMsgAdd.SetText('Please Enter the Amount'); txtAmountAdd.Focus(); return; };

                PopupConfirmSaveAdd.Show();
            }
        };



        function OnSaveEdit(s, e) {
            lblErrMsgEdit.SetVisible(false);
            lblErrMsgEdit.SetText("");
            lblSuccessMsgEdit.SetVisible(false);
            lblSuccessMsgEdit.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                //var amnt = txtAmountEdit.GetValue();
                //if (parseFloat(amnt) <= 0) { lblErrMsgEdit.SetVisible(true); lblErrMsgEdit.SetText('Please Enter the Amount'); txtAmountEdit.Focus(); return; };

                PopupConfirmSaveEdit.Show();
            }
        };


        function SetTarget() {
            document.forms[0].target = "_blank";
        }

    </script>

    <script runat="server">

        Protected Function GetTotalCustomers() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceCustomers.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalCount As Double = dtTemp.Rows.Count
            Return TotalCount
        End Function



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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">CUSTOMERS</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New Customer" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Edit Customer" Alignment="Right" Visible="false" AdaptivePriority="2">
                <Image Url="../img/edit-20.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Delete" Alignment="Right" Visible="false" AdaptivePriority="2">
                <Image Url="../img/Delete.png" Height="20" />
            </dx:MenuItem>
            <dx:MenuItem Name="Print" Text="Print" Alignment="Right" AdaptivePriority="2" Visible="false">
                <Image Url="../img/print-20.png" />
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
    <dx:ASPxFormLayout ID="ASPxFormLayout5" runat="server" Width="100%" ColCount="6" ColumnCount="6">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
        </SettingsAdaptivity>

        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" ID="cmdPrint" ClientInstanceName="cmdPrint" Text="Print List" Width="120px">
                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="Total Number" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxLabel ID="lblCustomerCount" runat="server" ClientInstanceName="lblCustomerCount" ForeColor="#0D6B68" Font-Bold="true" Text="0"></dx:ASPxLabel>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>

        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SqlDataSourceSearchSite" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
                <Items>
                    <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridView ID="GridViewCustomers" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewCustomers" DataSourceID="SqlDataSourceCustomers" Width="100%" KeyFieldName="CustomerID" EnableCallBacks="false">
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
                                        <dx:GridViewCommandColumn Caption="" VisibleIndex="0" Width="20px">
                                            <CustomButtons>
                                                <dx:GridViewCommandColumnCustomButton ID="cmdView" Text=" ">
                                                    <Image Height="20px" Width="20px" Url="../img/view-100.png" />
                                                </dx:GridViewCommandColumnCustomButton>
                                            </CustomButtons>
                                        </dx:GridViewCommandColumn>

                                        <dx:GridViewDataTextColumn FieldName="CustomerType" VisibleIndex="2" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="5" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerTypeID" VisibleIndex="6" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="1" Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="0" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="7" Caption="Address" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="8" Caption="Phone No." Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PhoneNumber2" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerSites" VisibleIndex="4" Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="10" Caption="Email" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreditLimit" VisibleIndex="12" Width="50px"></dx:GridViewDataTextColumn>
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

            <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New Customer"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="1100px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="8" ColumnCount="8">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutGroup ColSpan="5" ColumnSpan="5" ColCount="2" ColumnCount="2" RowSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Customer Name" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtCustomerNameAdd" ID="txtCustomerNameAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Customer Type" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceCustomerType" TextField="CustomerType" ValueField="CustomerTypeID" ClientInstanceName="cboCustomerTypeAdd" ID="cboCustomerTypeAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo runat="server" Width="100%" ClientInstanceName="txtCustomerAddressAdd" ID="txtCustomerAddressAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxMemo>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Email" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtEmailAdd" ID="txtEmailAdd"></dx:ASPxTextBox>





                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtPhoneNumber1Add" ID="txtPhoneNumber1Add" Width="150px">
                                                        <MaskSettings Mask="0000000000"></MaskSettings>

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" Width="150px" ClientInstanceName="txtPhoneNumber2Add" ID="txtPhoneNumber2Add">
                                                    </dx:ASPxTextBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Credit Limit" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="10000000000000000000000000000" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtCreditLimitAdd" ID="txtCreditLimitAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtCreditLimitAdd.GetValue() == 0)  txtCreditLimitAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCreditLimitAdd.GetText() == &#39;&#39;)  txtCreditLimitAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>
                                                    </dx:ASPxSpinEdit>






                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Credit Period(days)" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="99999999999999" DecimalPlaces="2" Number="0" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0" ClientInstanceName="txtCreditPeriodAdd" ID="txtCreditPeriodAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents GotFocus="function(s, e) {if (txtCreditPeriodAdd.GetValue() == 0)  txtCreditPeriodAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCreditPeriodAdd.GetText() == &#39;&#39;)  txtCreditPeriodAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Opening Balance" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <hr style="height: 2px" />


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionSettings Location="Top"></CaptionSettings>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black" Font-Size="Large"></CaptionStyle>
                                        </dx:LayoutItem>
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

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Balance Type" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceTransactionType" TextField="TransactionType" ValueField="TransactionTypeID" ClientInstanceName="cboBalanceTypeAdd" ID="cboBalanceTypeAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>


                                                    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [TransactionType]" ID="SqlDataSourceBalanceTypeAdd"></asp:SqlDataSource>




                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
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

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Site" RowSpan="5" ColSpan="1" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" KeyFieldName="SiteID" ClientInstanceName="GridViewCustomerSitesAdd" DataSourceID="SqlDataSourceSites" Width="300px" EnableTheming="True" ID="GridViewCustomerSitesAdd">
                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                        <Settings VerticalScrollableHeight="300" VerticalScrollBarMode="Visible"></Settings>

                                                        <SettingsBehavior AllowSelectByRowClick="True"></SettingsBehavior>

                                                        <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False"></SettingsDataSecurity>

                                                        <SettingsPopup>
                                                            <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                        </SettingsPopup>
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" Width="10px" VisibleIndex="0"></dx:GridViewCommandColumn>
                                                            <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                <EditFormSettings Visible="False"></EditFormSettings>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="SiteName" ShowInCustomizationForm="True" Width="30px" Caption="Site" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                        </Columns>
                                                    </dx:ASPxGridView>



                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionSettings Location="Top"></CaptionSettings>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>


                                <dx:LayoutItem ShowCaption="False" ColSpan="3" ColumnSpan="3">
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
                                <dx:LayoutItem ShowCaption="False" ColSpan="8" ColumnSpan="8">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblErrMsgAdd" ClientVisible="False" Font-Bold="True" ForeColor="Red" ID="lblErrMsgAdd"></dx:ASPxLabel>


                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblSuccessMsgAdd" ClientVisible="False" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgAdd"></dx:ASPxLabel>


                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False" ID="txtTransactionCode"></dx:ASPxTextBox>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEdit" CloseAction="CloseButton" HeaderText="Edit Customer"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Customer Code" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtCustomerCodeEdit" ID="txtCustomerCodeEdit" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Customer Type" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox runat="server" ID="cboCustomerTypeEdit" DataSourceID="SqlDataSourceCustomerType" TextField="CustomerType" ValueField="CustomerTypeID" ValueType="System.Int32" ClientInstanceName="cboCustomerTypeEdit">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                            </dx:ASPxComboBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Customer Name" ColSpan="4" ColumnSpan="4">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtCustomerNameEdit" runat="server" ClientInstanceName="txtCustomerNameEdit">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo runat="server" ID="txtCustomerAddressEdit" ClientInstanceName="txtCustomerAddressEdit" Width="100%">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxMemo>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Email" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtEmailEdit" ClientInstanceName="txtEmailEdit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
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
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="150px" ClientInstanceName="txtPhoneNumber2Edit" ID="txtPhoneNumber2Edit">
                                            </dx:ASPxTextBox>



                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Credit Limit" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtCreditLimitEdit" runat="server" ClientInstanceName="txtCreditLimitEdit" DecimalPlaces="2" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="10000000000000000000000000000" Number="0" Width="150px" AllowMouseWheel="False">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtCreditLimitEdit.GetValue() == 0)  txtCreditLimitEdit.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCreditLimitEdit.GetText() == &#39;&#39;)  txtCreditLimitEdit.SetText(&#39;0&#39;);}" />
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
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
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
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
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtCustomerIDEdit" ClientVisible="False" ID="txtCustomerIDEdit"></dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="popupView" runat="server" AllowDragging="True" ClientInstanceName="popupView" CloseAction="CloseButton" HeaderText="Customer Details"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="1100px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout9" runat="server" Width="100%" ColCount="8" ColumnCount="8">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutGroup ColCount="3" ColSpan="8" ColumnCount="3" ColumnSpan="8" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton runat="server" Text="Edit" Width="110px" BackColor="#CC9900" ID="cmdEdit"></dx:ASPxButton>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton runat="server" Text="Change Site" Width="100%" ID="cmdChangeSite" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {popupAssignSite.Show();}"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdDelete" runat="server" AutoPostBack="false" BackColor="Red" Text="Delete" Width="110px">
                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Show(); txtCustomerIDDelete.SetValue(txtCustomerIDView.GetText());}"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="5" ColumnSpan="5" RowSpan="2" ColCount="2" ColumnCount="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Customer Code" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientReadOnly="True" ClientInstanceName="txtCustomerCodeView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCustomerCodeView"></dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Balance" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientReadOnly="True" ClientInstanceName="txtBalanceView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtBalanceView">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Customer Type" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientReadOnly="True" ClientInstanceName="txtCustomerTypeView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCustomerTypeView"></dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Customer Name" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientReadOnly="True" ClientInstanceName="txtCustomerNameView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCustomerNameView"></dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Address" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo runat="server" Width="100%" ClientReadOnly="True" ClientInstanceName="txtCustomerAddressView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCustomerAddressView"></dx:ASPxMemo>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Email" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientReadOnly="True" ClientInstanceName="txtEmailView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtEmailView"></dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" Width="150px" ClientReadOnly="True" ClientInstanceName="txtPhoneNumber1View" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtPhoneNumber1View"></dx:ASPxTextBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" Width="150px" ClientReadOnly="True" ClientInstanceName="txtPhoneNumber2View" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtPhoneNumber2View"></dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Credit Limit" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="10000000000000000000000000000" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientReadOnly="True" ClientInstanceName="txtCreditLimitView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCreditLimitView">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Credit Period(days)" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="99999999999999" DecimalPlaces="2" Number="0" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0" ClientReadOnly="True" ClientInstanceName="txtCreditPeriodView" BackColor="#CCCCCC" Font-Bold="True" ForeColor="#0D6B68" ID="txtCreditPeriodView">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Customer Site" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" KeyFieldName="SiteID" ClientInstanceName="GridViewUnassigned" DataSourceID="SqlDataSourceUnassignedSite" Theme="Youthful" Width="100%" ID="ASPxGridView1">
                                                        <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>

                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                        <Settings VerticalScrollBarMode="Visible"></Settings>

                                                        <SettingsBehavior AllowFocusedRow="false"  ></SettingsBehavior>

                                                        <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False"></SettingsDataSecurity>

                                                        <SettingsPopup>
                                                            <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                        </SettingsPopup>
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="SiteName" ShowInCustomizationForm="True" Width="80px" Caption="Site" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="SiteCode" ShowInCustomizationForm="True" Width="50px" Visible="False" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" ShowInCustomizationForm="True" Width="50px" Visible="False" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <Styles>
                                                            <Header Font-Bold="True" BackColor="White" ForeColor="Black">
                                                                <Border BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                                                            </Header>
                                                            <Cell>
                                                                <Border BorderStyle="Solid" BorderWidth="1px" BorderColor="#CCCCCC" />
                                                            </Cell>
                                                            <SelectedRow BackColor="#339933" ForeColor="White">
                                                            </SelectedRow>
                                                            <FocusedRow BackColor="#339933" ForeColor="White">
                                                            </FocusedRow>

                                                        </Styles>
                                                        <Border BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                                                    </dx:ASPxGridView>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>

                                            <CaptionSettings Location="Top"></CaptionSettings>

                                            <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>


                                <dx:LayoutItem ColSpan="8" ColumnSpan="8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblErrMsgView" ClientVisible="False" Font-Bold="True" ForeColor="Red" ID="lblErrMsgView"></dx:ASPxLabel>


                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblSuccessMsgView" ClientVisible="False" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgView"></dx:ASPxLabel>





                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupAssignSite" runat="server" AllowDragging="True" ClientInstanceName="popupAssignSite" CloseAction="CloseButton" HeaderText="Assign Site" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>

                                <dx:LayoutItem ColSpan="1" Caption="Unassigned">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridView ID="GridViewUnassigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewUnassigned" Width="350px" KeyFieldName="SiteID" Theme="Youthful" DataSourceID="SqlDataSourceUnassignedSite" EnableCallBacks="False">
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
                                                <Columns>
                                                    <dx:GridViewCommandColumn Caption="" VisibleIndex="0" Width="20px">
                                                        <CustomButtons>
                                                            <dx:GridViewCommandColumnCustomButton ID="cmdAddSite" Text=" ">
                                                                <Image Height="20px" Width="20px" Url="../img/add-100.png" />
                                                            </dx:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>

                                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="60px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="4" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                </Columns>


                                            </dx:ASPxGridView>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top"></CaptionSettings>
                                    <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Assigned">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridView ID="GridViewAssigned" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewAssigned" Width="350px" Theme="Youthful" DataSourceID="SqlDataSourceAssignedSite" KeyFieldName="SiteID" EnableCallBacks="False">
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
                                                <Columns>
                                                    <dx:GridViewCommandColumn Caption="" VisibleIndex="0" Width="20px">
                                                        <CustomButtons>
                                                            <dx:GridViewCommandColumnCustomButton ID="cmdRemoveSite" Text=" ">
                                                                <Image Height="20px" Width="20px" Url="../img/Delete.png" />
                                                            </dx:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Caption="Site" Width="60px"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                                </Columns>


                                            </dx:ASPxGridView>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top"></CaptionSettings>
                                    <CaptionStyle Font-Bold="True" ForeColor="#000099"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False" ColumnSpan="2">
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
                                            <dx:ASPxLabel runat="server" ID="lblCustomerDelete" ClientInstanceName="lblCustomerDelete" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtCustomerIDDelete" ClientInstanceName="txtCustomerIDDelete" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
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

            <dx:ASPxPopupControl ID="PopupConfirmPrint" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmPrint" CloseAction="None" HeaderText="Print Item List" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ShowCaption="False" HorizontalAlign="Center" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdPrintYes" runat="server" Text="No" ValidationGroup="Print" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {SetTarget(); PopupConfirmPrint.Hide();}"></ClientSideEvents>
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" HorizontalAlign="Center" ShowCaption="False" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <asp:Label ID="lblErrMsgPrint" runat="server" ForeColor="Red" Visible="False" CssClass="dxe-day-has-appointments"></asp:Label>
                                            <asp:Label ID="lblSuccessMsgPrint" runat="server" Font-Bold="True" ForeColor="Blue" Visible="False"></asp:Label>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>



            <asp:SqlDataSource ID="SqlDataSourceCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_Customers] ORDER BY [CustomerName]">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <dx:ASPxTextBox ID="txtSiteSearch" runat="server" AutoPostBack="true" ClientVisible="false" ClientInstanceName="txtSiteSearch" Text="0">
            </dx:ASPxTextBox>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomerType" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM CustomerType WHERE CustomerTypeID>0 ORDER BY CustomerTypeID"></asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceTransactionType" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM TransactionType WHERE TransactionTypeID>0 ORDER BY TransactionTypeID"></asp:SqlDataSource>

            <dx:ASPxTextBox runat="server" ClientInstanceName="txtCustomerIDView" ClientVisible="False" ID="txtCustomerIDView" AutoPostBack="true"></dx:ASPxTextBox>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceUnassignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM   Sites WHERE SiteID NOT IN (SELECT SiteID FROM View_CustomerSites WHERE CustomerID =@CustomerID) AND SiteID>0 ORDER BY [SiteName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCustomerIDView" PropertyName="Text" DefaultValue="-1" Name="CustomerID"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceAssignedSite" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT SiteID,SiteCode,SiteName FROM [View_CustomerSites] WHERE ([CustomerID] = @CustomerID) ORDER BY [SiteName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCustomerIDView" PropertyName="Text" DefaultValue="-1" Name="CustomerID" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

