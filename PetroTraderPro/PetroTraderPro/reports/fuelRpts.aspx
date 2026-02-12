<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="fuelRpts.aspx.vb" Inherits="PetroTraderPro.fuelRpts" %>

<%@ Register Assembly="DevExpress.XtraReports.v24.2.Web.WebForms, Version=24.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>


<asp:Content runat="server" ContentPlaceHolderID="Head">
    <script type="text/javascript">
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
                    <%--                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Fuel Sales Reports</h1>--%>
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
            <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" ColCount="4" ColumnCount="4" Width="100%">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
                </SettingsAdaptivity>
                <Items>
                    <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="600px" HeaderText="Fuel Sales Reports" HeaderStyle-ForeColor="#0D6B68" HeaderStyle-Font-Size="Large" HeaderStyle-Font-Bold="true">

                                    <PanelCollection>
                                        <dx:PanelContent runat="server">
                                        <dx:ASPxCallbackPanel ID="cbpLoadReport" runat="server" ClientInstanceName="cbpLoadReport" Height="2px" Width="100%" Styles-LoadingPanel-HorizontalAlign="Center" Styles-LoadingPanel-VerticalAlign="Middle">
                                            <SettingsLoadingPanel ImagePosition="Top" Text="Loading Report. Please Wait...." />
                                            <Styles>
                                                <LoadingPanel HorizontalAlign="Center" VerticalAlign="Middle">
                                                </LoadingPanel>
                                            </Styles>
                                            <LoadingPanelStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                            </LoadingPanelStyle>
                                            <SettingsAdaptivity CollapseAtWindowInnerWidth="700" />
                                            <PanelCollection>
                                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxCallbackPanel>
                                            <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" ColCount="3" ColumnCount="3">
                                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
                                                </SettingsAdaptivity>

                                                <Items>
                                                    <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                                        <Items>
                                                            <dx:LayoutItem Caption="From" ColSpan="1">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateFrom" ID="dtpDateFrom" Width="150px">
                                                                        </dx:ASPxDateEdit>



                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="To" ColSpan="1">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateTo" ID="dtpDateTo" Width="150px">
                                                                        </dx:ASPxDateEdit>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxComboBox runat="server" AutoPostBack="true" ValueType="System.Int32" DataSourceID="SqlDataSourceSearchSite" TextField="SiteName" ValueField="SiteID" ClientInstanceName="cboSite" ID="cboSite">
                                                                        </dx:ASPxComboBox>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                        </Items>
                                                    </dx:LayoutGroup>

                                                    <dx:LayoutGroup ColCount="2" ColumnCount="2" ShowCaption="False" ColSpan="3" ColumnSpan="3">
                                                        <Items>
                                                            <dx:LayoutItem ColSpan="1" Caption="Pump">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxComboBox ID="cboPump" runat="server" ClientInstanceName="cboPump" DataSourceID="SqlDataSourcePump" TextField="PumpCode" ValueField="PumpID" ValueType="System.Int32">
                                                                        </dx:ASPxComboBox>
                                                                        <asp:SqlDataSource runat="server" ID="SqlDataSourcePump" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_FuelPumpRate] WHERE ([SiteID] = @SiteID) ORDER BY [PumpCode]">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" Caption="Tank">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxComboBox ID="cboTank" runat="server" ClientInstanceName="cboTank" DataSourceID="SqlDataSourceTank" TextField="TankCode" ValueField="TankID" ValueType="System.Int32">
                                                                        </dx:ASPxComboBox>
                                                                        <asp:SqlDataSource ID="SqlDataSourceTank" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_FuelTanks WHERE ([SiteID] = @SiteID) ORDER BY ProductName,TankCode">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>


                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" Caption="Attendant">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxComboBox ID="cboAttendantAdd" runat="server" ClientInstanceName="cboAttendantAdd" TextField="AttendantName" ValueField="AttendantID" ValueType="System.Int32" DataSourceID="SqlDataSourceAttendants" TextFormatString="{1}">
                                                                            <Columns>
                                                                                <dx:ListBoxColumn FieldName="AttendantID" ClientVisible="False"></dx:ListBoxColumn>
                                                                                <dx:ListBoxColumn FieldName="AttendantName" Width="250px" Caption="Name"></dx:ListBoxColumn>
                                                                                <dx:ListBoxColumn FieldName="AttendantCode" Width="100px" Caption="Code"></dx:ListBoxColumn>
                                                                            </Columns>

                                                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                                <RequiredField IsRequired="True"></RequiredField>
                                                                            </ValidationSettings>
                                                                        </dx:ASPxComboBox>

                                                                        <asp:SqlDataSource runat="server" ID="SqlDataSourceAttendants" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [FuelAttendants]WHERE ([SiteID] = @SiteID) ORDER BY [AttendantName]">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>

                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" Caption="Product">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxComboBox ID="cboProduct" runat="server" ClientInstanceName="cboProduct" DataSourceID="SqlDataSourceSiteFuelProduct" TextField="ProductName" ValueField="SiteProductID" ValueType="System.Int32">
                                                                        </dx:ASPxComboBox>

                                                                        <asp:SqlDataSource ID="SqlDataSourceSiteFuelProduct" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_SiteFuelProducts] WHERE ([SiteID] = @SiteID) ORDER BY [ProductName]">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="cboSite" PropertyName="Value" DefaultValue="0" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>

                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                            </dx:LayoutItem>
                                                        </Items>
                                                    </dx:LayoutGroup>

                                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdSalesReport" ClientInstanceName="cmdSalesReport" Text="Sales Details" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdSalesAndStock" Text="Sales & Stock" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelGeneralsales" Text="General Sales" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelCustomerSupply" Text="Fuel Credit Sales" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelConsumption" Text="Fuel Consumption" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelSalesSummary" Text="Sales Summary" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdStockTransfer" Text="Fuel Transfer" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelStockSummary" Text="Stock Summary" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelReceipt" Text="Fuel Receipt" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdProfitandLoss" Text="Profit and Loss" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdCouponSales" Text="Coupon Sales" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdEPayment" Text="E-Payments" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdCustomerPayment" Text="Customer Payment" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdExpenditure" Text="Expenditure" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdBankDeposit" Text="Bank Deposit" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdFuelDailySummary" Text="Daily Summary" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton runat="server" ID="cmdAttendShortage" Text="Attend. Shortage" Width="150px">
                                                                     <ClientSideEvents Click="function(s, e) { cbpLoadReport.PerformCallback();}" />
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxButton ID="cmdRefresh" runat="server" BackColor="#003399" Text="Refresh" Width="150px">
                                                                </dx:ASPxButton>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:ASPxFormLayout>

                                        </dx:PanelContent>
                                    </PanelCollection>

                                </dx:ASPxRoundPanel>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:ASPxFormLayout>


            <asp:SqlDataSource ID="SqlDataSourceSearchSite" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID=0 OR SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
                <SelectParameters>
                    <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>


            <dx:ASPxPopupControl ID="PopupPrintReport" runat="server" AllowDragging="True" ClientInstanceName="PopupPrintReport" CloseAction="CloseButton" HeaderText="Payment Receipt" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="1000px" Height="600px"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" MaxWidth="700px" />

                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxWebDocumentViewer ID="rptViewerReport" runat="server" DisableHttpHandlerValidation="False" ClientInstanceName="rptViewerReceipt" Height="600px" ColorScheme="softblue">
                            <SettingsExport ShowPrintNotificationDialog="False" />
                            <SettingsTabPanel Position="Left" />
                            <ClientSideEvents Init="function(s, e) { s.GetReportPreview().zoom(0.8); s.previewModel.reportPreview.showMultipagePreview(true); }" />
                        </dx:ASPxWebDocumentViewer>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


