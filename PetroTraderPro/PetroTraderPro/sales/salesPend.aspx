<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="salesPend.aspx.vb" Inherits="PetroTraderPro.salesPend" %>

<%@ Register Assembly="DevExpress.XtraReports.v24.2.Web.WebForms, Version=24.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

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
                popupAddSales.Show();
            }
        //    else if (itm == "Edit") {
        //        get_edit_focused_row();
        //    } else if (itm == "Delete") {
        //        get_del_focused_row();
        //    } else if (itm == "Print") {
        //        PopupConfirmPrint.Show();
        //    };
        };

        function get_new_form() {
            popupAdd.Show();
        };

        function getCustomButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            var grid = GridLookupItems.GetGridView();
            grid.GetRowValues(e.visibleIndex, 'ItemID;RetailPrice;CurrentStock', getClientRowValues);

        };

        function OnClientFocusedRowChanged() {
            var grid = GridLookupItems.GetGridView();
            grid.GetRowValues(grid.GetFocusedRowIndex(), 'ItemID;RetailPrice;CurrentStock', getClientRowValues);
        };
        function getClientRowValues(values) {
            txtUnitPrice.SetValue(0);
            txtQtyInStock.SetValue(0);
            //txtBatchNumber.SetText("");
            //txtExpiryDate.SetText("");
            //txtQuantity.SetValue(0);

            txtUnitPrice.SetValue(values[1]);
            txtQtyInStock.SetValue(values[2]);
            //txtBatchNumber.SetText(values[5]);
            //txtExpiryDate.SetText(values[6]);

            CalculateAmount();
        };

        function CalculateAmount(s, e) {
            var Qty = parseFloat(txtQuantity.GetValue());
            var price = parseFloat(txtUnitPrice.GetValue());
            var stock = parseFloat(txtQtyInStock.GetValue());
            var amount = Qty * price;
            var StockBal = stock - Qty;
            txtAmount.SetValue(amount);
            txtQtyRemainig.SetValue(StockBal);

        }

        function CalculateBalance(s, e) {
            var AmountPaind = parseFloat(txtAmountPaid.GetValue());
            var totalSales = parseFloat(cpSummary());
            var Bal = AmountPaind - totalSales;
            txtBalance.SetValue(Bal);

        }
        function AddListItems(s, e) {
            var fName = firstName.GetValue();
            var lName = lastName.GetValue();
            firstName.SetText('');
            lastName.SetText('');
            var FullName = new Array(fName, lName);
            comboBox.AddItem(FullName);
        }

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };

        function onCustomButtonClick1(s, e) {
            if (e.buttonID == "cmdView") {
                e.processOnServer = true;
            }
        }

        function LoadSalesCancel(s, e) {
            txtSalesCancelSite.SetText("");
            txtSalesCancelReceiptNo.SetText("");
            txtAmountCanceled.SetText("");
            txtRetrunRemark.SetText("");

            txtSalesCancelSite.SetValue(txtSalesViewSite.GetText());
            txtSalesCancelReceiptNo.SetValue(txtSalesViewReceiptNo.GetText());
            txtAmountCanceled.SetValue(txtSalesViewTotalAmount.GetText());

            popupCancelSales.Show();

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

        }

        function NumbrValidate(s, e) {
            var ValueNum = e.value;
            if (ValueNum = 14) {
                e.isValid = false;
            }
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">SALES</h1>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>


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
                                <dx:ASPxGridView ID="GridViewSales" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" DataSourceID="SqlDataSourceSales" Width="100%" KeyFieldName="SalesID">
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
                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="0" Caption=" " Width="40px">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="cmdViewSales" runat="server" OnClick="cmdViewSales_Click"
                                                    Text="View" Theme="SoftOrange" Width="100%">
                                                    <Image Url="../img/view-20.png" Height="16px">  </Image>
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="4" Caption="Customer" Width="80px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TransactionType" VisibleIndex="6" Caption="Trans. Type" Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="8" Caption="Site" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="9" ReadOnly="True" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesReceiptNo" VisibleIndex="2" Caption="Receipt No." Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesCode" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="SalesDate" VisibleIndex="1" Caption="Date" Width="40px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="TransactionTypeID" VisibleIndex="11" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="12" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="13" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TotalAmount" VisibleIndex="15" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CashPaid" VisibleIndex="16" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="17" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Paid" VisibleIndex="18" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="PaymentDate" VisibleIndex="19" Visible="False"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceivedBy" VisibleIndex="20" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="PaymentRegDate" VisibleIndex="21" Visible="False"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentModeID" VisibleIndex="22" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentDetails" VisibleIndex="23" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemReceivedBy" VisibleIndex="24" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemReceivedByPhoneNumber" VisibleIndex="25" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemReceivedByVehicleNumber" VisibleIndex="26" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Canceled" VisibleIndex="27" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CanceledDate" VisibleIndex="28" Visible="False"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CancelRemark" VisibleIndex="29" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CanceledBy" VisibleIndex="30" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CanceledRegDate" VisibleIndex="31" Visible="False"></dx:GridViewDataDateColumn>

                                        <dx:GridViewDataTextColumn FieldName="TotalSales" VisibleIndex="14" Caption="Amount" Width="40px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentMode" VisibleIndex="33" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreatedByName" Width="50px" Caption="Created By" VisibleIndex="32"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentReceivedBy" Width="50px" Caption="Received By" VisibleIndex="34"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentStatus" Width="40px" VisibleIndex="35"></dx:GridViewDataTextColumn>
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
            <dx:ASPxPopupControl ID="PopupPrintReceipt" runat="server" AllowDragging="True" ClientInstanceName="PopupPrintReceipt" CloseAction="CloseButton" HeaderText="Sales Receipt" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="600px" Height="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxWebDocumentViewer ID="rptViewerReceipt" runat="server" DisableHttpHandlerValidation="False" ClientInstanceName="rptViewerReceipt" Height="600px">
                            <SettingsExport ShowPrintNotificationDialog="False" />
                            <ClientSideEvents Init="function(s, e) { s.GetReportPreview().zoom(0.9); }" />
                        </dx:ASPxWebDocumentViewer>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="popupViewSales" runat="server" AllowDragging="True" ClientInstanceName="popupViewSales" CloseAction="CloseButton" HeaderText="Sales Details" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {txtPaymentDetails.SetReadOnly(true);}"></ClientSideEvents>

                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" ColCount="6" ColumnCount="6" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                   <dx:LayoutItem ColSpan="2" Caption="Printer" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox runat="server" SelectedIndex="0" ValueType="System.Int32" DataSourceID="SqlDataSourcePrint" TextField="PrinterType" ValueField="PrinterTypeID" AutoPostBack="True" ClientInstanceName="cboSalesViewPrinter" ID="cboSalesViewPrinter">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>

                                <dx:LayoutItem Caption="Sales Date" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtSalesViewDate" ClientInstanceName="txtSalesViewDate" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtSalesViewSite" ClientInstanceName="txtSalesViewSite" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Receipt No." ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtSalesViewReceiptNo" ClientInstanceName="txtSalesViewReceiptNo" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridView ID="GridViewSalesView" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSalesView" EnableTheming="True" KeyFieldName="NCount" Theme="Youthful" Width="100%" DataSourceID="SqlDataSourceSalesView">
                                                <SettingsPager Mode="ShowAllRecords">
                                                </SettingsPager>
                                                <Settings ShowFooter="True" VerticalScrollableHeight="150" VerticalScrollBarMode="Visible" />
                                                <SettingsBehavior AllowFocusedRow="False" AllowSelectByRowClick="False" AllowSelectSingleRowOnly="True" />
                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False">
                                                    </FilterControl>
                                                </SettingsPopup>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn Caption="No." FieldName="ItemNo" VisibleIndex="1" Width="40px">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ItemID" Visible="False" VisibleIndex="2">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ItemName" VisibleIndex="3" Width="250px">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="5" Width="50px">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                                            <Style HorizontalAlign="Center">
                                                            </Style>
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="6" Width="50px">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="7" Width="80px">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Unit" FieldName="UM" VisibleIndex="4" Width="50px">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <TotalSummary>
                                                    <dx:ASPxSummaryItem DisplayFormat="Total: #,##0.#0" FieldName="Amount" ShowInGroupFooterColumn="Amount" SummaryType="Sum" />
                                                    <dx:ASPxSummaryItem DisplayFormat="No of Items: #,##0" FieldName="ItemID" ShowInGroupFooterColumn="ItemName" SummaryType="Count" />
                                                </TotalSummary>
                                                <Styles>
                                                    <Footer Font-Bold="True" Font-Size="Larger" ForeColor="#0D6B68">
                                                    </Footer>
                                                </Styles>
                                            </dx:ASPxGridView>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceSalesView" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT POSSalesDetails.*,ROW_NUMBER() OVER(ORDER BY NCount) AS 'ItemNo'  FROM [POSSalesDetails] WHERE ([SalesID] = @SalesID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="txtSalesViewSalesID" PropertyName="Text" DefaultValue="0" Name="SalesID"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutGroup ColCount="4" ColSpan="5" ColumnCount="4" ColumnSpan="5" ShowCaption="False">
                                    <Items>

                                        <dx:LayoutItem Caption="Payment Date" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxDateEdit ID="dtpPaymentDate" runat="server" ClientInstanceName="dtpPaymentDate" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxDateEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>

                                        <dx:LayoutItem Caption="Payment Mode" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboPaymentMode" runat="server" ClientInstanceName="cboPaymentMode" DataSourceID="SqlDataSourcePaymentMode" TextField="PaymentMode" ValueField="PaymentModeID" ValueType="System.Int32" SelectedIndex="0" ClientSideEvents-ValueChanged="paymentMode">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Payment Details" ColSpan="4" ColumnSpan="4">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtPaymentDetails" runat="server" ClientInstanceName="txtPaymentDetails" Width="100%">
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount Paid" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountPaid" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountPaid" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountPaid.GetValue() == 0)  txtAmountPaid.SetText('');}" LostFocus="function(s, e) { if (txtAmountPaid.GetText() == '')  txtAmountPaid.SetText('0');}" NumberChanged="CalculateBalance" ValueChanged="CalculateBalance" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Change" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtBalance" runat="server" AllowMouseWheel="False" ClientInstanceName="txtBalance" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" ClientEnabled="False">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtBalance.GetValue() == 0)  txtBalance.SetText('');}" LostFocus="function(s, e) { if (txtBalance.GetText() == '')  txtBalance.SetText('0');}" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                                        </ValidationSettings>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSave" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px">
                                                            </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefresh" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
<%--                                                            <ClientSideEvents Click="function(s, e) {
                                                    dtpStockDate.SetText (&quot;&quot;);
                                                    cboSite1.SetSelectedIndex (-1);
                                                    cboItem.SetSelectedIndex (-1);
                                                    dtpExpDate.SetText (&quot;&quot;);
                                                    txtBatchNumber.SetText (&quot;&quot;);
                                                    txtQtyInStock.SetValue (0);

                                                }"></ClientSideEvents>--%>
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupElementID="cmdSave" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYes" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No"  Width="120px">
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

                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgView"  ForeColor="Red" ></dx:ASPxLabel>
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgView"  ForeColor="blue" ></dx:ASPxLabel>


                                            <dx:ASPxTextBox runat="server" AutoPostBack="true" ClientInstanceName="txtSalesViewSalesID" ClientVisible="False" ID="txtSalesViewSalesID"></dx:ASPxTextBox>
                                         
                                            <dx:ASPxSpinEdit ID="txtSalesViewTotalAmount" runat="server" ClientVisible="False" AllowMouseWheel="False" ClientEnabled="False" ClientInstanceName="txtSalesViewTotalAmount" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="100px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                    </dx:ASPxSpinEdit>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>



            <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_POSSales_SearchPendingByUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePrint" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PrinterSetup ORDER BY PrinterTypeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePaymentMode" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PaymentMode WHERE PaymentModeID>0 ORDER BY PaymentModeID"></asp:SqlDataSource>
           
<%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


