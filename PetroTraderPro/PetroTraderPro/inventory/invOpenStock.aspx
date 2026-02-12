<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="invOpenStock.aspx.vb" Inherits="PetroTraderPro.invOpenStock" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">

        //function getCustomButtonClick(s, e) {
        //    //alert('Selected Row Index is ' + e.visibleIndex);
        //    if (e.buttonID === "cmdDelete") {
        //        GridViewStock.GetRowValues(e.visibleIndex, 'StockID;ItemName', getClientRowValues);
        //    };

        //};

        //function OnClientFocusedRowChanged() {
        //    GridViewStock.GetRowValues(GridViewStock.GetFocusedRowIndex(), 'StockID;ItemName', getClientRowValues);
        //};
        //function getClientRowValues(values) {
        //    txtItemIDDelete.SetValue(values[0]);
        //    lblItemDelete.SetText(values[1]);
        //    PopupConfirmDelete.Hide();
        //};

    </script>

</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
    <div style="height: 10px"></div>
    <div style="font-size: x-large; color: #0D6B68; text-align: center; font-family: Arial, Helvetica, sans-serif; font-weight: bold;">OPENING STOCK </div>

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
                                <dx:ASPxButton ID="cmdAddNew" runat="server" Text="Add New" Width="100px" AutoPostBack="False" ClientSideEvents-Click="popupStock.Show();">
                                    <ClientSideEvents Click="function(s, e) {popupStock.Show();}"></ClientSideEvents>
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutGroup ColCount="4" ColSpan="1" ColumnCount="4" ShowCaption="False">
                        <Items>
                            <dx:LayoutItem Caption="Site" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cboSite" runat="server" AutoPostBack="true" ClientInstanceName="cboSite" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                            <ClientSideEvents ValueChanged="function(s, e) {txtSiteID.SetText(cboSite.GetValue());}"></ClientSideEvents>
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0"></asp:SqlDataSource>
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%">
                <Items>
                    <dx:LayoutItem ShowCaption="False" ColSpan="1" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridView ID="GridViewStock" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewStock" DataSourceID="SqlDataSourceStock" Width="100%" KeyFieldName="StockID">
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
                                    <%--                                    <ClientSideEvents CustomButtonClick="getCustomButtonClick" />--%>
                                    <Columns>
                                        <dx:GridViewCommandColumn VisibleIndex="0" ButtonRenderMode="Button" ButtonType="Button" Width="30px">
                                            <CustomButtons>
                                                <dx:GridViewCommandColumnCustomButton ID="cmdDelete" Text=" " Image-ToolTip="Delete Stock">
                                                    <Image Url="../img/Delete.png" Height="16px"></Image>
                                                    <Styles>
                                                        <Style Width="10px" BackColor="White"></Style>
                                                    </Styles>
                                                </dx:GridViewCommandColumnCustomButton>
                                            </CustomButtons>
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="4" Caption="Category" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemTypeName" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemTypeID" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemCode" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemName" VisibleIndex="1" Width="100px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="UM" VisibleIndex="2" Caption="Unit" Width="30px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="StockID" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="StockDate" VisibleIndex="5" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="ItemID" ReadOnly="True" VisibleIndex="11" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" VisibleIndex="12" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="ExpiryDate" VisibleIndex="16" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MM-yyyy"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="BatchNumber" VisibleIndex="17" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Stock" VisibleIndex="13" Width="40px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CurrentStock" VisibleIndex="18" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="RetailPrice" VisibleIndex="19" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CostPrice" VisibleIndex="20" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CreatedDate" VisibleIndex="15" Width="50px">
                                            <PropertiesDateEdit DisplayFormatString="dd-MM-yyyy HH:mm:ss"></PropertiesDateEdit>
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="24" Visible="False"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="0" Caption="Site" Width="50px"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreatedByName" VisibleIndex="14" Caption="Created By" Width="50px"></dx:GridViewDataTextColumn>
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
            <dx:ASPxPopupControl ID="popupStock" runat="server" AllowDragging="True" ClientInstanceName="popupStock" CloseAction="CloseButton" HeaderText="Add New Stock"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {
                                                    cboItem.SetSelectedIndex (-1);
                                                    dtpExpDate.SetText (&quot;&quot;);
                                                    txtBatchNumber.SetText (&quot;&quot;);
                                                    txtQtyInStock.SetValue (0);
	
                                    }"></ClientSideEvents>

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
                                            <dx:ASPxDateEdit ID="dtpStockDate" runat="server" ClientInstanceName="dtpStockDate" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboSite1" runat="server" AutoPostBack="true" ClientInstanceName="cboSite1" DataSourceID="SqlDataSourceSite1" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                <ClientSideEvents ValueChanged="function(s, e) {cboItem.SetSelectedIndex(-1);}"></ClientSideEvents>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource ID="SqlDataSourceSite1" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0"></asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" Caption="Item" ColumnSpan="3">
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
                                                    <dx:ListBoxColumn ClientVisible="False" FieldName="CostPrice">
                                                    </dx:ListBoxColumn>
                                                </Columns>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceItems" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="Usp_POSOpenStock_LoadUnEnteredBySiteID" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="cboSite1" Name="SiteID" PropertyName="Value" Type="Int32" DefaultValue="0" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton runat="server" Text="Add" Width="120px" ID="ASPxButton1">
                                                <Image Url="~/img/add-100.png"></Image>
                                            </dx:ASPxButton>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Batch No." ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtBatchNumber" ClientInstanceName="txtBatchNumber"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Exp. Date" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit runat="server" ID="dtpExpDate" ClientInstanceName="dtpExpDate" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy"></dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" Caption="Quantity" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtQtyInStock" Font-Bold="True" ForeColor="#0D6B68" ID="txtQtyInStock">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtQtyInStock.GetValue() == 0)  txtQtyInStock.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtQtyInStock.GetText() == &#39;&#39;)  txtQtyInStock.SetText(&#39;0&#39;);}"></ClientSideEvents>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxSpinEdit>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
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
                                                    dtpStockDate.SetText (&quot;&quot;);
                                                    cboSite1.SetSelectedIndex (-1);
                                                    cboItem.SetSelectedIndex (-1);
                                                    dtpExpDate.SetText (&quot;&quot;);
                                                    txtBatchNumber.SetText (&quot;&quot;);
                                                    txtQtyInStock.SetValue (0);

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
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" ColCount="2" ColumnCount="2" Width="100%">
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
                                            <dx:ASPxButton ID="cmdDeleteNo" runat="server" Text="No" Width="120px" ValidationGroup="Delete" AutoPostBack="False">
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

            <dx:ASPxTextBox ID="txtSiteID" runat="server" ClientVisible="false" ClientInstanceName="txtSiteID" Text="0">
            </dx:ASPxTextBox>
            <asp:SqlDataSource ID="SqlDataSourceStock" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_POSOpenStock] WHERE ([SiteID] = @SiteID) ORDER BY CreatedDate DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteID" Name="SiteID" PropertyName="Text" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


