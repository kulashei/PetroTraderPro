<%@ Page Title="" Language="vb" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="salespendingInvoices.aspx.vb" Inherits="PetroTraderPro.salespendingInvoices" %>
<%@ Register Assembly="DevExpress.XtraReports.v24.2.Web.WebForms, Version=24.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
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


<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
        <div style="height: 20px"></div>
    <div style="font-size: x-large; color: #0D6B68; text-align: center; font-family: Arial, Helvetica, sans-serif; font-weight: bold;">SALES </div>
<dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewSales" runat="server" AutoGenerateColumns="False" ClientInstanceName="gvModel" DataSourceID="SqlDataSourcePending" Width="100%" KeyFieldName="SalesCode">
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
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxPopupControl ID="popupSelect" runat="server" AllowDragging="True" ClientInstanceName="popupAddSales" CloseAction="CloseButton" HeaderText="Make Sales"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="1100px">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="6" ColumnCount="6">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Date" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="ASPxFormLayout3_E2" runat="server">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboSite" runat="server" AutoPostBack="true" ClientInstanceName="cboSite" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Printer" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="ASPxComboBox2" runat="server">
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Trans. Type" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server">
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="3" Caption="Customer" ColumnSpan="3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="ASPxFormLayout3_E3" runat="server">
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Add" Width="120px">
                                        <Image Url="~/img/add-100.png">
                                        </Image>
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Item" ColumnSpan="3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboItem" runat="server" ClientInstanceName="cboItem" DataSourceID="SqlDataSourceItems" NullValueItemDisplayText=" {1}" TextField="ItemName" TextFormatString=" {1}" ValueField="ItemID" ValueType="System.Int32">
                                        <Columns>
                                            <dx:ListBoxColumn ClientVisible="False" FieldName="ItemID">
                                            </dx:ListBoxColumn>
                                            <dx:ListBoxColumn FieldName="ItemName" Width="70%">
                                            </dx:ListBoxColumn>
                                            <dx:ListBoxColumn FieldName="RetailPrice" Width="30%">
                                            </dx:ListBoxColumn>
                                            <dx:ListBoxColumn ClientVisible="False" FieldName="CurrentStock">
                                            </dx:ListBoxColumn>
                                            <dx:ListBoxColumn ClientVisible="False" FieldName="CostPrice">
                                            </dx:ListBoxColumn>
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceItems" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT [ItemID], [ItemName], [RetailPrice], [CostPrice], [CurrentStock] FROM [View_POSOpenStock] WHERE ([SiteID] = @SiteID) ORDER BY [ItemName]">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ShowCaption="False" ColumnSpan="3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>Qty In Stock</td>
                                            <td>
                                                <dx:ASPxSpinEdit ID="txtQtyInStock" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtQtyInStock" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="100px" Font-Bold="True" ForeColor="#0D6B68" ClientEnabled="false">
                                                    <SpinButtons ShowIncrementButtons="False">
                                                    </SpinButtons>
                                                    <ClientSideEvents GotFocus="function(s, e) { if (txtQtyInStock.GetValue() == 0)  txtQtyInStock.SetText('');}" LostFocus="function(s, e) { if (txtQtyInStock.GetText() == '')  txtQtyInStock.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                                    </ValidationSettings>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                            <td>Qty Remaining</td>
                                            <td>
                                                <dx:ASPxSpinEdit ID="txtQtyRemainig" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtQtyRemainig" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="100px" Font-Bold="True" ForeColor="#0D6B68" ClientEnabled="false">
                                                    <SpinButtons ShowIncrementButtons="False">
                                                    </SpinButtons>
                                                    <ClientSideEvents GotFocus="function(s, e) { if (txtQtyRemainig.GetValue() == 0)  txtQtyRemainig.SetText('');}" LostFocus="function(s, e) { if (txtQtyRemainig.GetText() == '')  txtQtyRemainig.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                                    </ValidationSettings>
                                                </dx:ASPxSpinEdit>
                                            </td>
                                        </tr>
                                    </table>
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
                            <CaptionSettings Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" Caption="Unit Price">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="txtUnitPrice" runat="server" AllowMouseWheel="False" ClientInstanceName="txtUnitPrice" DisplayFormatString="#,##0.###0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                        <SpinButtons ShowIncrementButtons="False">
                                        </SpinButtons>
                                        <ClientSideEvents GotFocus="function(s, e) { if (txtUnitPrice.GetValue() == 0)  txtUnitPrice.SetText('');}" LostFocus="function(s, e) { if (txtUnitPrice.GetText() == '')  txtUnitPrice.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
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
                                    <dx:ASPxSpinEdit ID="txtAmount" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmount" ClientReadOnly="True" ClientEnabled="false" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                        <SpinButtons ShowIncrementButtons="False">
                                        </SpinButtons>
                                        <ClientSideEvents GotFocus="function(s, e) { if (txtAmount.GetValue() == 0)  txtAmount.SetText('');}" LostFocus="function(s, e) { if (txtAmount.GetText() == '')  txtAmount.SetText('0');}" />
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" Caption=". ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="ASPxFormLayout3_E9" runat="server" AutoPostBack="False" Text="Add" Width="120px">
                                        <Image Url="~/img/add-100.png">
                                        </Image>
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top" />
                        </dx:LayoutItem>
                        <dx:EmptyLayoutItem ColSpan="1">
                        </dx:EmptyLayoutItem>
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
                        <dx:LayoutGroup ColCount="4" ColSpan="4" ColumnCount="4" ColumnSpan="4" ShowCaption="False">
                            <Items>
                                <dx:LayoutItem Caption="Pay Mode" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="ASPxFormLayout3_E8" runat="server">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Payment Details" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount Paid" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtAmountPaind" runat="server" AllowMouseWheel="False" ClientInstanceName="txtAmountPaind" DisplayFormatString="#,##0.#0" Font-Bold="True" ForeColor="#0D6B68" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtAmountPaind.GetValue() == 0)  txtAmountPaind.SetText('');}" LostFocus="function(s, e) { if (txtAmountPaind.GetText() == '')  txtAmountPaind.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
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
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtBalance.GetValue() == 0)  txtBalance.SetText('');}" LostFocus="function(s, e) { if (txtBalance.GetText() == '')  txtBalance.SetText('0');}" NumberChanged="CalculateAmount" ValueChanged="CalculateAmount" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="BinAdd">
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>
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


    <asp:SqlDataSource ID="SqlDataSourcePending" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_POSSalesSummary_SearchpendingInvoice" SelectCommandType="StoredProcedure">
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

