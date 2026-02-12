<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="stockTransfer.aspx.vb" Inherits="PetroTraderPro.stockTransfer" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">

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
    </script>

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <div style="height: 20px"></div>
    <div style="font-size: x-large; color: #0D6B68; text-align: center; font-family: Arial, Helvetica, sans-serif; font-weight: bold;">SALES </div>

    <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="Callback1">
    </dx:ASPxCallback>
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit">
            <GridSettings StretchLastItem="True">
            </GridSettings>
        </SettingsAdaptivity>
        <Items>
            <dx:LayoutGroup Caption="" ColSpan="1">
                <Items>
                    <dx:LayoutItem ColSpan="1" ShowCaption="False" Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="cmdAddNew" runat="server" Text="Add New" Width="100px" AutoPostBack="False">
                                </dx:ASPxButton>
                                <dx:ASPxPopupControl ID="popupSelect" runat="server" AllowDragging="True" ClientInstanceName="popupAddSales" CloseAction="CloseButton" HeaderText="Make Sales"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1100px">
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
                                                                <dx:ASPxDateEdit ID="ASPxFormLayout3_E2" runat="server">
                                                                </dx:ASPxDateEdit>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Printer" ColSpan="3" ColumnSpan="3">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox ID="ASPxComboBox2" runat="server">
                                                                </dx:ASPxComboBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="3" Caption="From" ColumnSpan="3">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox ID="cboSite" runat="server" AutoPostBack="True" ClientInstanceName="cboSite" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                                </dx:ASPxComboBox>
                                                                <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID&gt;0" ID="SqlDataSourceSites"></asp:SqlDataSource>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="3" Caption="To" ColumnSpan="3">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox ID="ASPxComboBox1" runat="server">
                                                                </dx:ASPxComboBox>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Qty In Stock" ShowCaption="True">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="100px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtQtyInStock" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68" ID="txtQtyInStock">
                                                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                                                <ClientSideEvents NumberChanged="CalculateAmount" GotFocus="function(s, e) { if (txtQtyInStock.GetValue() == 0)  txtQtyInStock.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQtyInStock.GetText() == &#39;&#39;)  txtQtyInStock.SetText(&#39;0&#39;);}" ValueChanged="CalculateAmount"></ClientSideEvents>

                                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="BinAdd"></ValidationSettings>
                                                                            </dx:ASPxSpinEdit>

                                                                        </td>
                                                                        <td>Qty Remaining</td>
                                                                        <td>
                                                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="100px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtQtyRemainig" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68" ID="txtQtyRemainig">
                                                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                                                <ClientSideEvents NumberChanged="CalculateAmount" GotFocus="function(s, e) { if (txtQtyRemainig.GetValue() == 0)  txtQtyRemainig.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQtyRemainig.GetText() == &#39;&#39;)  txtQtyRemainig.SetText(&#39;0&#39;);}" ValueChanged="CalculateAmount"></ClientSideEvents>

                                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="BinAdd"></ValidationSettings>
                                                                            </dx:ASPxSpinEdit>

                                                                        </td>
                                                                    </tr>
                                                                </table>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem ColSpan="3" ColumnSpan="3" Caption="Qty In Stock" ShowCaption="True">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="100px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtQtyInStock" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68" ID="ASPxSpinEdit1">
                                                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                                                <ClientSideEvents NumberChanged="CalculateAmount" GotFocus="function(s, e) { if (txtQtyInStock.GetValue() == 0)  txtQtyInStock.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQtyInStock.GetText() == &#39;&#39;)  txtQtyInStock.SetText(&#39;0&#39;);}" ValueChanged="CalculateAmount"></ClientSideEvents>

                                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="BinAdd"></ValidationSettings>
                                                                            </dx:ASPxSpinEdit>

                                                                        </td>
                                                                        <td>Qty Remaining</td>
                                                                        <td>
                                                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="100px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtQtyRemainig" ClientEnabled="False" Font-Bold="True" ForeColor="#0D6B68" ID="ASPxSpinEdit2">
                                                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                                                <ClientSideEvents NumberChanged="CalculateAmount" GotFocus="function(s, e) { if (txtQtyRemainig.GetValue() == 0)  txtQtyRemainig.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQtyRemainig.GetText() == &#39;&#39;)  txtQtyRemainig.SetText(&#39;0&#39;);}" ValueChanged="CalculateAmount"></ClientSideEvents>

                                                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="BinAdd"></ValidationSettings>
                                                                            </dx:ASPxSpinEdit>

                                                                        </td>
                                                                    </tr>
                                                                </table>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem ColSpan="2" ColumnSpan="3" Caption="Item">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox runat="server" ValueType="System.Int32" NullValueItemDisplayText=" {1}" DataSourceID="SqlDataSourceItems" TextField="ItemName" ValueField="ItemID" TextFormatString=" {1}" ClientInstanceName="cboItem" ID="cboItem">
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="ItemID" ClientVisible="False"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="ItemName" Width="70%"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="RetailPrice" Width="30%"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="CurrentStock" ClientVisible="False"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="CostPrice" ClientVisible="False"></dx:ListBoxColumn>
                                                                    </Columns>
                                                                </dx:ASPxComboBox>

                                                                <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [ItemID], [ItemName], [RetailPrice], [CostPrice], [CurrentStock] FROM [View_POSOpenStock] WHERE ([SiteID] = @SiteID) ORDER BY [ItemName]" ID="SqlDataSourceItems">
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
                                                                <dx:ASPxSpinEdit ID="txtQuantity" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtQuantity" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                                                    <SpinButtons ShowIncrementButtons="False">
                                                                    </SpinButtons>
                                                                    <ClientSideEvents GotFocus="function(s, e) { if (txtQuantity.GetValue() == 0)  txtQuantity.SetText('');}" LostFocus="function(s, e) { if (txtQuantity.GetText() == '')  txtQuantity.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                                                        <RequiredField IsRequired="True" />
                                                                    </ValidationSettings>
                                                                </dx:ASPxSpinEdit>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" Caption=". " ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton ID="ASPxFormLayout3_E9" runat="server" AutoPostBack="False" Text="Add" Width="120px">
                                                                    <Image Url="~/img/add-100.png">
                                                                    </Image>
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="6" ColumnSpan="6" ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <%--                                                                        <table>
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>No</th>
                                                                                    <th>ItemID</th>
                                                                                    <th>ItemName</th>
                                                                                    <th>Unit</th>
                                                                                    <th>Quantity</th>
                                                                                    <th>UnitPrice</th>
                                                                                    <th>Amount</th>
                                                                                    <th>remove</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody id="tbody"></tbody>
                                                                        </table>--%>

                                                                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" Width="100%" EnableTheming="True" Theme="Youthful">
                                                                    <SettingsPager Mode="ShowAllRecords">
                                                                    </SettingsPager>
                                                                    <Settings ShowFooter="True" VerticalScrollableHeight="150" VerticalScrollBarMode="Visible" />
                                                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                    <SettingsPopup>
                                                                        <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                                    </SettingsPopup>
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn FieldName="NCount" VisibleIndex="0" Width="40px"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="ItemID" Visible="False" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="ItemName" VisibleIndex="2" Width="250px"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="3" Width="50px"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="5" Width="50px"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="Amount" VisibleIndex="6" Width="80px"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="Unit" VisibleIndex="4" Width="50px"></dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                    <TotalSummary>
                                                                        <dx:ASPxSummaryItem FieldName="Amount" SummaryType="Sum" />
                                                                    </TotalSummary>
                                                                </dx:ASPxGridView>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutGroup ColCount="4" ColSpan="5" ColumnCount="4" ColumnSpan="5" ShowCaption="False">
                                                        <Items>
                                                            <dx:LayoutItem Caption="Requested by" ColSpan="2" ColumnSpan="2">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Received by" ColSpan="2" ColumnSpan="2">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Driver's Name" ColSpan="2" ColumnSpan="2">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Vehicle No." ColSpan="2" ColumnSpan="2">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxTextBox ID="ASPxTextBox4" runat="server" Width="100%">
                                                                        </dx:ASPxTextBox>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                        </Items>
                                                    </dx:LayoutGroup>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton ID="ASPxFormLayout3_E17" runat="server" Text="Save" Width="120px">
                                                                    <Image Url="~/img/save-30.png" Width="20px">
                                                                    </Image>
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
                    <dx:LayoutGroup ColCount="4" ColSpan="1" ColumnCount="4" ShowCaption="False">
                        <Items>
                            <dx:LayoutItem Caption="From" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxDateEdit ID="dtpSearchDateFrom" runat="server" ClientInstanceName="dtpSearchDateFrom" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                            <ClientSideEvents DateChanged="function(s, e) { txtSearchDateFrom.SetText(moment(dtpSearchDateFrom.GetDate()).format(&#39;DD-MMM-YYYY&#39;));}"></ClientSideEvents>
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="To" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxDateEdit ID="dtpSearchDateTo" runat="server" ClientInstanceName="dtpSearchDateTo" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                            <ClientSideEvents DateChanged="function(s, e) { txtSearchDateTo.SetText(moment(dtpSearchDateTo.GetDate()).format(&#39;DD-MMM-YYYY&#39;));}"></ClientSideEvents>
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxButton ID="cmdSearch" runat="server" Width="120px" Text="Search">
                                        </dx:ASPxButton>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewSales" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" DataSourceID="SqlDataSourceSales" Width="100%" KeyFieldName="SalesCode">
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
                                <dx:GridViewDataTextColumn FieldName="SalesCode" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="SalesDate" VisibleIndex="2"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="TransactionTypeID" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="4" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="7"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PaymentMode" VisibleIndex="10"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="11" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="8"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TransactionType" VisibleIndex="6"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TotalAmount" VisibleIndex="12">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CashPaid" VisibleIndex="16" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Change" ShowInCustomizationForm="True" Visible="False" VisibleIndex="17">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Balance" ShowInCustomizationForm="True" VisibleIndex="14">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Payment" ShowInCustomizationForm="True" VisibleIndex="13">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TotalSales" ShowInCustomizationForm="True" Visible="False" VisibleIndex="18">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PaymentStatus" VisibleIndex="19" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="PaymentDate" VisibleIndex="20" Visible="False"></dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="ReceivedBy" VisibleIndex="21" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PaymentModeID" VisibleIndex="22" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PaymentDetails" VisibleIndex="23" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemReceivedBy" VisibleIndex="24" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ReceivedByPhoneNumber" VisibleIndex="25" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ReceivedByVehicleNumber" VisibleIndex="26" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Canceled" VisibleIndex="27" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CreatedByName" VisibleIndex="15"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PaymentReceivedBy" VisibleIndex="28" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Paid" VisibleIndex="29" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="30" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CanceledBy" ShowInCustomizationForm="True" Visible="False" VisibleIndex="31"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CanceledByName" ShowInCustomizationForm="True" Visible="False" VisibleIndex="32"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataHyperLinkColumn Caption="Receipt No." FieldName="SalesReceiptNo" ShowInCustomizationForm="True" VisibleIndex="0">
                                </dx:GridViewDataHyperLinkColumn>
                            </Columns>

                            <Styles>
                                <HeaderPanel Font-Bold="True">
                                </HeaderPanel>
                            </Styles>
                        </dx:ASPxGridView>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutGroup ShowCaption="False" ColSpan="1" ColCount="2" ColumnCount="2">
                <Items>
                    <dx:LayoutItem ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="ASPxFormLayout2_E4"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxTextBox ID="txtSearchDateFrom" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateFrom">
    </dx:ASPxTextBox>

    <dx:ASPxTextBox ID="txtSearchDateTo" runat="server" ClientVisible="false" ClientInstanceName="txtSearchDateTo">
    </dx:ASPxTextBox>

    <dx:ASPxTextBox ID="txtSearchType" runat="server" ClientVisible="false" ClientInstanceName="txtSearchType">
    </dx:ASPxTextBox>

    <asp:SqlDataSource ID="SqlDataSourceSales" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_POSSalesSummary_SearchByDate" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearchDateFrom" Name="DateFrom" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txtSearchDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

