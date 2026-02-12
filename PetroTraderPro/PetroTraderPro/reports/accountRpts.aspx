<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="accountRpts.aspx.vb" Inherits="PetroTraderPro.accountRpts" %>


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
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
        </SettingsAdaptivity>
        <Items>
            <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False" HorizontalAlign="Center">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="">

                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="600px" ColCount="3" ColumnCount="3">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                                        </SettingsAdaptivity>

                                        <Items>
                                            <dx:LayoutGroup ColCount="2" ColumnCount="2" ColSpan="3" ColumnSpan="3" ShowCaption="False">
                                                <Items>
                                                    <dx:LayoutItem Caption="From" ColSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateFrom" ID="dtpDateFrom" Width="140px">
                                                                </dx:ASPxDateEdit>



                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="To" ColSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateTo" ID="dtpDateTo" Width="140px">
                                                                </dx:ASPxDateEdit>


                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="Account" ColSpan="2" ColumnSpan="2">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceAccount" TextField="AccountCode" ValueField="AccountID" ClientInstanceName="cboAccount" ID="cboAccount" NullValueItemDisplayText="{1}" TextFormatString="{1}">
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="AccountID" ClientVisible="False"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="AccountCode" Width="250px"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="AccountType" Caption="Account Type" Width="150px"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="AccountName" ClientVisible="False"></dx:ListBoxColumn>
                                                                    </Columns>

                                                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Statement">
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>


                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                        <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdBankDeposit" Text="Account Deposit" Width="150px" ClientInstanceName="cmdFuelCredit">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdAccountTranfer" Text="Transfers" Width="150px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdCredit" Text="Account Credit" Width="150px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdDebit" Text="Account Debit" Width="150px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdAccountStatement" Text="Statement" Width="150px" ValidationGroup="Statement">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdAccountBalance" Text="Balances" Width="150px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdRefresh" AutoPostBack="false" Text="Refresh" Width="150px">
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


    <asp:SqlDataSource runat="server" ID="SqlDataSourceAccount" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="Usp_Accounts_GetByUserSite" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="-1" Name="UserID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>



    <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%><%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>


