<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="cusRpts.aspx.vb" Inherits="PetroTraderPro.cusRpts" %>


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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Customer Reports</h1>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>


</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" ColCount="4" ColumnCount="4" Width="100%">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
        </SettingsAdaptivity>
        <Items>
            <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False" HorizontalAlign="Center">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="700px" HeaderText="">

                            <PanelCollection>
                                <dx:PanelContent runat="server">

                                    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" ColCount="3" ColumnCount="3">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
                                        </SettingsAdaptivity>

                                        <Items>
                                            <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                                <Items>
                                                    <dx:LayoutItem Caption="From" ColSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateFrom" ID="dtpDateFrom">
                                                                </dx:ASPxDateEdit>



                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="To" ColSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateTo" ID="dtpDateTo">
                                                                </dx:ASPxDateEdit>


                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Customer" ColSpan="2" ColumnSpan="2">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxGridLookup ID="GridLookupCustomersAdd" runat="server" ClientInstanceName="GridLookupCustomersAdd" KeyFieldName="CustomerID" DataSourceID="SqlDataSourceCustomers" AutoGenerateColumns="False" TextFormatString=" {4}-{5}" Width="100%">
                                                                    <GridViewProperties>
                                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>

                                                                        <Settings HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" AutoFilterCondition="Contains" VerticalScrollableHeight="400"></Settings>

                                                                        <SettingsPopup>
                                                                            <FilterControl AutoUpdatePosition="False"></FilterControl>
                                                                        </SettingsPopup>
                                                                    </GridViewProperties>

                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerType" VisibleIndex="1" Width="20%"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerSites" VisibleIndex="4" Caption="Site" Width="15%"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerID" VisibleIndex="5" ReadOnly="True" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerTypeID" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="7" Width="15%"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="0" Width="40%"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CustomerAddress" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="PhoneNumber2" VisibleIndex="10" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="EmailAddress" VisibleIndex="11" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CreditLimit" VisibleIndex="13" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="CreditPeriod" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="18" Width="10%"></dx:GridViewDataTextColumn>
                                                                    </Columns>


                                                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Statement">
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </dx:ASPxGridLookup>


                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdFuelCredit" Text="Fuel Credit" Width="170px" ClientInstanceName="cmdFuelCredit">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdLubeCredit" Text="Lube Credit" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdCustomerPayments" Text="Customer Paments" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdDebitCredit" Text="Debit/Ctedit Notes" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdCustomerStatement" Text="Customer Statement" Width="170px" ValidationGroup="Statement">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdCustomerBalance" Text="Customer Balance" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdDebtors" Text="Debtors" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdCreditors" Text="Creditors" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdRefresh" Text="Refresh" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
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



    <asp:SqlDataSource runat="server" ID="SqlDataSourceCustomers" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_Customers] ORDER BY [CompanyName]">
    </asp:SqlDataSource>


    <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
    <%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>


