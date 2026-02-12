<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="items.aspx.vb" Inherits="PetroTraderPro.items" %>

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
            popupAdd.Show();
        };
        function get_edit_focused_row() {
            GridViewItems.GetRowValues(GridViewItems.GetFocusedRowIndex(), 'ItemID;ItemTypeID;CategoryID;ItemCode;ItemName;UPC;ItemDescription;UM;RetailPrice;CostPrice;ReorderLevel;Discontinued;Produced', OnGetRowValues);
        };
        function OnGetRowValues(values) {
            if (values == null) { return; };
            if (values[0] == null) { return; };

            txtItemID.SetValue(values[0]);
            cboItemTypeEdit.SetValue(values[1]);
            cboCategotyEdit.SetValue(values[2]);
            txtItemNameEdit.SetText(values[4]);
            txtBarcodeEdit.SetText(values[5]);
            txtDescriptionEdit.SetText(values[6]);
            cboUnitEdit.SetText(values[7]);
            txtRetailPriceEdit.SetValue(values[8]);
            txtCostPriceEdit.SetValue(values[9]);
            txtReQuantityEdit.SetValue(values[10]);
            chkProducedEdit.SetChecked(values[11]);
             popupEdit.Show();
        };

        function get_del_focused_row() {
            GridViewItems.GetRowValues(GridViewItems.GetFocusedRowIndex(), 'ItemID;ItemName', on_get_delete_row);
        };
        function on_get_delete_row(values) {

            txtItemIDDelete.SetValue(values[0]);
            lblItemDelete.SetText(values[1]);

            PopupConfirmDelete.Show();
        };

        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
        };

        function SetTarget() {
            document.forms[0].target = "_blank";
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">ITEMS</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New Item" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Edit" Text="Edit" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/edit-20.png" />
            </dx:MenuItem>
            <dx:MenuItem Name="Delete" Text="Delete" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/Delete.png" Height="20" />
            </dx:MenuItem>
            <dx:MenuItem Name="Print" Text="Print" Alignment="Right" AdaptivePriority="2">
                <Image Url="../img/print-20.png" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewItems" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewItems" DataSourceID="SqlDataSourceItems" Width="100%" KeyFieldName="ItemID">
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
                                <dx:GridViewDataTextColumn FieldName="ItemTypeName" VisibleIndex="2" Caption="Type" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CategoryCode" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1" Caption="Category" Width="50px">
                                    <PropertiesTextEdit>
                                        <Style Wrap="True">
                                        </Style>
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemID" ReadOnly="True" VisibleIndex="6" Visible="False">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemTypeID" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemCode" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemName" VisibleIndex="0" Width="150px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UPC" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ItemDescription" VisibleIndex="4" Caption="Descrition" Width="100px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="RetailPrice" VisibleIndex="11" Width="50px">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CostPrice" VisibleIndex="12" Width="50px">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ReorderLevel" VisibleIndex="13" Width="50px"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn FieldName="Discontinued" VisibleIndex="15" Width="50px"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn FieldName="Produced" VisibleIndex="14" Width="50px"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn FieldName="UM" VisibleIndex="3" Width="50px"></dx:GridViewDataTextColumn>
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
    <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New Item"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <ClientSideEvents PopUp="function(s, e) {
	 txtItemNameAdd.SetText (&quot;&quot;);
        cboUnitAdd.SetSelectedIndex (-1);
        cboCategotyAdd.SetSelectedIndex (-1);
        txtDescriptionAdd.SetText (&quot;&quot;);
        cboItemTypeAdd.SetSelectedIndex (-1);
        txtBarcodeAdd.SetText (&quot;&quot;);
        cboUnitAdd.SetSelectedIndex (-1);
        cboUnitAdd.SetSelectedIndex (-1);
        cboUnitAdd.SetSelectedIndex (-1);
        txtRetailPriceAdd.SetText (0);
        txtCostPriceAdd.SetText (0);
        txtReQuantityAdd.SetText (0);
        chkProducedAdd.SetChecked(false);
         GenerateTransCode();

}"></ClientSideEvents>

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Item Name" ColSpan="4" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtItemNameAdd" ClientInstanceName="txtItemNameAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Unit" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboUnitAdd" runat="server" ClientInstanceName="cboUnitAdd" DataSourceID="SqlDataSourceUM" ValueField="UM" TextField="UM" DropDownStyle="DropDown">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Category" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboCategotyAdd" runat="server" ClientInstanceName="cboCategotyAdd" DataSourceID="SqlDataSourceCategory" ValueType="System.Int32" ValueField="CategoryID" TextField="CategoryName">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="4" Caption="Description" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" ID="txtDescriptionAdd" ClientInstanceName="txtDescriptionAdd" Height="40px" Width="100%"></dx:ASPxMemo>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Item Type" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboItemTypeAdd" runat="server" ClientInstanceName="cboItemTypeAdd" DataSourceID="SqlDataSourceItemType" ValueType="System.Int32" ValueField="ItemTypeID" TextField="ItemTypeName">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Barcode" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtBarcodeAdd" runat="server" ClientInstanceName="txtBarcodeAdd" Width="100%"></dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Retail Price" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtRetailPriceAdd" Font-Bold="True" ForeColor="#0D6B68" ID="txtRetailPriceAdd">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                        <ClientSideEvents GotFocus="function(s, e) { if (txtRetailPriceAdd.GetValue() == 0)  txtRetailPriceAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtRetailPriceAdd.GetText() == &#39;&#39;)  txtRetailPriceAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxSpinEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Cost Price" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.###0" ClientInstanceName="txtCostPriceAdd" Font-Bold="True" ForeColor="#0D6B68" ID="txtCostPriceAdd">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                        <ClientSideEvents GotFocus="function(s, e) { if (txtCostPriceAdd.GetValue() == 0)  txtCostPriceAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCostPriceAdd.GetText() == &#39;&#39;)  txtCostPriceAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                    </dx:ASPxSpinEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ColSpan="2" Caption="Reorder Qty">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="txtReQuantityAdd" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtReQuantityAdd" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                        <SpinButtons ShowIncrementButtons="False">
                                        </SpinButtons>
                                        <ClientSideEvents GotFocus="function(s, e) { if (txtReQuantityAdd.GetValue() == 0)  txtReQuantityAdd.SetText('');}" LostFocus="function(s, e) { if (txtReQuantityAdd.GetText() == '')  txtReQuantityAdd.SetText('0');}" />
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Produed">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxCheckBox ID="chkProducedAdd" runat="server" ClientInstanceName="chkProducedAdd"></dx:ASPxCheckBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton ID="cmdSubmitAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px">
                                                </dx:ASPxButton>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="cmdRefreshAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                    <ClientSideEvents Click="function(s, e) {
                                                    txtItemNameAdd.SetText (&amp;quot;&amp;quot;);
                                                    cboUnitAdd.SetSelectedIndex (-1);
                                                    cboCategotyAdd.SetSelectedIndex (-1);
                                                    txtDescriptionAdd.SetText (&amp;quot;&amp;quot;);
                                                    cboItemTypeAdd.SetSelectedIndex (-1);
                                                    txtBarcodeAdd.SetText (&amp;quot;&amp;quot;);
                                                    cboUnitAdd.SetSelectedIndex (-1);
                                                    cboUnitAdd.SetSelectedIndex (-1);
                                                    cboUnitAdd.SetSelectedIndex (-1);
                                                    txtRetailPriceAdd.SetText (0);
                                                    txtCostPriceAdd.SetText (0);
                                                    txtReQuantityAdd.SetText (0);
                                                    chkProducedAdd.SetChecked(false);
                                                    GenerateTransCode();
                                            }"></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl ID="PopupConfirmSaveAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupElementID="cmdSubmitAdd" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
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
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
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


    <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEdit" CloseAction="CloseButton" HeaderText="Edit Item"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" Width="100%" ColCount="4" ColumnCount="4">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="Item Name" ColSpan="4" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtItemNameEdit" ClientInstanceName="txtItemNameEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Unit" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboUnitEdit" runat="server" ClientInstanceName="cboUnitEdit" DataSourceID="SqlDataSourceUM" ValueField="UM" TextField="UM" DropDownStyle="DropDown">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Category" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboCategotyEdit" runat="server" ClientInstanceName="cboCategotyEdit" DataSourceID="SqlDataSourceCategory" ValueType="System.Int32" ValueField="CategoryID" TextField="CategoryName">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="4" Caption="Description" ColumnSpan="4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo runat="server" ID="txtDescriptionEdit" ClientInstanceName="txtDescriptionEdit" Height="40px" Width="100%"></dx:ASPxMemo>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Item Type" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cboItemTypeEdit" runat="server" ClientInstanceName="cboItemTypeEdit" DataSourceID="SqlDataSourceItemType" ValueType="System.Int32" ValueField="ItemTypeID" TextField="ItemTypeName">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Barcode" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtBarcodeEdit" runat="server" ClientInstanceName="txtBarcodeEdit" Width="100%"></dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Retail Price" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtRetailPriceEdit" Font-Bold="True" ForeColor="#0D6B68" ID="txtRetailPriceEdit">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                        <ClientSideEvents GotFocus="function(s, e) { if (txtRetailPriceEdit.GetValue() == 0)  txtRetailPriceEdit.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtRetailPriceEdit.GetText() == &#39;&#39;)  txtRetailPriceEdit.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxSpinEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Cost Price" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.###0" ClientInstanceName="txtCostPriceEdit" Font-Bold="True" ForeColor="#0D6B68" ID="txtCostPriceEdit">
                                        <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                        <ClientSideEvents GotFocus="function(s, e) { if (txtCostPriceEdit.GetValue() == 0)  txtCostPriceEdit.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCostPriceEdit.GetText() == &#39;&#39;)  txtCostPriceEdit.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                    </dx:ASPxSpinEdit>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ColSpan="2" Caption="Reorder Qty">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="txtReQuantityEdit" runat="server" Number="0" AllowMouseWheel="False" ClientInstanceName="txtReQuantityEdit" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Width="150px" Font-Bold="True" ForeColor="#0D6B68">
                                        <SpinButtons ShowIncrementButtons="False">
                                        </SpinButtons>
                                        <ClientSideEvents GotFocus="function(s, e) { if (txtReQuantityEdit.GetValue() == 0)  txtReQuantityEdit.SetText('');}" LostFocus="function(s, e) { if (txtReQuantityEdit.GetText() == '')  txtReQuantityEdit.SetText('0');}" />
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" Caption="Produed">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxCheckBox ID="chkProducedEdit" runat="server" ClientInstanceName="chkProducedEdit"></dx:ASPxCheckBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton ID="cmdSubmitEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Edit" Width="120px">
                                                </dx:ASPxButton>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="cmdRefreshEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                    <ClientSideEvents Click="function(s, e) {
                                                txtItemID.SetValue(0);
                                                txtItemNameEdit.SetText(&quot;&quot;);
                                                txtItemNameEdit.SetText(&quot;&quot;);
                                                cboUnitEdit.SetSelectedIndex (-1);
                                                cboCategotyEdit.SetSelectedIndex (-1);
                                                txtDescriptionEdit.SetText(&quot;&quot;);
                                                cboItemTypeEdit.SetSelectedIndex (-1);
                                                txtBarcodeEdit.SetText(&quot;&quot;);
                                                cboUnitEdit.SetSelectedIndex (-1);
                                                cboUnitEdit.SetSelectedIndex (-1);
                                                cboUnitEdit.SetSelectedIndex (-1);
                                                txtRetailPriceEdit.SetText (0);
                                                txtCostPriceEdit.SetText (0);
                                                txtReQuantityEdit.SetText (0);
                                                chkProducedEdit.SetChecked(false);
                                                get_edit_focused_row();
                                                lblErrMsgAdd.SetText(&quot;&quot;);
                                                lblSuccessMsgAdd.SetText(&quot;&quot;);
                                                lblErrMsgAdd.SetVisible (false);
                                                lblSuccessMsgAdd..SetVisible (false);
                                                }
                                                "></ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl ID="PopupConfirmSaveEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupElementID="cmdSubmitEdit" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout ID="ASPxFormLayout8" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveYesEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
                                                                    </dx:ASPxButton>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveNoEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No"  Width="120px">
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
                        <dx:LayoutItem ColSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                   <dx:ASPxLabel ID="lblErrMsgEdit" runat="server" ClientInstanceName="lblErrMsgEdit" ForeColor="Red" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEdit" runat="server" ClientInstanceName="lblSuccessMsgEdit" ForeColor="Blue" Font-Bold="true" ClientVisible="False"></dx:ASPxLabel>
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
                                    <dx:ASPxLabel runat="server" ID="lblItemDelete" ClientInstanceName="lblItemDelete" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxLabel>
                                    <dx:ASPxTextBox runat="server" ID="txtItemIDDelete" ClientInstanceName="txtItemIDDelete" ClientVisible="false" ForeColor="#0033CC" Font-Bold="True"></dx:ASPxTextBox>
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
                                    <dx:ASPxButton ID="cmdDeleteNo" runat="server" Text="No" Width="120px" ValidationGroup="Delete" AutoPostBack="False" >
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

    <dx:ASPxPopupControl ID="PopupConfirmPrint" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmPrint" CloseAction="None" HeaderText="Print Item List" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" >
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="" ShowCaption="False" HorizontalAlign="Center" ColSpan="2" ColumnSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton  ID="cmdPrintYes" runat="server"  Text="No" ValidationGroup="Print" Width="120px">
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

    <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="Usp_POSItems_GetAll" SelectCommandType="StoredProcedure">
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceUM" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT UM FROM POSItems GROUP BY UM HAVING(UM <> N'') ORDER BY UM"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceCategory" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM POSItemCategory WHERE CategoryID>0 ORDER BY CategoryName"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceItemType" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM POSItemType WHERE ItemTypeID>0 ORDER BY ItemTypeName"></asp:SqlDataSource>

</asp:Content>

