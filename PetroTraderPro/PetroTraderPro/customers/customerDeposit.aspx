<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="customerDeposit.aspx.vb" Inherits="PetroTraderPro.customerDeposit" %>

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
            grid.GetRowValues(e.visibleIndex, 'ItemID;RetailPrice', getClientRowValues);

        };

        function OnClientFocusedRowChanged() {
            var grid = GridLookupItems.GetGridView();
            grid.GetRowValues(grid.GetFocusedRowIndex(), 'ItemID;RetailPrice', getClientRowValues);
        };
        function getClientRowValues(values) {
            txtUnitPrice.SetValue(0);
            //txtBatchNumber.SetText("");
            //txtExpiryDate.SetText("");
            //txtQuantity.SetValue(0);

            txtUnitPrice.SetValue(values[1]);
            //txtBatchNumber.SetText(values[5]);
            //txtExpiryDate.SetText(values[6]);

            CalculateAmount();
        };

        function CalculateAmount(s, e) {
            var Qty = parseFloat(txtQuantity.GetValue());
            var price = parseFloat(txtUnitPrice.GetValue());
            var amount = Qty * price;
            txtAmount.SetValue(amount);

        }

        function AddListItems(s, e) {
            var fName = firstName.GetValue();
            var lName = lastName.GetValue();
            firstName.SetText('');
            lastName.SetText('');
            var FullName = new Array(fName, lName);
            comboBox.AddItem(FullName);
        }

        function OnSave(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAdd.Show();
            }
        };

        function OnSaveCancel(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmCancel.Show();
            }
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

        function LoadSalesCancel(s, e) {
            txtSalesCancelSite.SetText("");
            txtSalesCancelReceiptNo.SetText("");
            txtAmountCanceled.SetText("");
            txtRetrunRemark.SetText("");

            txtSalesCancelSite.SetValue(txtSalesViewSite.GetText());
            txtSalesCancelReceiptNo.SetValue(txtSalesViewReceiptNo.GetText());
            txtAmountCanceled.SetValue(txtSalesViewTotalAmount.GetValue());

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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Customer Deposit</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Add Deposit" Alignment="Right" AdaptivePriority="2">
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
                        <dx:ASPxButton runat="server" ID="cmdSearcByDate" Text="Search By Date" Width="150px"></dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:EmptyLayoutItem ColSpan="1"></dx:EmptyLayoutItem>
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
                                <dx:ASPxGridView ID="GridViewSales" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" DataSourceID="SqlDataSourceSales" Width="100%" KeyFieldName="SalesID" EnableCallBacks="false">
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


<%--                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="0" Caption=" " Width="40px">
                                            <DataItemTemplate>
                                                <dx:ASPxButton ID="cmdViewSales" runat="server" OnClick="cmdViewSales_Click"
                                                    Text="View" Theme="SoftOrange" Width="100%">
                                                    <Image Url="../img/view-20.png" Height="16px">  </Image>
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>--%>
                                        <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="4" Caption="Customer" Width="80px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="8" Caption="Site" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="9" ReadOnly="True" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesReceiptNo" VisibleIndex="2" Caption="Receipt No." Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesCode" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="SalesDate" VisibleIndex="1" Caption="Date" Width="40px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="12" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="13" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TotalAmount" VisibleIndex="15" Visible="False">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Canceled" VisibleIndex="27" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CanceledDate" VisibleIndex="28" Visible="False"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CancelRemark" VisibleIndex="29" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CanceledBy" VisibleIndex="30" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CanceledRegDate" VisibleIndex="31" Visible="False"></dx:GridViewDataDateColumn>

                                        <dx:GridViewDataTextColumn FieldName="TotalSales" VisibleIndex="14" Caption="Amount" Width="40px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PaymentMode" VisibleIndex="33" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreatedByUser" Width="50px" Caption="Created By" VisibleIndex="32"></dx:GridViewDataTextColumn>
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
            <dx:ASPxPopupControl ID="popupAddSales" runat="server" AllowDragging="True" ClientInstanceName="popupAddSales" CloseAction="CloseButton" HeaderText="Customer Deposit"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px" Modal="True">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="6" ColumnCount="6" BackColor="#AEE3B1">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpSalesDate" runat="server" ClientInstanceName="dtpSalesDate" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy" Width="200px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" Caption="Site" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSite" runat="server"  ClientInstanceName="cboSite" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                <ClientSideEvents ValueChanged="function(s, e) {GridLookupItems.SetValue(0);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID&gt;0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName" ID="SqlDataSourceSites">
                                                <SelectParameters>
                                                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" Caption="Customer" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridLookup ID="GridLookupCustomers" runat="server"  ClientInstanceName="GridLookupCustomers" KeyFieldName="CustomerID" DataSourceID="SqlDataSourceCustomers" AutoGenerateColumns="False" TextFormatString="{7}- {6}" Width="100%" >
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                                    <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                    <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" AutoFilterCondition="Contains"></Settings>

                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                    </SettingsPopup>
                                                </GridViewProperties>

                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerType" VisibleIndex="1" Width="20%"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="TransactionType" VisibleIndex="2" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="3" Visible="False">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="4" Caption="Site" Width="15%"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="5" ReadOnly="True" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerTypeID" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="7" Width="15%"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="0" Width="40%"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="PhoneNumber2" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="11" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="12" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CreditLimit" VisibleIndex="13" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CreditPeriod" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="18" Width="10%"></dx:GridViewDataTextColumn>
                                                </Columns>


                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="3" Caption="Item">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridLookup runat="server" KeyFieldName="ItemID" DataSourceID="SqlDataSourceItems" AutoGenerateColumns="False" TextFormatString="{1}" Width="100%" ClientInstanceName="GridLookupItems" ID="GridLookupItems">
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                                    <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                    <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible"></Settings>

                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                    </SettingsPopup>
                                                </GridViewProperties>
                                                <ClientSideEvents RowClick="getCustomButtonClick" ValueChanged="getCustomButtonClick" />
                                                <GridViewClientSideEvents RowFocusing="getCustomButtonClick"></GridViewClientSideEvents>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="ItemID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ItemName" ShowInCustomizationForm="True" Width="60%" Caption="Item" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="RetailPrice" ShowInCustomizationForm="True" Width="30%" Caption="Price" VisibleIndex="3">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CostPrice" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="UM" ShowInCustomizationForm="True" Width="20%" Caption="Unit" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                </Columns>


                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>

                                            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT ItemID, ItemName, RetailPrice, CostPrice,  UM FROM View_POSItems ORDER BY ItemName" ID="SqlDataSourceItems">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Quantity">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtQuantity" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantity" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtQuantity.GetValue() == 0)  txtQuantity.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQuantity.GetText() == &#39;&#39;)  txtQuantity.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Unit Price">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtUnitPrice" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPrice" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtUnitPrice.GetValue() == 0)  txtUnitPrice.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtUnitPrice.GetText() == &#39;&#39;)  txtUnitPrice.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Amount">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientReadOnly="True" ClientInstanceName="txtAmount" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68" ID="txtAmount">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmount.GetValue() == 0)  txtAmount.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmount.GetText() == &#39;&#39;)  txtAmount.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption=". ">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" AutoPostBack="False" Text="Add" Width="120px" ID="cmdAddItem" ValidationGroup="Add">
                                                <Image Url="~/img/add-100.png"></Image>
                                            </dx:ASPxButton>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings Location="Top"></CaptionSettings>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientInstanceName="lblErrMsgItem" ClientVisible="False" ID="lblErrMsgItem" Style="color: #CC3300; font-weight: 700"></dx:ASPxLabel>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxGridView runat="server" AutoGenerateColumns="False" KeyFieldName="NCount" ClientInstanceName="GridViewTempSales" Theme="Youthful" Width="100%" EnableTheming="True" ID="GridViewTempSales">
                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                <Settings ShowFooter="True" VerticalScrollableHeight="150" VerticalScrollBarMode="Visible"></Settings>

                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                                <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False"></SettingsDataSecurity>

                                                <SettingsPopup>
                                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                </SettingsPopup>
                                                <Columns>
                                                    <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" Width="30px" VisibleIndex="0">
                                                        <CustomButtons>
                                                            <dx:GridViewCommandColumnCustomButton ID="cmdRemove" Text=" ">
                                                                <Image Height="16px" Url="../img/Delete.png"></Image>
                                                            </dx:GridViewCommandColumnCustomButton>
                                                        </CustomButtons>
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataTextColumn FieldName="NCount" ShowInCustomizationForm="True" Width="40px" Caption="No." Visible="False" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ItemID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ItemName" ShowInCustomizationForm="True" Width="250px" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Quantity" ShowInCustomizationForm="True" Width="50px" VisibleIndex="5">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                                            <Style HorizontalAlign="Center"></Style>
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="UnitPrice" ShowInCustomizationForm="True" Width="50px" VisibleIndex="6">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Amount" ShowInCustomizationForm="True" Width="80px" VisibleIndex="7">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="UM" ShowInCustomizationForm="True" Width="50px" Caption="Unit" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                                </Columns>
                                                <TotalSummary>
                                                    <dx:ASPxSummaryItem ShowInGroupFooterColumn="Amount" SummaryType="Sum" FieldName="Amount" DisplayFormat="Total: #,##0.#0"></dx:ASPxSummaryItem>
                                                    <dx:ASPxSummaryItem ShowInGroupFooterColumn="ItemName" SummaryType="Count" FieldName="ItemID" DisplayFormat="No of Items: #,##0"></dx:ASPxSummaryItem>
                                                </TotalSummary>

                                                <Styles>
                                                    <Footer Font-Bold="True" Font-Size="Larger" ForeColor="#0D6B68"></Footer>
                                                </Styles>
                                            </dx:ASPxGridView>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutGroup ColCount="6" ColSpan="6" ColumnCount="6" ColumnSpan="6" ShowCaption="False">
                                    <Items>
                                        <dx:LayoutItem Caption="Payment Mode" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxComboBox ID="cboPaymentMode" runat="server" AutoPostBack="true" ClientInstanceName="cboPaymentMode" DataSourceID="SqlDataSourcePaymentMode" TextField="PaymentMode" ValueField="PaymentModeID" ValueType="System.Int32" SelectedIndex="0" ClientSideEvents-ValueChanged="paymentMode">
                                                        <ClientSideEvents ValueChanged="paymentMode" />
                                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                            <RequiredField IsRequired="True"></RequiredField>
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Payment Details" ColSpan="3" ColumnSpan="3">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtPaymentDetails" runat="server" ClientInstanceName="txtPaymentDetails" Width="100%">
                                                    </dx:ASPxTextBox>
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
                                                        <dx:ASPxButton ID="cmdSubmitAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSave(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
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
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" ShowCaption="False" ColumnSpan="4">
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
                                                    <dx:ASPxButton ID="cmdViewReprint" runat="server" Text="Reprint Receipt" Width="150px">
                                                        <Image Url="../img/print-20.png" Width="16px">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxButton ID="cmdViewCancel" runat="server" AutoPostBack="False" Text="Reverse Payment" Width="150px">
                                                        <ClientSideEvents Click="LoadSalesCancel" />
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

                                <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
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
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceSalesView" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT CustomerDepositDetails.*,ROW_NUMBER() OVER(ORDER BY NCount) AS 'ItemNo'  FROM [CustomerDepositDetails] WHERE ([SalesID] = @SalesID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="txtSalesViewSalesID" PropertyName="Text" DefaultValue="0" Name="SalesID"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Pay Mode" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtSalesViewPaymentMode" runat="server" ClientInstanceName="txtSalesViewPaymentMode" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Payment Details" ColSpan="2" ColumnSpan="2">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <dx:ASPxTextBox ID="txtSalesViewPaymentDetails" runat="server" ClientInstanceName="txtSalesViewPaymentDetails" Width="100%" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                    </dx:ASPxTextBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgView"  ForeColor="Red" ></dx:ASPxLabel>
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgView"  ForeColor="blue" ></dx:ASPxLabel>

                                            <dx:ASPxTextBox runat="server" AutoPostBack="true" ClientInstanceName="txtSalesViewTransactionCode" ClientVisible="False" ID="txtSalesViewTransactionCode"></dx:ASPxTextBox>

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

            <dx:ASPxPopupControl ID="popupCancelSales" runat="server" AllowDragging="True" ClientInstanceName="popupCancelSales" CloseAction="CloseButton" HeaderText="Cancel Sales Receipt"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="Middle" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout5" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpSalesCanceledDate" runat="server" ClientInstanceName="dtpSalesCanceledDate" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Cancel">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="txtSalesCancelSite" ClientInstanceName="txtSalesCancelSite" ClientEnabled="false" ForeColor="#0D6B68" Font-Bold="true"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Receipt No." ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="txtSalesCancelReceiptNo" ClientInstanceName="txtSalesCancelReceiptNo" ClientEnabled="false" ForeColor="#0D6B68" Font-Bold="true"></dx:ASPxTextBox>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Total Amount" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtAmountCanceled" Font-Bold="True" ForeColor="#0D6B68" ID="txtAmountCanceled" ClientEnabled="false">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents  GotFocus="function(s, e) { if (txtAmountCanceled.GetValue() == 0)  txtAmountCanceled.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmountCanceled.GetText() == &#39;&#39;)  txtAmountCanceled.SetText(&#39;0&#39;);}" ></ClientSideEvents>

                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" ColumnSpan="4" Caption="Remark">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo runat="server" ID="txtRetrunRemark" ClientInstanceName="txtRetrunRemark">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Cancel">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxMemo>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Cancel" Width="120px" ID="cmdSubmitRetrun">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveCancel(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefresRetrun">
                                                            <ClientSideEvents Click="LoadSalesCancel"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                </tr>
                                            </table>

                                            <dx:ASPxPopupControl ID="PopupConfirmCancel" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmCancel" CloseAction="None" HeaderText="Do you want to Cancel Receipt?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" >
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdConfirmCancelYes" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmCancel.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdConfirmCancelNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No"  Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmCancel.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgCancel" ForeColor="Red"></dx:ASPxLabel>
                                                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgCancel" ForeColor="blue"></dx:ASPxLabel>
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
                                            <asp:Label runat="server" CssClass="dxe-day-has-appointments" ForeColor="Red" ID="Label1" Visible="False"></asp:Label>

                                            <asp:Label runat="server" Font-Bold="True" ForeColor="Blue" ID="Label2" Visible="False"></asp:Label>

                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="ASPxLabel2"></dx:ASPxLabel>

                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False" ID="ASPxTextBox2"></dx:ASPxTextBox>


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

            <dx:ASPxTextBox ID="txtSearchType" runat="server" ClientVisible="false" ClientInstanceName="txtSearchType">
            </dx:ASPxTextBox>

            <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_CustomerDeposit_SearchByDateByUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePrint" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PrinterSetup ORDER BY PrinterTypeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourcePaymentMode" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM PaymentMode WHERE PaymentModeID>0 ORDER BY PaymentModeID"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomers" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_Customers] WHERE SiteID IN (SELECT SiteID FROM UserSites WHERE UserID = @UserID) AND CustomerID>0 ORDER BY [CustomerName]">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="-1" Name="UserID"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
           
<%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>