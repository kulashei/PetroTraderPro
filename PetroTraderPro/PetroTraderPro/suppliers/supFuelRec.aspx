<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="supFuelRec.aspx.vb" Inherits="PetroTraderPro.supFuelRec" %>


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
            var amount = Qty * price;
            var NetQty = Qty - Shortage;
            txtAmountAdd.SetValue(amount);
            txtNetQuantityAdd.SetValue(NetQty);

        }

        function CalculateAmountEdit(s, e) {
            var Qty = parseFloat(txtQuantityEdit.GetValue());
            var price = parseFloat(txtUnitPriceEdit.GetValue());
            var Shortage = parseFloat(txtShortageEdit.GetValue());
            var amount = Qty * price;
            var NetQty = Qty - Shortage;
            txtAmountEdit.SetValue(amount);
            txtNetQuantityEdit.SetValue(NetQty);

        }


        function EmptyAdd() {
            cboSupplierAdd.SetSelectedIndex(-1);
            cboProductAdd.SetSelectedIndex(-1);
            txtQuantityAdd.SetValue(0);
            txtUnitPriceAdd.SetValue(0);
            txtAmountAdd.SetValue(0);
            txtShortageAdd.SetValue(0);
            txtNetQuantityAdd.SetValue(0);
            txtInvoiceNumberAdd.SetText("");
            txtVehicleNumberAdd.SetText("");
            txtDriverAdd.SetText("");
            txtTransporterAdd.SetText("");
            cboLoadingPointAdd.SetSelectedIndex(-1);
            cboProductAdd.SetSelectedIndex(-1);
            txtRemarksAdd.SetText("");

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
            txtReceiptCancelSupplier.SetText("");
            txtReceiptCancelReceiptNo.SetText("");
            txtAmountAddCanceled.SetText("");
            txtRetrunRemark.SetText("");

            txtReceiptCancelSupplier.SetValue(txtReceiptViewSupplier.GetText());
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
            </dx:LayoutItem>
            <dx:LayoutItem Caption="To" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpSearchDateTo" ID="dtpSearchDateTo">
                            <ClientSideEvents DateChanged="function(s, e) { txtSearchDateTo.SetText(moment(dtpSearchDateTo.GetDate()).format(&#39;DD-MMM-YYYY&#39;));}"></ClientSideEvents>
                        </dx:ASPxDateEdit>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" Text="Search By Date" Width="150px" ID="cmdSearcByDate">
                        </dx:ASPxButton>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" ID="cmdViewReceiptReport" ClientInstanceName="cmdViewReceiptReport" Text="Print Report" Width="150px">
                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

        </Items>
    </dx:ASPxFormLayout>

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
                                <dx:ASPxGridView ID="GridViewReceipt" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewReceipt" Width="100%" KeyFieldName="ReceiptID" DataSourceID="SqlDataSourceReceipt">
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
                                        <dx:GridViewDataTextColumn FieldName="ReceiptID" VisibleIndex="0" Caption=" " Width="40px">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="cmdViewReceipt" runat="server" OnClick="cmdViewReceipt_Click"
                                                    Text="View" Theme="SoftOrange" Width="100%">
                                                    <Image Url="../img/view-20.png" Height="16px"></Image>
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="13" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierCode" VisibleIndex="14" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierName" VisibleIndex="2" Width="100px" Caption="Supplier"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="16" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="17" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="3" Width="50px" Caption="Product"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="18" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="15" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Capacity" VisibleIndex="19" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceiptID" VisibleIndex="20" Visible="False" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceiptCode" VisibleIndex="21" Width="50px" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="ReceiptDate" VisibleIndex="1" Caption="Date" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="22" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
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

            <dx:ASPxPopupControl ID="popupAddReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupAddReceipt" CloseAction="CloseButton" HeaderText="Add Receipt"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Date" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpReceiptDateAdd" ID="dtpReceiptDateAdd">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxDateEdit>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Supplier" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceSuppliers" TextField="SupplierName" ValueField="SupplierID"  ClientInstanceName="cboSupplierAdd" ID="cboSupplierAdd">

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Product" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" NullValueItemDisplayText="{2}" DataSourceID="SqlDataSourceProducts" TextField="ProductName" ValueField="ProductID" ClientInstanceName="cboProductAdd" ID="cboProductAdd">

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>



                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtQuantityAdd.GetValue() == 0)  txtQuantityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQuantityAdd.GetText() == &#39;&#39;)  txtQuantityAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>

                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtUnitPriceAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPriceAdd" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtUnitPriceAdd.GetValue() == 0)  txtUnitPriceAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtUnitPriceAdd.GetText() == &#39;&#39;)  txtUnitPriceAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd" />
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>

                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" ClientEnabled="False" ClientReadOnly="True">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountAdd.GetValue() == 0)  txtAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmountAdd.GetText() == &#39;&#39;)  txtAmountAdd.SetText(&#39;0&#39;);}" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtShortageAdd" ID="txtShortageAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtShortageAdd.GetValue() == 0)  txtShortageAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtShortageAdd.GetText() == &#39;&#39;)  txtShortageAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd" ValueChanged="CalculateAmountAdd"></ClientSideEvents>

                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>

                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtNetQuantityAdd" ClientEnabled="False" ID="txtNetQuantityAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents NumberChanged="CalculateAmountAdd" GotFocus="function(s, e) { if (txtNetQuantityAdd.GetValue() == 0)  txtNetQuantityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtNetQuantityAdd.GetText() == &#39;&#39;)  txtNetQuantityAdd.SetText(&#39;0&#39;);}" ValueChanged="CalculateAmountAdd"></ClientSideEvents>

                                                        <DisabledStyle ForeColor="Black"></DisabledStyle>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ShowCaption="False" ColSpan="2" ColumnSpan="2" ColCount="2" ColumnCount="2">
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Looding Point" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ID="cboLoadingPointAdd" ClientInstanceName="cboLoadingPointAdd" DataSourceID="SqlDataSourceLoadingPoint" ValueType="System.Int32" ValueField="LoadingPointID" TextField="LoadingPoint"></dx:ASPxComboBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Desitination" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ID="cboDestinationAdd" ClientInstanceName="cboDestinationAdd" DropDownStyle="DropDown"></dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Total Distance" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtDistanceAdd" ID="txtDistanceAdd">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                        <ClientSideEvents  GotFocus="function(s, e) { if (txtDistanceAdd.GetValue() == 0)  txtDistanceAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtDistanceAdd.GetText() == &#39;&#39;)  txtDistanceAdd.SetText(&#39;0&#39;);}" ></ClientSideEvents>

                                                    </dx:ASPxSpinEdit>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Remark" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo runat="server" ClientInstanceName="txtRemarksAdd" ID="txtRemarksAdd"></dx:ASPxMemo>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
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
                                                            <ClientSideEvents Click="function(s, e) {EmptyAdd ();  }"></ClientSideEvents>
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblNCount"></dx:ASPxLabel>

                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False" ID="txtTransactionCode"></dx:ASPxTextBox>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:ASPxFormLayout>

                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupViewReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupViewReceipt" CloseAction="CloseButton" HeaderText="View Receipt" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout11" runat="server"  ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="6" ColSpan="2" ColumnCount="6" ShowCaption="False" ColumnSpan="2">
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

                                <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Date" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server"  DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="txtReceiptDateView" ID="txtReceiptDateView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Supplier" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtSupplierView" ID="txtSupplierView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Product" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ClientInstanceName="txtProductView" ID="txtProductView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">

                                                    </dx:ASPxTextBox>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtUnitPriceView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPriceView" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px"    ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtShortageView" ID="txtShortageView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtNetQuantityView" ID="txtNetQuantityView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                    </dx:ASPxSpinEdit>

                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ShowCaption="False" ColSpan="2" ColumnSpan="2" ColCount="2" ColumnCount="2">
                                    <Items>
                                        <dx:LayoutItem Caption="Invoice No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtInvoiceNumberView" ClientInstanceName="txtInvoiceNumberView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Vehicle No." ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtVehicleNumberView" ClientInstanceName="txtVehicleNumberView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Tranporter" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtTransporterView" ClientInstanceName="txtTransporterView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Driver" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtDriverView" ClientInstanceName="txtDriverView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Looding Point" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtLoadingPointView" ClientInstanceName="txtLoadingPointView"   ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">

                                                    </dx:ASPxTextBox>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Desitination" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox runat="server" ID="txtDestinationView" ClientInstanceName="txtDestinationView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">

                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Total Distance" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtDistanceView" ID="txtDistanceView" ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">
                                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>


                                                    </dx:ASPxSpinEdit>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Remark" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo runat="server" ClientInstanceName="txtRemarksView" ID="txtRemarksView"  ForeColor="#0D6B68" Font-Bold="true" ClientReadOnly="true">

                                                    </dx:ASPxMemo>


                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <asp:Label runat="server" CssClass="dxe-day-has-appointments" ForeColor="Red" ID="lblErrMsgView" Visible="False"></asp:Label>


                                            <asp:Label runat="server" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgView" Visible="False"></asp:Label>


                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="ASPxLabel1"></dx:ASPxLabel>


                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtReceiptIDView" ClientVisible="False" ID="txtReceiptIDView"></dx:ASPxTextBox>






                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupEditReceipt" runat="server" AllowDragging="True" ClientInstanceName="popupEditReceipt" CloseAction="CloseButton" HeaderText="Edit Receipt" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout12" runat="server" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="2" ColSpan="2" ColumnCount="2" ColumnSpan="2" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Date" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxDateEdit ID="dtpReceiptDateEdit" runat="server" ClientInstanceName="dtpReceiptDateEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxDateEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Supplier" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboSupplierEdit" runat="server" ClientInstanceName="cboSupplierEdit" DataSourceID="SqlDataSourceSuppliers" TextField="SupplierName" ValueField="SupplierID" ValueType="System.Int32">
                                                        <ClientSideEvents ValueChanged="function(s, e) {EmptyEdit1(); }" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Product" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboProductEdit" runat="server" ClientInstanceName="cboProductEdit" DataSourceID="SqlDataSourceProducts" NullValueItemDisplayText="{2}" TextField="ProductName" ValueField="ProductID" ValueType="System.Int32">
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Quantity" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtQuantityEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtQuantityEdit.GetValue() == 0)  txtQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtQuantityEdit.GetText() == '')  txtQuantityEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Unit Price" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtUnitPriceEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPriceEdit" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountEdit" runat="server" AllowMouseWheel="False" ClientEnabled="False" ClientInstanceName="txtAmountEdit" ClientReadOnly="True" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountEdit.GetValue() == 0)  txtAmountEdit.SetText('');}" LostFocus="function(s, e) { if (txtAmountEdit.GetText() == '')  txtAmountEdit.SetText('0');}" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Shartage" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtShortageEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtShortageEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtShortageEdit.GetValue() == 0)  txtShortageEdit.SetText('');}" LostFocus="function(s, e) { if (txtShortageEdit.GetText() == '')  txtShortageEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Qty Discharged" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtNetQuantityEdit" runat="server" AllowMouseWheel="False" ClientEnabled="False" ClientInstanceName="txtNetQuantityEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtNetQuantityEdit.GetValue() == 0)  txtNetQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtNetQuantityEdit.GetText() == '')  txtNetQuantityEdit.SetText('0');}" NumberChanged="CalculateAmountEdit" ValueChanged="CalculateAmountEdit" />
                                                        <DisabledStyle ForeColor="Black">
                                                        </DisabledStyle>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup ColCount="2" ColSpan="2" ColumnCount="2" ColumnSpan="2" ShowCaption="False">
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
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
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Looding Point" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboLoadingPointEdit" runat="server" ClientInstanceName="cboLoadingPointEdit" DataSourceID="SqlDataSourceLoadingPoint" TextField="LoadingPoint" ValueField="LoadingPointID" ValueType="System.Int32">
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Desitination" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboDestinationEdit" runat="server" ClientInstanceName="cboDestinationEdit">
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Total Distance" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtDistanceEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtDistanceEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtDistanceEdit.GetValue() == 0)  txtDistanceEdit.SetText('');}" LostFocus="function(s, e) { if (txtDistanceEdit.GetText() == '')  txtDistanceEdit.SetText('0');}" />
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Remark" ColSpan="1">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxMemo ID="txtRemarksEdit" runat="server" ClientInstanceName="txtRemarksEdit">
                                                    </dx:ASPxMemo>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle Font-Bold="True" ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
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
                                                                            <dx:ASPxButton ID="cmdSaveYesEdit" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblNCount0" runat="server" ClientVisible="False">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtReceiptIDEdit" runat="server" ClientInstanceName="txtReceiptIDEdit" ClientVisible="False">
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
                                            <dx:ASPxButton ID="cmdErrMsgCancel" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="Cancel" Width="150px">
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
                                            <dx:ASPxButton ID="cmdConfirmDeleteYes" runat="server" Text="Yes" ValidationGroup="Add" Width="150px">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="150px">
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


            <dx:ASPxTextBox ID="txtSearchDateFrom" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateFrom">
            </dx:ASPxTextBox>

            <dx:ASPxTextBox ID="txtSearchDateTo" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateTo">
            </dx:ASPxTextBox>

            <asp:SqlDataSource ID="SqlDataSourceReceipt" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_SupplierFuelReceipt_SearchByDate" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSuppliers" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [Suppliers] WHERE SupplierID>0 ORDER BY [SupplierName]">
            </asp:SqlDataSource>


            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [FuelProducts] ORDER BY [ProductName]" ID="SqlDataSourceProducts">
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceLoadingPoint" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM FuelLoadingPoints WHERE LoadingPointID>0 ORDER BY LoadingPoint"></asp:SqlDataSource>

            <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


