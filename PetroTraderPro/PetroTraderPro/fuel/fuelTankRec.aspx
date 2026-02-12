<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="fuelTankRec.aspx.vb" Inherits="PetroTraderPro.fuelTankRec" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">
        function page_toolbar_item_clicked(itm) {
            if (itm == "New") {
                popupAddReceipt.Show();
                EmptyAdd();
                GenerateTransCode();
            }
        };

        function get_new_form() {
            popupAdd.Show();
        };

        function getCustomButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            var grid = GridLookupPumpAdd.GetGridView();
            grid.GetRowValues(e.visibleIndex, 'PumpID;PumpCode;Rate;CostPrice', getClientRowValues);

        };


        function OnClientFocusedRowChanged() {
            var grid = GridLookupPumpAdd.GetGridView();
            grid.GetRowValues(grid.GetFocusedRowIndex(), 'PumpID;PumpCode;Rate;CostPrice', getClientRowValues);
        };
        function getClientRowValues(values) {
            txtUnitPriceAdd.SetValue(0);
            txtCostPriceAdd.SetValue(0);
            //txtBatchNumber.SetText("");
            //txtExpiryDate.SetText("");
            //txtQuantityAdd.SetValue(0);

            txtUnitPriceAdd.SetValue(values[2]);
            txtCostPriceAdd.SetValue(values[3]);
            //txtBatchNumber.SetText(values[5]);
            //txtExpiryDate.SetText(values[6]);

            CalculateAmountAdd();
        };

        function CalculateAmountAdd(s, e) {
            var Qty = parseFloat(txtQuantityAdd.GetValue());
            var price = parseFloat(txtUnitPriceAdd.GetValue());
            var Shortage = parseFloat(txtShortageAdd.GetValue());
            var Over = parseFloat(txtOverAdd.GetValue());
            var amount = Qty * price;
            var NetQty = Qty - Shortage + Over;
            txtAmountAdd.SetValue(amount);
            txtNetQuantityAdd.SetValue(NetQty);

        }

        function CalculateAmountEdit(s, e) {
            var Qty = parseFloat(txtOpenMetreEdit.GetValue());
            var CloseMetre = parseFloat(txtClosingMetreEdit.GetValue());
            var TestQty = parseFloat(txtTestQuantityEdit.GetValue());
            var price = parseFloat(txtUnitPriceEdit.GetValue());
            var Qty = CloseMetre - OpenMetre;
            var NetQty = Qty - TestQty;
            var amount = NetQty * price;
            txtQuantityEdit.SetValue(Qty);
            txtNetQuantityEdit.SetValue(NetQty);
            txtAmountEdit.SetValue(amount);

        }

        function EmptyAdd() {
            var itmCont = cboSiteAdd.GetItemCount();
            if (itmCont > 1) {
                cboSiteAdd.SetSelectedIndex(-1);
            }
         //cboSiteAdd.SetSelectedIndex(-1);
            cboTankAdd.SetSelectedIndex(-1);
            txtQuantityAdd.SetValue(0);
            txtUnitPriceAdd.SetValue(0);
            txtAmountAdd.SetValue(0);
            txtShortageAdd.SetValue(0);
            txtOverAdd.SetValue(0);
            txtNetQuantityAdd.SetValue(0);
            txtInvoiceNumberAdd.SetText("");
            txtVehicleNumberAdd.SetText("");
            txtDriverAdd.SetText("");
            txtTransporterAdd.SetText("");
            txtRemarksAdd.SetText("");

        };
        function EmptyAdd1() {
            cboTankAdd.SetSelectedIndex(-1);
        };


        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };

        function onCustomButtonClick1(s, e) {
            if (e.buttonID == "cmdView") {
                e.processOnServer = true;
            }
        }

        function LoadReceiptCancel(s, e) {
            txtReceiptCancelSite.SetText("");
            txtReceiptCancelReceiptNo.SetText("");
            txtAmountAddCanceled.SetText("");
            txtRetrunRemark.SetText("");

            txtReceiptCancelSite.SetValue(txtReceiptViewSite.GetText());
            txtReceiptCancelReceiptNo.SetValue(txtReceiptViewReceiptNo.GetText());
            txtAmountAddCanceled.SetValue(txtReceiptViewTotalAmount.GetText());

            popupCancelReceipt.Show();

        }

        function paymentMode(s, e) {
            if (cboPaymentMode.GetValue() == 1) {
                txtPaymentDetails.SetText("CASH");
                txtPaymentDetails.SetReadOnly(true);
            }
            else if (cboPaymentMode.GetValue() != 1) {
                txtPaymentDetails.SetText("");
                txtPaymentDetails.SetReadOnly(false);
            }

        };
        function OnSaveAdd(s, e) {
            lblErrMsgAdd.SetVisible(false);
            lblErrMsgAdd.SetText("");
            lblSuccessMsgAdd.SetVisible(false);
            lblSuccessMsgAdd.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                var qty = txtQuantityAdd.GetValue();
                var price = txtUnitPriceAdd.GetValue();
                if (parseFloat(qty) <= 0) { lblErrMsgAdd.SetVisible(true); lblErrMsgAdd.SetText('Please Enter the Quantity Received'); txtQuantityAdd.Focus(); return; };
                if (parseFloat(price) <= 0) { lblErrMsgAdd.SetVisible(true); lblErrMsgAdd.SetText('Please Set the Unit Price'); txtUnitPriceAdd.Focus(); return; };

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
                var qty = txtQuantityEdit.GetValue();
                var price = txtUnitPriceEdit.GetValue();
                if (parseFloat(qty) <= 0) { lblErrMsgEdit.SetVisible(true); lblErrMsgEdit.SetText('Please Enter the Quantity Received'); txtQuantityEdit.Focus(); return; };
                if (parseFloat(price) <= 0) { lblErrMsgEdit.SetVisible(true); lblErrMsgEdit.SetText('Please Set the Unit Price'); txtUnitPriceEdit.Focus(); return; };

                PopupConfirmSaveEdit.Show();
            }
        };
        function SetTarget() {
            document.forms[0].target = "_blank";
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Fuel Receipt</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Add Receipt" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>

    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" ColCount="6" ColumnCount="6">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
        </SettingsAdaptivity>

        <Items>
            <dx:LayoutItem ColSpan="1" Caption="From">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpSearchDateFrom" ID="dtpSearchDateFrom">
                            <ClientSideEvents DateChanged="function(s, e) { txtSearchDateFrom.SetText(moment(dtpSearchDateFrom.GetDate()).format(&#39;DD-MMM-YYYY&#39;));}"></ClientSideEvents>
                        </dx:ASPxDateEdit>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="To" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpSearchDateTo" ID="dtpSearchDateTo">
                            <ClientSideEvents DateChanged="function(s, e) { txtSearchDateTo.SetText(moment(dtpSearchDateTo.GetDate()).format(&#39;DD-MMM-YYYY&#39;));}"></ClientSideEvents>
                        </dx:ASPxDateEdit>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>

            <dx:LayoutItem ColSpan="2" Caption="Site" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox runat="server" ID="cboSiteSearch" ClientInstanceName="cboSiteSearch" DataSourceID="SqlDataSourceSearchSite" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">

                            <ClientSideEvents ValueChanged="function(s, e) {txtSiteSearch.SetValue(cboSiteSearch.GetValue());}"></ClientSideEvents>
                        </dx:ASPxComboBox>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" Text="Search By Date" Width="150px" ID="cmdSearcByDate">
                        </dx:ASPxButton>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
            </dx:LayoutItem>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" ID="cmdViewReceiptReport" ClientInstanceName="cmdViewReceiptReport" Text="Print Report" Width="120px">
                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                        </dx:ASPxButton>
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
                                <dx:ASPxGridView ID="GridViewReceipt" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" Width="100%" KeyFieldName="ReceiptID" DataSourceID="SqlDataSourceReceipt" EnableCallBacks="false">
                                    <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                    </SettingsAdaptivity>
                                    <SettingsPager PageSize="50" Position="Top">
                                        <PageSizeItemSettings Visible="True">
                                        </PageSizeItemSettings>
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

                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="13" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="14" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="15" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="16" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="17" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteProductID" VisibleIndex="18" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TankCode" VisibleIndex="3" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Capacity" VisibleIndex="19" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceiptID" VisibleIndex="20" Visible="False" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceiptCode" VisibleIndex="21" Width="50px" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="ReceiptDate" VisibleIndex="1" Caption="Date" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="TankID" VisibleIndex="22" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="5" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="6" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.###0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="7" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Overs" VisibleIndex="24" Width="50px" Visible="False">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="QuantityDischarged" VisibleIndex="25" Width="50px" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="InvoiceNo" VisibleIndex="4" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="VehicleNo" Width="50px" VisibleIndex="9">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Trasporter" Width="50px" VisibleIndex="10">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DriverName" Width="50px" VisibleIndex="11">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Remark" Width="50px" VisibleIndex="12"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Shortage" Width="50px" VisibleIndex="8">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
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


            <dx:ASPxPopupControl ID="popupAddReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupAddReceipt" CloseAction="CloseButton" HeaderText="Add Receipt"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">

                        <dx:ASPxCallbackPanel runat="server" ID="cbpLoadDataAdd" ClientInstanceName="cbpLoadDataAdd" Height="2px"
                            Width="100%">
                            <SettingsLoadingPanel ImagePosition="Top" Text="Loading Info. Please Wait...." />
                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" ColCount="12" ColumnCount="12">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpReceiptDateAdd" runat="server" ClientInstanceName="dtpReceiptDateAdd" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteAdd" runat="server" AutoPostBack="true" ClientInstanceName="cboSiteAdd" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32" DataSourceID="SqlDataSourceSites">
                                                <ClientSideEvents ValueChanged="function(s, e) {cbpLoadDataAdd.PerformCallback(); EmptyAdd1(); }" />
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="7" ColumnSpan="7" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Tank" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboTankAdd" runat="server" ClientInstanceName="cboTankAdd" TextField="TankCode" ValueField="TankID" ValueType="System.Int32" DataSourceID="SqlDataSourceTanks" TextFormatString="{2}">
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="TankID" ClientVisible="False"></dx:ListBoxColumn>
                                                            <dx:ListBoxColumn FieldName="SiteProductID" ClientVisible="False" Width="250px" Caption="Name"></dx:ListBoxColumn>
                                                            <dx:ListBoxColumn FieldName="TankCode" Width="250px" Caption="Tank"></dx:ListBoxColumn>
                                                        </Columns>

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceTanks" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_FuelTanks]WHERE ([SiteID] = @SiteID)  AND [Disabled]=0 ORDER BY [TankCode]">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="cboSiteAdd" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtQuantityAdd.GetValue() == 0)  txtQuantityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQuantityAdd.GetText() == &#39;&#39;)  txtQuantityAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="110px" DisplayFormatString="#,##0.###0" ClientInstanceName="txtUnitPriceAdd" ID="txtUnitPriceAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtUnitPriceAdd.GetValue() == 0)  txtUnitPriceAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtUnitPriceAdd.GetText() == &#39;&#39;)  txtUnitPriceAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd"></ClientSideEvents>

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtShortageAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtShortageAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtShortageAdd.GetValue() == 0)  txtShortageAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtShortageAdd.GetText() == &#39;&#39;)  txtShortageAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Over" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtOverAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtOverAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtOverAdd.GetValue() == 0)  txtOverAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtOverAdd.GetText() == &#39;&#39;)  txtOverAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtNetQuantityAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtNetQuantityAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px" ClientEnabled="false" BackColor="#CCCC00">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtNetQuantityAdd.GetValue() == 0)  txtNetQuantityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtNetQuantityAdd.GetText() == &#39;&#39;)  txtNetQuantityAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="110px" DisplayFormatString="#,##0.#0" ClientReadOnly="True" ClientInstanceName="txtAmountAdd" ClientEnabled="False" ID="txtAmountAdd" BackColor="#CCCC00">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountAdd.GetValue() == 0)  txtAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmountAdd.GetText() == &#39;&#39;)  txtAmountAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>

                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ShowCaption="False" ColSpan="5" ColumnSpan="5">
                                    <Items>
                                        <dx:LayoutItem Caption="Invoice No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtInvoiceNumberAdd" ClientInstanceName="txtInvoiceNumberAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Vehicle No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtVehicleNumberAdd" ClientInstanceName="txtVehicleNumberAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Tranporter" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtTransporterAdd" ClientInstanceName="txtTransporterAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Driver" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtDriverAdd" ClientInstanceName="txtDriverAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem Caption="Remark" ColSpan="12" ColumnSpan="12">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo runat="server" ID="txtRemarksAdd" ClientInstanceName="txtRemarksAdd"></dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="110px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveAdd(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="110px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyAdd ();  }"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout6" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesAdd" runat="server" Text="Yes" ValidationGroup="Add" Width="110px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="110px">
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
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="6" ShowCaption="False" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblNCount" runat="server" ClientVisible="False">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtTransactionCode" ClientInstanceName="txtTransactionCode" ClientVisible="false"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:ASPxFormLayout>

                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupViewReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupViewReceipt" CloseAction="CloseButton" HeaderText="View Receipt" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxCallbackPanel runat="server" ID="cbpView" ClientInstanceName="cbpView" Height="2px"
                            Width="100%">
                            <SettingsLoadingPanel ImagePosition="Top" Text="Loading Info. Please Wait...." />
                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>

                        <dx:ASPxFormLayout ID="ASPxFormLayout11" runat="server" ColCount="12" ColumnCount="12">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="6" ColSpan="12" ColumnCount="6" ColumnSpan="12" ShowCaption="False">
                                    <Items>
                                        <dx:EmptyLayoutItem ColSpan="1">
                                        </dx:EmptyLayoutItem>
                                        <dx:EmptyLayoutItem ColSpan="1">
                                        </dx:EmptyLayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdEdit" runat="server" BackColor="#CC9900" Text="Edit" Width="110px">
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdDelete" runat="server" AutoPostBack="false" BackColor="Red" Text="Delete" Width="110px">
                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Show();}"></ClientSideEvents>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:EmptyLayoutItem ColSpan="1">
                                        </dx:EmptyLayoutItem>
                                        <dx:EmptyLayoutItem ColSpan="1">
                                        </dx:EmptyLayoutItem>
                                    </Items>
                                </dx:LayoutGroup>

                                <dx:LayoutItem Caption="Date" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtReceiptDateView" runat="server" ClientInstanceName="txtReceiptDateView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameView" runat="server" ClientInstanceName="txtSiteNameView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutGroup ColCount="2" ColSpan="7" ColumnCount="2" ColumnSpan="7" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Tank" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtTankView" runat="server" ClientInstanceName="txtTankView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                        </DisabledStyle>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtUnitPriceView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPriceView" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtShortageView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtShortageView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Over" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtOverView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtOverView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtNetQuantityView" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtNetQuantityView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountView" runat="server" AllowMouseWheel="False" ClientEnabled="False" ClientInstanceName="txtAmountView" ClientReadOnly="True" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" Font-Bold="True" ForeColor="#0D6B68">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="5" ColumnSpan="5" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Invoice No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtInvoiceNumberView" runat="server" ClientInstanceName="txtInvoiceNumberView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                        </DisabledStyle>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Vehicle No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtVehicleNumberView" runat="server" ClientInstanceName="txtVehicleNumberView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                        </DisabledStyle>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Tranporter" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtTransporterView" runat="server" ClientInstanceName="txtTransporterView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                        </DisabledStyle>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Driver" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtDriverView" runat="server" ClientInstanceName="txtDriverView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                        </DisabledStyle>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem Caption="Remark" ColSpan="12" ColumnSpan="12">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtRemarksView" runat="server" ClientInstanceName="txtRemarksView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgView" runat="server" ClientInstanceName="lblErrMsgView" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgView" runat="server" ClientInstanceName="lblSuccessMsgView" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtReceiptIDView" runat="server" ClientInstanceName="txtReceiptIDView" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupEditReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupEditReceipt" CloseAction="CloseButton" HeaderText="Edit Receipt" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout12" runat="server" ColCount="12" ColumnCount="12">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpReceiptDateEdit" runat="server" ClientInstanceName="dtpReceiptDateEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteEdit" runat="server" AutoPostBack="true"  ClientInstanceName="cboSiteEdit" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                <ClientSideEvents ValueChanged="function(s, e) {EmptyEdit1(); }" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutGroup ColCount="2" ColSpan="7" ColumnCount="2" ColumnSpan="7" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Tank" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboTankEdit" runat="server"  ClientInstanceName="cboTankEdit" DataSourceID="SqlDataSourceTanksEdit" TextField="TankCode" TextFormatString="{2}" ValueField="TankID" ValueType="System.Int32">
                                                        <Columns>
                                                            <dx:ListBoxColumn ClientVisible="False" FieldName="TankID">
                                                            </dx:ListBoxColumn>
                                                            <dx:ListBoxColumn Caption="Name" ClientVisible="False" FieldName="SiteProductID" Width="250px">
                                                            </dx:ListBoxColumn>
                                                            <dx:ListBoxColumn Caption="Tank" FieldName="TankCode" Width="250px">
                                                            </dx:ListBoxColumn>
                                                        </Columns>
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                    <asp:SqlDataSource ID="SqlDataSourceTanksEdit" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_FuelTanks]WHERE ([SiteID] = @SiteID)  AND [Disabled]=0  ORDER BY [TankCode]">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="cboSiteEdit" DefaultValue="0" Name="SiteID" PropertyName="Value" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtQuantityEdit.GetValue() == 0)  txtQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtQuantityEdit.GetText() == '')  txtQuantityEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtUnitPriceEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPriceEdit" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtUnitPriceEdit.GetValue() == 0)  txtUnitPriceEdit.SetText('');}" LostFocus="function(s, e) { if (txtUnitPriceEdit.GetText() == '')  txtUnitPriceEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtShortageEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtShortageEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtShortageEdit.GetValue() == 0)  txtShortageEdit.SetText('');}" LostFocus="function(s, e) { if (txtShortageEdit.GetText() == '')  txtShortageEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Over" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtOverEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtOverEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtOverEdit.GetValue() == 0)  txtOverEdit.SetText('');}" LostFocus="function(s, e) { if (txtOverEdit.GetText() == '')  txtOverEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtNetQuantityEdit" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtNetQuantityEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px" BackColor="#CCCC00">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtNetQuantityEdit.GetValue() == 0)  txtNetQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtNetQuantityEdit.GetText() == '')  txtNetQuantityEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountEdit" runat="server" AllowMouseWheel="False" ClientEnabled="False" ClientInstanceName="txtAmountEdit" ClientReadOnly="True" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="110px" BackColor="#CCCC00">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountEdit.GetValue() == 0)  txtAmountEdit.SetText('');}" LostFocus="function(s, e) { if (txtAmountEdit.GetText() == '')  txtAmountEdit.SetText('0');}" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColSpan="5" ColumnSpan="5" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Invoice No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtInvoiceNumberEdit" runat="server" ClientInstanceName="txtInvoiceNumberEdit">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Vehicle No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtVehicleNumberEdit" runat="server" ClientInstanceName="txtVehicleNumberEdit">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Tranporter" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtTransporterEdit" runat="server" ClientInstanceName="txtTransporterEdit">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Driver" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtDriverEdit" runat="server" ClientInstanceName="txtDriverEdit">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem Caption="Remark" ColSpan="12" ColumnSpan="12">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtRemarksEdit" runat="server" ClientInstanceName="txtRemarksEdit">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="110px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="110px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyEdit ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout13" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesEdit" runat="server" Text="Yes" ValidationGroup="Add" Width="110px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="110px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEdit.Hide();}" />
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
                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtReceiptIDEdit" runat="server" ClientInstanceName="txtReceiptIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDEdit" runat="server"  ClientInstanceName="txtSiteIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtTankIDEdit" runat="server"  ClientInstanceName="txtTankIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="PopupErrMsg" runat="server" AllowDragging="True" ClientInstanceName="PopupErrMsg" CloseAction="None" Modal="True" ShowHeader="true" HeaderText="" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="500px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" Width="100%">
                            <Items>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ID="lblErrMsgGen" ClientInstanceName="lblErrMsgGen" Font-Bold="true" ForeColor="Red"></dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdErrMsgCancel" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="Cancel" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {PopupErrMsg.Hide(); GridLookupPump.SetValue (-1);}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Do you want to Delete the Receipt?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" PopupElementID="cmdSubmitRetrun">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout9" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteYes" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgDelete" ForeColor="Red"></dx:ASPxLabel>
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgDelete" ForeColor="blue"></dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxTextBox ID="txtSiteSearch" runat="server" ClientVisible="false" ClientInstanceName="txtSiteSearch" Text="0">
            </dx:ASPxTextBox>

            <dx:ASPxTextBox ID="txtSearchDateFrom" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateFrom">
            </dx:ASPxTextBox>

            <dx:ASPxTextBox ID="txtSearchDateTo" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateTo">
            </dx:ASPxTextBox>

            <asp:SqlDataSource ID="SqlDataSourceReceipt" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_FuelTankReceipt_SearchByDateByUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSiteSearch" Name="SiteID" PropertyName="Text" Type="Int32" DefaultValue="-1" />
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID,SiteCode, SiteName FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <%--            <asp:SqlDataSource runat="server" ID="SqlDataSourcePrint" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PrinterSetup ORDER BY PrinterTypeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePaymentMode" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PaymentMode WHERE PaymentModeID>0 ORDER BY PaymentModeID"></asp:SqlDataSource>--%>

            <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


