<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="fuelCouponSales.aspx.vb" Inherits="PetroTraderPro.fuelCouponSales" %>


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

        function CalculateAmountAdd(s, e) {
            var Denomination = parseFloat(cboDenominationAdd.GetText());
            var Qty = parseFloat(txtQuantityAdd.GetValue());
            var amount = Qty * Denomination;
            txtAmountAdd.SetValue(amount);

        };
        function CalculateAmountEdit(s, e) {
            var Denomination = parseFloat(cboDenominationEdit.GetText());
            var Qty = parseFloat(txtQuantityEdit.GetValue());
            var amount = Qty * Denomination;
            txtAmountEdit.SetValue(amount);

        };


        function EmptyAdd() {
            var itmCont = cboSiteAdd.GetItemCount();
            if (itmCont > 1) {
                cboSiteAdd.SetSelectedIndex(-1);
            }
            cboDenominationAdd.SelectedIndex = -1
            txtQuantityAdd.SetValue(0);
            txtAmountAdd.SetValue(0);
            txtRemarkAdd.SetText("");

            GenerateTransCode();
        };
        function EmptyAdd1() {
            cboDenominationAdd.SelectedIndex = -1
            txtQuantityAdd.SetValue(0);
            txtAmountAdd.SetValue(0);
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Fuel Coupon Sales</h1>
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

                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="2" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesID" VisibleIndex="5" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SalesCode" VisibleIndex="6" Width="50px" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="SalesDate" VisibleIndex="0" Caption="Date" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="7" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Remark" VisibleIndex="19" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="13" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="1" Width="50px" Caption="Site"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="18" Width="50px">
                                            <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Denomination" VisibleIndex="11" Width="50px">
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
                        <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="6" ColumnCount="6">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
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
                                <dx:LayoutItem Caption="Site" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteAdd" runat="server"  ClientInstanceName="cboSiteAdd" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32" DataSourceID="SqlDataSourceSites">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Denomination" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboDenominationAdd" runat="server" ClientInstanceName="cboDenominationAdd" TextField="Denomination" ValueField="DenominationID" ValueType="System.Int32" DataSourceID="SqlDataSourceDenomination" TextFormatString="{2}" NullValueItemDisplayText="{2}">

                                                <ClientSideEvents ValueChanged="CalculateAmountAdd" TextChanged="CalculateAmountAdd"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Quantity" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0" ClientInstanceName="txtQuantityAdd" ID="txtQuantityAdd" >
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                <ClientSideEvents  GotFocus="function(s, e) { if (txtQuantityAdd.GetValue() == 0)  txtQuantityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQuantityAdd.GetText() == &#39;&#39;)  txtQuantityAdd.SetText(&#39;0&#39;);}" NumberChanged="CalculateAmountAdd"  ValueChanged="CalculateAmountAdd" ></ClientSideEvents>

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

                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" Caption="Amount">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtAmountAdd" ID="txtAmountAdd" ClientEnabled="false">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmountAdd.GetValue() == 0)  txtAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtAmountAdd.GetText() == &#39;&#39;)  txtAmountAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                                <DisabledStyle ForeColor="Black"></DisabledStyle>
                                            </dx:ASPxSpinEdit>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="6" ColumnSpan="6" Caption="Remark">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo runat="server" Height="71px" Width="100%" ClientInstanceName="txtRemarkAdd" ID="txtRemarkAdd">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ColumnSpan="3" ShowCaption="False">
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
                                <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAdd" runat="server" ClientInstanceName="lblErrMsgAdd" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxLabel ID="lblSuccessMsgAdd" runat="server" ClientInstanceName="lblSuccessMsgAdd" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>

                                            <dx:ASPxTextBox ID="txtTransactionCode" runat="server" ClientInstanceName="txtTransactionCode" ClientVisible="False">
                                            </dx:ASPxTextBox>

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
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" ColCount="6" ColumnCount="6" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutGroup ColCount="4" ColSpan="6" ColumnCount="4" ColumnSpan="6" ShowCaption="False">
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
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
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
                               <dx:LayoutItem Caption="Site" ColSpan="3" ColumnSpan="3">
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
                                <dx:LayoutItem Caption="Denomination" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtDenominationView" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtDenominationView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" Font-Bold="True" ForeColor="#0D6B68">
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
                                <dx:LayoutItem Caption="Quantity" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtQuantityView" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtQuantityView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" Font-Bold="True" ForeColor="#0D6B68">
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

                                <dx:LayoutItem Caption="Amount" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountView" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountView" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="120px" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68">
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
                                 <dx:LayoutItem ColSpan="6" ColumnSpan="6" Caption="Remark">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtRemarkView" runat="server" ClientInstanceName="txtRemarkView" Height="71px" Width="100%" ClientEnabled="true" Font-Bold="True" ForeColor="#0D6B68">
                                                <DisabledStyle ForeColor="#0D6B68" Font-Bold="True">
                                                </DisabledStyle>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
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
                        <dx:ASPxFormLayout ID="ASPxFormLayout11" runat="server" ColCount="6" ColumnCount="6" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Date" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpSalesDateEdit" runat="server" ClientInstanceName="dtpSalesDateEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="3" ColumnSpan="3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSiteEdit" runat="server" ClientInstanceName="cboSiteEdit" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Denomination" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboDenominationEdit" runat="server" ClientInstanceName="cboDenominationEdit" DataSourceID="SqlDataSourceDenomination" TextField="Denomination" TextFormatString="{2}" ValueField="DenominationID" ValueType="System.Int32">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Quantity" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtQuantityEdit" runat="server" AllowMouseWheel="False" ClientInstanceName="txtQuantityEdit" DisplayFormatString="#,##0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtQuantityEdit.GetValue() == 0)  txtQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtQuantityEdit.GetText() == '')  txtQuantityEdit.SetText('0');}" />
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
                                <dx:LayoutItem Caption="Amount" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountEdit" runat="server" AllowMouseWheel="False" ClientEnabled="false" ClientInstanceName="txtAmountEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmountEdit.GetValue() == 0)  txtAmountEdit.SetText('');}" LostFocus="function(s, e) { if (txtAmountEdit.GetText() == '')  txtAmountEdit.SetText('0');}" />
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
                                <dx:LayoutItem Caption="Remark" ColSpan="6" ColumnSpan="6">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtRemarkEdit" runat="server" ClientInstanceName="txtRemarkEdit" Height="71px" Width="100%">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionStyle Font-Bold="True" ForeColor="Black">
                                    </CaptionStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ColumnSpan="3" ShowCaption="False">
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
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtSalesIDEdit" runat="server" ClientInstanceName="txtSalesIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDEdit" runat="server" ClientInstanceName="txtSiteIDEdit" ClientVisible="False">
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
                                            <dx:ASPxButton ID="cmdConfirmDeleteYes" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {PopupConfirmDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmDeleteNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No"  Width="120px">
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

            <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_FuelCouponSales_SearchByDateByUser" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtSiteSearch" Name="SiteID" PropertyName="Text" Type="Int32" DefaultValue="-1"/>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceDenomination" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [FuelCoupons] WHERE ([Active] = 1) ORDER BY [Denomination]">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT SiteID,SiteCode, SiteName FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>

            <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


