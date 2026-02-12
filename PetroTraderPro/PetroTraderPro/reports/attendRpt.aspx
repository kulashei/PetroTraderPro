<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="attendRpt.aspx.vb" Inherits="PetroTraderPro.attendRpt" %>


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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">Attendant Reports</h1>
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

                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem Caption="To" ColSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpDateTo" ID="dtpDateTo">
                                                                </dx:ASPxDateEdit>


                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>

                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" Caption="Site" ColumnSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox ID="cboSiteAdd" runat="server" AutoPostBack="true" ClientInstanceName="cboSiteAdd" DataSourceID="SqlDataSourceSites" TextField="SiteName" ValueField="SiteID" ValueType="System.Int32">
                                                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>


                                                    </dx:LayoutItem>
                                                    <dx:LayoutItem ColSpan="1" Caption="Attendant" ColumnSpan="1">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <dx:ASPxComboBox ID="cboAttendantAdd" runat="server" ClientInstanceName="cboAttendantAdd" TextField="AttendantName" ValueField="AttendantID" ValueType="System.Int32" DataSourceID="SqlDataSourceAttendantAdd" TextFormatString="{1}" NullValueItemDisplayText="{2}">
                                                                    <Columns>
                                                                        <dx:ListBoxColumn FieldName="AttendantID" ClientVisible="False"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="AttendantName" Width="200px" Caption="Name"></dx:ListBoxColumn>
                                                                        <dx:ListBoxColumn FieldName="AttendantCode" Width="100px" Caption="Code"></dx:ListBoxColumn>
                                                                    </Columns>

                                                                    <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                        <RequiredField IsRequired="True"></RequiredField>
                                                                    </ValidationSettings>
                                                                </dx:ASPxComboBox>

                                                                <asp:SqlDataSource ID="SqlDataSourceAttendantAdd" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [AttendantID], [SiteID], [AttendantCode], [AttendantName], [PhoneNumber1] FROM [FuelAttendants] WHERE ([SiteID] = @SiteID) AND Disabled=0 AND Deleted=0 ORDER BY [AttendantName]">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="cboSiteAdd" PropertyName="Value" DefaultValue="-1" Name="SiteID" Type="Int32"></asp:ControlParameter>
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>


                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdShort" Text="Shortages" Width="170px" ClientInstanceName="cmdFuelCredit">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdPay" Text="Payments" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdDrCrs" Text="Account Debit/Credit" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdAttendantStatement" Text="Attendant Statement" Width="170px" ValidationGroup="Statement">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdAttendantBalance" Text="Attendant Balance" Width="170px">
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton runat="server" ID="cmdRefresh" Text="Refresh" Width="170px" >
                                                            <ClientSideEvents Click="function(s, e) {SetTarget();}" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                        <Styles>
                                            <LayoutItem>
                                                <Caption Font-Bold="True" ForeColor="Black">
                                                </Caption>
                                            </LayoutItem>
                                        </Styles>

                                    </dx:ASPxFormLayout>
                                </dx:PanelContent>
                            </PanelCollection>

                        </dx:ASPxRoundPanel>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

        </Items>
    </dx:ASPxFormLayout>



    <asp:SqlDataSource runat="server" ID="SqlDataSourceAttendants" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [View_Attendants] ORDER BY [CompanyName]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSites" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID&gt;0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <%--            <triggers>
                <asp:PostBackTrigger ControlID="PopupConfirmCancelYes" />
            </triggers>--%>
    <%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>


