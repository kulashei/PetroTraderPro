<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="supPayment.aspx.vb" Inherits="PetroTraderPro.supPayment" %>


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
                popupAddPayment.Show();
                txtPaymentDetails.SetReadOnly(true);
            };
        };

        function get_new_form() {
            popupAdd.Show();
        };
        function get_View_focused_row() {
            GridViewPayment.GetRowValues(GridViewPayment.GetFocusedRowIndex(), 'PaymentID;SiteName;SupplierCode;SupplierName;PaymentReceiptNo;PaymentDate;Details;PaymentMode;AccountCode;PaymentDetails;Amount', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { Cancel; };
            if (values[0] == null) { Cancel; };
            EmptyView();

            txtViewPaymentID.SetText(values[0]);
            txtViewSite.SetText(values[1]);
            txtViewDate.SetText(values[5]);
            txtViewSupplier.SetText(values[2]);
            txtViewDetails.SetText(values[6]);
            txtViewPaymentMode.SetText(values[7]);
            txtViewAccount.SetText(values[8]);
            txtViewPaymentDetails.SetText(values[9]);
            txtViewAmountPaid.SetText(values[10]);
            popupView.Show();
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
            var totalPayment = parseFloat(cpSummary());
            var Bal = AmountPaind - totalPayment;
            txtBalance.SetValue(Bal);

        }

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };


        function LoadPaymentCancel(s, e) {
            txtPaymentCancelSite.SetText("");
            txtPaymentCancelReceiptNo.SetText("");
            txtAmountCanceled.SetText("");
            txtRetrunRemark.SetText("");


            txtPaymentCancelSite.SetText(txtViewSite.GetText());
            txtPaymentCancelReceiptNo.SetText(txtViewSupplier.GetText());
            txtAmountCanceled.SetText(txtViewAmountPaid.GetValue());
            txtRetrunRemark.SetText("");
            popupCancelPayment.Show();
        }

        function paymentMode(s, e) {
            if (cboPaymentModeAdd.GetValue() == 1) {
                txtPaymentDetailsAdd.SetText("CASH");
                txtPaymentDetailsAdd.SetReadOnly(true);
            }
            else if (cboPaymentModeAdd.GetValue() != 1) {
                txtPaymentDetailsAdd.SetText("");
                txtPaymentDetailsAdd.SetReadOnly(false);
            }

        }


        function EmptyView() {
            txtViewPaymentID.SetText("");
            txtViewSite.SetText("");
            txtViewDate.SetText("");
            txtViewSupplier.SetText("");
            txtViewDetails.SetText("");
            txtViewPaymentMode.SetText("");
            txtViewAccount.SetText("");
            txtViewPaymentDetails.SetText("");
            txtViewAmountPaid.SetText("");


        }

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

        function OnDeleteSave(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmDelete.Show();
            }
        };

            function getCustomButtonClick(s, e) {
                if (e.buttonID === "View") {
                    GridViewPayment.GetRowValues(e.visibleIndex, 'AccountName;SiteCode;SiteName;PaymentMode;SupplierCode;SupplierName;CreatedByUser;PaymentID;PaymentCode;PaymentReceiptNo;PaymentDate;SiteID;SupplierID;AccountID;Details;PaymentModeID;PaymentDetails;Amount', getEditRowValues);
                };

            };

            function OnEditFocusedRowChanged() {
                GridViewPayment.GetRowValues(GridViewPayment.GetFocusedRowIndex(), 'AccountName;SiteCode;SiteName;PaymentMode;SupplierCode;SupplierName;CreatedByUser;PaymentID;PaymentCode;PaymentReceiptNo;PaymentDate;SiteID;SupplierID;AccountID;Details;PaymentModeID;PaymentDetails;Amount', getEditRowValues);
            };
            function getEditRowValues(values) {
                EmptyView();

                txtViewPaymentID.SetText(values[0]);
                txtViewSite.SetText(values[1]);
                txtViewDate.SetText(values[5]);
                txtViewSupplier.SetText(values[2]);
                txtViewDetails.SetText(values[6]);
                txtViewPaymentMode.SetText(values[7]);
                txtViewAccount.SetText(values[8]);
                txtViewPaymentDetails.SetText(values[9]);
                txtViewAmountPaid.SetText(values[10]);
                popupView.Show();




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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Supplier Payments</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Add Payment" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
<%--            <dx:MenuItem Name="View" Text="View Payment" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/view-20.png" />
            </dx:MenuItem>--%>
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
                        <dx:ASPxButton runat="server" ID="cmdSearcByDate" Text="Search By Date" Width="150px"></dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" ID="cmdViewPaymentReport" Text="View Report" Width="150px">
                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:EmptyLayoutItem ColSpan="1"></dx:EmptyLayoutItem>
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
                                <dx:ASPxGridView ID="GridViewPayment" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewPayment" DataSourceID="SqlDataSourcePayment" Width="100%" KeyFieldName="PaymentID">
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
<%--                                    <ClientSideEvents CustomButtonClick="getCustomButtonClick" />--%>

                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="PaymentID" VisibleIndex="0" Caption=" " Width="40px">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="cmdViewPayment" runat="server" OnClick="cmdViewPayment_Click"
                                                    Text="View" Theme="SoftOrange" Width="100%">
                                                    <Image Url="../img/view-20.png" Height="16px"></Image>
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentMode" VisibleIndex="2" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierCode" VisibleIndex="3" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierName" VisibleIndex="1" Caption="Supplier" Width="80px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountCode" VisibleIndex="4" Caption="Account" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountName" VisibleIndex="5" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentID" VisibleIndex="6" ReadOnly="True" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentCode" VisibleIndex="7" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="PaymentDate" VisibleIndex="0" Caption="Date" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                            </PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="8" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentModeID" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="AccountID" VisibleIndex="10" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentDetails" VisibleIndex="11" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TransactionNumber" VisibleIndex="12" Caption="Transaction No." Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="13" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                            </PropertiesTextEdit>
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

            <dx:ASPxPopupControl ID="popupAddPayment" runat="server" AllowDragging="True" ClientInstanceName="popupAddPayment" CloseAction="CloseButton" HeaderText="Add Payment" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="6" ColumnCount="6">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpPaymentDateAdd" runat="server" ClientInstanceName="dtpPaymentDateAdd" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy" Width="200px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="3" Caption="Supplier" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceSuppliers" TextField="SupplierName" ValueField="SupplierID"  ClientInstanceName="cboSupplierAdd" ID="cboSupplierAdd">

                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>

                                <dx:LayoutItem Caption="Payment Mode" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboPaymentModeAdd" runat="server" ClientInstanceName="cboPaymentModeAdd" DataSourceID="SqlDataSourcePaymentMode" TextField="PaymentMode" ValueField="PaymentModeID" ValueType="System.Int32" SelectedIndex="0" ClientSideEvents-ValueChanged="paymentMode">
                                                <ClientSideEvents ValueChanged="paymentMode" />
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" Caption="Account" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboAccountAdd" runat="server" ClientInstanceName="cboAccountAdd" DataSourceID="SqlDataSourceAccount" TextField="AccountCode" ValueField="AccountID" ValueType="System.Int32">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" Caption="Payment For">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtDetailsAdd" runat="server" ClientInstanceName="txtDetailsAdd">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxMemo>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment Details" ColSpan="3" ColumnSpan="3">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtPaymentDetailsAdd" runat="server" ClientInstanceName="txtPaymentDetailsAdd" Width="100%">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Amount Paid" ColSpan="3" ColumnSpan="3">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxSpinEdit ID="txtAmountPaidAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountPaidAdd" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                        <SpinButtons ShowIncrementButtons="False">
                                                        </SpinButtons>
                                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmountPaidAdd.GetValue() == 0)  txtAmountPaidAdd.SetText('');}" LostFocus="function(s, e) { if (txtAmountPaidAdd.GetText() == '')  txtAmountPaidAdd.SetText('0');}" NumberChanged="CalculateBalance" ValueChanged="CalculateBalance" />
                                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxSpinEdit>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                            <CaptionStyle ForeColor="Black">
                                            </CaptionStyle>
                                        </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="3" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveAdd(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
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
                                                                            <dx:ASPxButton ID="cmdSaveNoAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No"  Width="120px">
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
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption="False" ColumnSpan="4">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtTransactionCode" ClientInstanceName="txtTransactionCode" ClientVisible="false"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>




            <dx:ASPxPopupControl ID="popupView" runat="server" AllowDragging="True" ClientInstanceName="popupView" CloseAction="CloseButton" HeaderText="View Payment" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" ColCount="6" ColumnCount="6" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup Caption="" ColCount="4" ColSpan="6" ColumnCount="4" ColumnSpan="6" ShowCaption="False">
                                    <Items>
                                        <dx:EmptyLayoutItem ColSpan="1" HorizontalAlign="Center">
                                        </dx:EmptyLayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdEdit" runat="server" Text="Edit" Width="150px" BackColor="#FF9900">
                                                        <Image Url="../img/print-20.png" Width="16px">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdDelete" runat="server" AutoPostBack="False" Text="Delete" Width="150px" BackColor="Red">
                                                            <ClientSideEvents Click="function(s,e){ OnDeleteSave(s,e);}"></ClientSideEvents>
                                                        <Image Url="../img/remove-20.png" Width="16px">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:EmptyLayoutItem ColSpan="1" HorizontalAlign="Center">
                                        </dx:EmptyLayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtViewDate" runat="server" ClientInstanceName="txtViewDate" ClientReadOnly="True" DisplayFormatString="dd-MMM-yyyy" Font-Bold="True" ForeColor="#0D6B68" Width="200px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Supplier" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtViewSupplier" runat="server" ClientInstanceName="txtViewSupplier" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                 <dx:LayoutItem Caption="Payment Mode" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtViewPaymentMode" runat="server" ClientInstanceName="txtViewPaymentMode" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="200px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                     <CaptionStyle ForeColor="Black">
                                     </CaptionStyle>
                                </dx:LayoutItem>
                                   <dx:LayoutItem Caption="Account" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtViewAccount" runat="server" ClientInstanceName="txtViewAccount" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="200px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                       <CaptionStyle ForeColor="Black">
                                       </CaptionStyle>
                                   </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment For" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtViewDetails" runat="server" ClientInstanceName="txtViewDetails" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="100%">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment Details" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtViewPaymentDetails" runat="server" ClientInstanceName="txtViewPaymentDetails" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount Paid" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtViewAmountPaid" runat="server" AllowMouseWheel="False" ClientInstanceName="txtViewAmountPaid" ClientReadOnly="True" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <asp:Label ID="lblErrMsgAddView" runat="server" CssClass="dxe-day-has-appointments" ForeColor="Red" Visible="False"></asp:Label>
                                            <asp:Label ID="lblSuccessMsgAddView" runat="server" Font-Bold="True" ForeColor="Blue" Visible="False"></asp:Label>
                                            <dx:ASPxTextBox ID="txtViewPaymentID" runat="server" ClientInstanceName="txtViewPaymentID" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtViewTransactionCode" runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>



            <dx:ASPxPopupControl ID="popupEditPayment" runat="server" AllowDragging="True" ClientInstanceName="popupEditPayment" CloseAction="CloseButton" HeaderText="Edit Payment" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout8" runat="server" ColCount="6" ColumnCount="6" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpPaymentDateEdit" runat="server" ClientInstanceName="dtpPaymentDateEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy" Width="200px">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Supplier" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSupplierEdit" runat="server" ClientInstanceName="cboSupplierEdit" DataSourceID="SqlDataSourceSuppliers" TextField="SupplierName" ValueField="SupplierID" ValueType="System.Int32">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment Mode" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboPaymentModeEdit" runat="server" ClientInstanceName="cboPaymentModeEdit" ClientSideEvents-ValueChanged="paymentMode" DataSourceID="SqlDataSourcePaymentMode" TextField="PaymentMode" ValueField="PaymentModeID" ValueType="System.Int32">
                                                <ClientSideEvents ValueChanged="paymentMode" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Account" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboAccountEdit" runat="server" ClientInstanceName="cboAccountEdit" DataSourceID="SqlDataSourceAccount" TextField="AccountCode" ValueField="AccountID" ValueType="System.Int32">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment For" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtDetailsEdit" runat="server" ClientInstanceName="txtDetailsEdit">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment Details" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPaymentDetailsEdit" runat="server" ClientInstanceName="txtPaymentDetailsEdit" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount Paid" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountPaidEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountPaidEdit" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmountPaidEdit.GetValue() == 0)  txtAmountPaidEdit.SetText('');}" LostFocus="function(s, e) { if (txtAmountPaidEdit.GetText() == '')  txtAmountPaidEdit.SetText('0');}" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Edit" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {
                                                    dtpStockDate.SetText (&quot;&quot;);
                                                    cboSite1.SetSelectedIndex (-1);
                                                    cboItem.SetSelectedIndex (-1);
                                                    dtpExpDate.SetText (&quot;&quot;);
                                                    txtBatchNumber.SetText (&quot;&quot;);
                                                    txtQtyInStock.SetValue (0);

                                                }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout9" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
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
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ColumnSpan="4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtPaymentIDEdit" runat="server" ClientInstanceName="txtPaymentIDEdit" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>




            <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Do you want to Delete the Payment?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" ColCount="2" ColumnCount="2" Width="100%">
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgDelete" runat="server" ClientVisible="False" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgDelete" runat="server" ClientVisible="False" ForeColor="blue">
                                            </dx:ASPxLabel>
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

            <asp:SqlDataSource ID="SqlDataSourcePayment" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_SupplierPayments_SearchByDate" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" DefaultValue="01-01-1900" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01-01-1900" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePaymentMode" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PaymentMode WHERE PaymentModeID>0 ORDER BY PaymentModeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceAccount" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM Accounts WHERE AccountID>0 ORDER BY AccountID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceSuppliers" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [Suppliers] WHERE SupplierID>0 ORDER BY [SupplierName]">
            </asp:SqlDataSource>

            <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


