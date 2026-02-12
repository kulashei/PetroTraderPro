<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="cusFuelSales.aspx.vb" Inherits="PetroTraderPro.cusFuelSales" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">
        function page_toolbar_item_clicked(itm) {
            if (itm == "New") {
                popupAddSales.Show();
                EmptyAdd();
                GenerateTransCode();
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
            var grid = GridLookupProductAdd.GetGridView();
            grid.GetRowValues(e.visibleIndex, 'ProductID;ProductCode;Rate;CostPrice', getClientRowValues);

        };


        function OnClientFocusedRowChanged() {
            var grid = GridLookupProductAdd.GetGridView();
            grid.GetRowValues(grid.GetFocusedRowIndex(), 'ProductID;ProductCode;Rate;CostPrice', getClientRowValues);
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

        };


        function EmptyAdd() {
        //    cboSiteAdd.SetSelectedIndex(-1);
        //    cboProductAdd.SetSelectedIndex(-1);
        //    txtOpenSalesAdd.SetValue(0);
        //    txtAmountAdd.SetValue(0);
        };
        function EmptyAdd1() {
            GridLookupProductAdd.SetText("");
            txtUnitPriceAdd.SetValue(0);
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
            txtAmountAddCanceled.SetText("");
            txtRetrunRemark.SetText("");

            txtSalesCancelSite.SetValue(txtSalesViewSite.GetText());
            txtSalesCancelReceiptNo.SetValue(txtSalesViewReceiptNo.GetText());
            txtAmountAddCanceled.SetValue(txtSalesViewTotalAmount.GetText());

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

        };


        function OnSaveAdd(s, e) {
            lblErrMsgAdd.SetVisible(false);
            lblErrMsgAdd.SetText("");
            lblSuccessMsgAdd.SetVisible(false);
            lblSuccessMsgAdd.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                var amnt = txtAmountAdd.GetValue();
                if (parseFloat(amnt) <= 0) { lblErrMsgAdd.SetVisible(true); lblErrMsgAdd.SetText('Please Enter the Amount'); txtAmountAdd.Focus(); return; };

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
                var amnt = txtAmountEdit.GetValue();
                if (parseFloat(amnt) <= 0) { lblErrMsgEdit.SetVisible(true); lblErrMsgEdit.SetText('Please Enter the Amount'); txtAmountEdit.Focus(); return; };

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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Fuel Credit Sales</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="Add Sales" Alignment="Right" AdaptivePriority="2">
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

            <dx:LayoutItem ColSpan="2" Caption="Site" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox runat="server" ID="cboSiteSearch" ClientInstanceName="cboSiteSearch"  DataSourceID="SqlDataSourceSearchSite" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">

                            <ClientSideEvents ValueChanged="function(s, e) {txtSiteSearch.SetValue(cboSiteSearch.GetValue());}"></ClientSideEvents>
                        </dx:ASPxComboBox>

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
                        <dx:ASPxButton runat="server" ID="cmdViewSalesReport" ClientInstanceName="cmdViewSalesReport" Text="Print Report" Width="120px">
                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
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
                                <dx:ASPxGridView ID="GridViewSales" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" Width="100%" DataSourceID="SqlDataSourceSales" KeyFieldName="SalesID" EnableCallBacks="false">
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
                                                    <Image Url="../img/view-20.png" Height="16px"></Image>
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataTextColumn>--%>
                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="5" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Caption="Site" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerTypeID" VisibleIndex="6" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="7" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="3" Caption="Customer" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="8" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="10" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="4" Caption="Product" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="11" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesCode" VisibleIndex="12" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="SalesDate" VisibleIndex="1" Caption="Date" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="13" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="14" Visible="False" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="15" Visible="False" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="VehicleNo" VisibleIndex="16" Width="50px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ReceiptNo" VisibleIndex="17" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="18" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="19" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.###0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="20" Width="50px">
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


            <dx:ASPxPopupControl ID="popupAddSales" runat="server" AllowDragging="True" ClientInstanceName="popupAddSales" CloseAction="CloseButton" HeaderText="Add Sales"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpSalesDateAdd" runat="server" ClientInstanceName="dtpSalesDateAdd" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteAdd" runat="server" AutoPostBack="true" ClientInstanceName="cboSiteAdd" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32" DataSourceID="SqlDataSourceSites">
                                                <ClientSideEvents ValueChanged="function(s, e) {EmptyAdd1(); }" />
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" Caption="Customer" ColumnSpan="4">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridLookup ID="GridLookUpCustomerAdd"  runat="server" ClientInstanceName="GridLookUpCustomerAdd" KeyFieldName="CustomerID" DataSourceID="SqlDataSourceCustomerAdd" AutoGenerateColumns="False" TextFormatString="{5}-{6}" Width="100%">
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
<%--                                                    <dx:GridViewDataTextColumn FieldName="TransactionType" VisibleIndex="2" Visible="False"></dx:GridViewDataTextColumn>--%>
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

                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomerAdd" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_CustomerSites] WHERE SiteID =@SiteID AND CustomerID>0 ORDER BY [CustomerName]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSiteAdd" PropertyName="Value" DefaultValue="-1" Name="SiteID"></asp:ControlParameter>

                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>

                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Product" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxGridLookup ID="GridLookupProductAdd" runat="server" AutoPostBack="true" ClientInstanceName="GridLookupProductAdd" Width="100%" KeyFieldName="ProductID" AutoGenerateColumns="False" TextFormatString="{1}" DataSourceID="SqlDataSourceProduct">
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                    <SettingsPager Mode="ShowAllRecords">
                                                    </SettingsPager>
                                                    <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" />
                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False">
                                                        </FilterControl>
                                                    </SettingsPopup>
                                                </GridViewProperties>

                                                <GridViewClientSideEvents RowFocusing="getCustomButtonClick" />
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" Visible="False" VisibleIndex="0"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ProductCode" Caption="Product" VisibleIndex="1" Width="250PX"></dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Rate" VisibleIndex="2" Width="120PX">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.###0"></PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CostPrice" Visible="False" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                </Columns>

                                                <%--                                                <ClientSideEvents RowClick="getCustomButtonClick" ValueChanged="getCustomButtonClick" />--%>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceProduct" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_FuelRate] WHERE ([SiteID] = @SiteID) ORDER BY [ProductName]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSiteAdd" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Unit Price" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.###0" ClientInstanceName="txtUnitPriceAdd" ID="txtUnitPriceAdd" ClientEnabled="false" BackColor="#CCCC00">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

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

                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" Caption="Vehicle No.">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtVehicleNumberAdd" runat="server" ClientInstanceName="txtVehicleNumberAdd" Width="100%">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" Caption="Receipt No.">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtReceiptNumberAdd" runat="server" ClientInstanceName="txtReceiptNumberAdd" Width="100%">
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Amount" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountAdd" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtAmountAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents  GotFocus="function(s, e) { if (txtAmountAdd.GetValue() == 0)  txtAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmountAdd.GetText() == &#39;&#39;)  txtAmountAdd.SetText(&#39;0&#39;);}" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                </ValidationSettings>
                                                <DisabledStyle ForeColor="Black">
                                                </DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2"></dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
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
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox runat="server" ID="txtTransactionCode" ClientInstanceName="txtTransactionCode" ClientVisible="false"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupViewSales" runat="server" AllowDragging="True" ClientInstanceName="popupViewSales" CloseAction="CloseButton" HeaderText="View Sales" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" ColCount="4" ColumnCount="4" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="4" ColSpan="4" ColumnCount="4" ColumnSpan="4" ShowCaption="False">
                                    <Items>
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
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSalesDateView" runat="server" ClientInstanceName="txtSalesDateView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                               <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameView" runat="server" ClientInstanceName="txtSiteNameView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Customer" ColSpan="4" ColumnSpan="4">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtCustomerView" runat="server" ClientInstanceName="txtCustomerView" ClientReadOnly="True" Font-Bold="True" ForeColor="#0D6B68" Width="100%" ClientEnabled="False">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtProductView" runat="server" ClientInstanceName="txtProductView" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Unit Price" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtUnitPriceView" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtUnitPriceView" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                </DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Vehicle No." ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtVehicleNumberView" runat="server" ClientInstanceName="txtVehicleNumberView" Width="100%" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Receipt No." ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtReceiptNumberView" runat="server" ClientInstanceName="txtReceiptNumberView" Width="100%" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                </DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgView" runat="server" ClientInstanceName="lblErrMsgView" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgView" runat="server" ClientInstanceName="lblSuccessMsgView" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtSalesIDView" runat="server" ClientInstanceName="txtSalesIDView" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupEditSales" runat="server" AllowDragging="True" ClientInstanceName="popupEditSales" CloseAction="CloseButton" HeaderText="Edit Sales" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout11" runat="server" ColCount="4" ColumnCount="4" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpSalesDateEdit" runat="server" ClientInstanceName="dtpSalesDateEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteEdit" runat="server" AutoPostBack="true" ClientInstanceName="cboSiteEdit" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Customer" ColSpan="4" ColumnSpan="4">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridLookup ID="GridLookUpCustomerEdit" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridLookUpCustomerEdit" DataSourceID="SqlDataSourceCustomerEdit" KeyFieldName="CustomerID" TextFormatString="{5}-{6}" Width="100%">
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                    <SettingsPager Mode="ShowAllRecords">
                                                    </SettingsPager>
                                                    <Settings AutoFilterCondition="Contains" HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" />
                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False">
                                                        </FilterControl>
                                                    </SettingsPopup>
                                                </GridViewProperties>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerType" VisibleIndex="1" Width="20%">
                                                    </dx:GridViewDataTextColumn>
<%--                                                    <dx:GridViewDataTextColumn FieldName="TransactionType" Visible="False" VisibleIndex="2">
                                                    </dx:GridViewDataTextColumn>--%>
                                                    <dx:GridViewDataTextColumn FieldName="SiteCode" Visible="False" VisibleIndex="3">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Site" FieldName="SiteName" VisibleIndex="4" Width="15%">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerID" ReadOnly="True" Visible="False" VisibleIndex="5">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerTypeID" Visible="False" VisibleIndex="6">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="7" Width="15%">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="0" Width="40%">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CustomerAddress" Visible="False" VisibleIndex="8">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="PhoneNumber1" Visible="False" VisibleIndex="9">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="PhoneNumber2" Visible="False" VisibleIndex="10">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="EmailAddress" Visible="False" VisibleIndex="11">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="SiteID" Visible="False" VisibleIndex="12">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CreditLimit" Visible="False" VisibleIndex="13">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CreditPeriod" Visible="False" VisibleIndex="14">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="18" Width="10%">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>

                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomerEdit" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_CustomerSites] WHERE SiteID =@SiteID AND CustomerID>0 ORDER BY [CustomerName]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSiteEdit" PropertyName="Value" DefaultValue="-1" Name="SiteID"></asp:ControlParameter>

                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxGridLookup ID="GridLookupProductEdit" runat="server" AutoGenerateColumns="False" AutoPostBack="true" ClientInstanceName="GridLookupProductEdit" DataSourceID="SqlDataSourceProductEdit" KeyFieldName="ProductID" TextFormatString="{1}" Width="100%">
                                                <GridViewProperties>
                                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                    <SettingsPager Mode="ShowAllRecords">
                                                    </SettingsPager>
                                                    <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" />
                                                    <SettingsPopup>
                                                        <FilterControl AutoUpdatePosition="False">
                                                        </FilterControl>
                                                    </SettingsPopup>
                                                </GridViewProperties>
                                                <GridViewClientSideEvents RowFocusing="getCustomButtonClick" />
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" Visible="False" VisibleIndex="0">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Caption="Product" FieldName="ProductCode" VisibleIndex="1" Width="250PX">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="Rate" VisibleIndex="2" Width="120PX">
                                                        <PropertiesTextEdit DisplayFormatString="#,##0.###0">
                                                        </PropertiesTextEdit>
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="CostPrice" Visible="False" VisibleIndex="3">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <%--                                                <ClientSideEvents RowClick="getCustomButtonClick" ValueChanged="getCustomButtonClick" />--%>
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxGridLookup>
                                            <asp:SqlDataSource ID="SqlDataSourceProductEdit" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_FuelRate] WHERE ([SiteID] = @SiteID) ORDER BY [ProductName]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSiteEdit" DefaultValue="0" Name="SiteID" PropertyName="Value" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Unit Price" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtUnitPriceEdit" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtUnitPriceEdit" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" BackColor="#CCCC00">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
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
                                <dx:LayoutItem Caption="Vehicle No." ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtVehicleNumberEdit" runat="server" ClientInstanceName="txtVehicleNumberEdit" Width="100%">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Receipt No." ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtReceiptNumberEdit" runat="server" ClientInstanceName="txtReceiptNumberEdit" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmountEdit.GetValue() == 0)  txtAmountEdit.SetText('');}" LostFocus="function(s, e) { if (txtAmountEdit.GetText() == '')  txtAmountEdit.SetText('0');}" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                </ValidationSettings>
                                                <DisabledStyle ForeColor="Black">
                                                </DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="2" ShowCaption="False">
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
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout12" runat="server" ColCount="2" ColumnCount="2" Width="100%">
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
                                            <dx:ASPxTextBox ID="txtSalesIDEdit" runat="server" ClientInstanceName="txtSalesIDEdit" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDEdit" runat="server" ClientInstanceName="txtSiteIDEdit" ClientVisible="false">
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
                                                <ClientSideEvents Click="function(s, e) {PopupErrMsg.Hide(); GridLookupProduct.SetValue (-1);}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="PopupConfirmDelete" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmDelete" CloseAction="None" HeaderText="Do you want to Delete the Sales?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" PopupElementID="cmdSubmitRetrun">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout9" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteYes" runat="server" BackColor="#FF3300" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteNo" runat="server" AutoPostBack="False"  Text="No"  Width="120px">
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

            <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_FuelCustomerSupply_SearchByDateByUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSiteSearch" Name="SiteID" PropertyName="Text" Type="Int32" DefaultValue="-1"/>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID,SiteCode, SiteName FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

<%--            <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomers" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_CustomerSites] WHERE SiteID IN (SELECT SiteID FROM UserSites WHERE UserID = @UserID) AND CustomerID>0 ORDER BY [CustomerName]">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="-1" Name="UserID"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>--%>
            <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


