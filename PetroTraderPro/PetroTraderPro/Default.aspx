<%@ Page Language="VB" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Default.aspx.vb" Inherits="PetroTraderPro.Default" Title="" %>


<%@ Register Assembly="DevExpress.Web.Bootstrap.v24.2, Version=24.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <script runat="server">

        Protected Function GetTotalSales() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalSales As Double = dtTemp.Rows(0).Item("TotalSales")
            Return TotalSales
        End Function

        Protected Function GetTotalDeductions() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalDeductions As Double = dtTemp.Rows(0).Item("TotalDeduction")
            Return TotalDeductions
        End Function

        Protected Function GetTotalEPayment() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalEPayment As Double = dtTemp.Rows(0).Item("TotalEPay")
            Return TotalEPayment
        End Function

        Protected Function GetTotalCash() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalCash As Double = dtTemp.Rows(0).Item("TotalCash")
            Return TotalCash
        End Function

        Protected Function GetTotalBank() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalBank As Double = dtTemp.Rows(0).Item("TotalToBank")
            Return TotalBank
        End Function

        Protected Function GetTotalPayments() As Double
            On Error Resume Next
            Dim dtTemp As System.Data.DataTable
            dtTemp = CType(SqlDataSourceSummary.Select(DataSourceSelectArguments.Empty), System.Data.DataView).Table

            Dim TotalPayments As Double = dtTemp.Rows(0).Item("TotalCustomerPayment")
            Return TotalPayments
        End Function

    </script>

</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
     <div class="container-fluid bg-light py-2">
        <div class="container">
            <div class="text-left" data-wow-delay="0.1s">
                <span class="text-uppercase text-primary bg-light px-2">Dashboard</span>
               
            </div>
            <hr />
            <div class="row g-2 align-items-center text-center">
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalSales(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total Sales</p>
                </div>
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalDeductions(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total Deductions</p>
                </div>
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalEPayment(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total E-Payments</p>
                </div>
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalCash(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total Cash</p>
                </div>
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalBank(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total To Bank</p>
                </div>
                <div class="col-md-6 col-lg-2 wow fadeIn" data-wow-delay="0.1s">
                    <i class="fa fa-calendar-alt fa-2x text-primary mb-4"></i>
                    <h5><% = Microsoft.VisualBasic.Format(GetTotalPayments(), "#,##0.#0")%></h5>
                    <p class="mb-0">Total Payments</p>
                </div>

            </div>
            <div class="row g-2 align-items-center text-center">
                <div class="col-md-6 col-lg-12 py-3" data-wow-delay="0.1s">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <h4 style="color: #0D6B68">Sales By Site</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <dx:BootstrapChart ID="BootstrapChart1" runat="server" DataSourceID="SqlDataSourceSalesSummary" EncodeHtml="True" LoadingIndicatorText="" Palette="GreenMist" PaletteExtensionMode="Extrapolate" TitleText="Standard Bar" Width="100%">
                                <ArgumentAxis MinorTickVisible="False" TickVisible="False">
                                </ArgumentAxis>
                                <SeriesCollection>
                                    <dx:BootstrapChartBarSeries BarPadding="-1" Name="TotalSales" ValueField="TotalSales" ShowInLegend="False">
                                        <Label Visible="True" Position="Inside">
                                            <ArgumentFormat Currency="" />
                                            <Format Currency="" />
                                        </Label>
                                    </dx:BootstrapChartBarSeries>
                                </SeriesCollection>
                                <SettingsCommonSeries ArgumentField="SiteCode">
                                </SettingsCommonSeries>
                                <SettingsCommonAxis MinorTickVisible="False" TickVisible="False">
                                </SettingsCommonAxis>
                                <SettingsLegend Visible="False" />
                                <TitleSettings Text="Sales By Site">
                                    <SubTitleSettings Offset="0">
                                    </SubTitleSettings>
                                </TitleSettings>

                                <SettingsExport ProxyUrl=""></SettingsExport>
                            </dx:BootstrapChart>


                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-2 align-items-center text-center">
                <div class="col-md-6 col-lg-6" data-wow-delay="0.1s">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <h4 style="color: #0D6B68">Sales Summary</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <dx:ASPxGridView ID="GridViewSalesSummary" runat="server" AutoGenerateColumns="False" Width="100%" DataSourceID="SqlDataSourceSalesSummary" KeyFieldName="SiteID">
                                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                </SettingsAdaptivity>
                                <SettingsPager PageSize="20" AlwaysShowPager="True">
                                </SettingsPager>
                                <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" ShowFooter="True" HorizontalScrollBarMode="Visible" />
                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />

                                <SettingsPopup>
                                    <FilterControl AutoUpdatePosition="False"></FilterControl>
                                </SettingsPopup>
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="SiteID" ReadOnly="True" VisibleIndex="0" Visible="False">
                                        <EditFormSettings Visible="False"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Caption="Site" Width="30%">
                                        <CellStyle HorizontalAlign="Left"></CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="TotalSales" ReadOnly="True" VisibleIndex="3" Width="23%">
                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="TotalDeduction" ReadOnly="True" VisibleIndex="4" Width="23%">
                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="TotalBank" ReadOnly="True" VisibleIndex="5" Width="23%">
                                        <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <TotalSummary>
                                    <dx:ASPxSummaryItem DisplayFormat="#,##0.#0" FieldName="TotalSales" ShowInColumn="Total Sales" SummaryType="Sum" />
                                    <dx:ASPxSummaryItem DisplayFormat="#,##0.#0" FieldName="TotalDeduction" ShowInColumn="Total Deduction" SummaryType="Sum" />
                                    <dx:ASPxSummaryItem DisplayFormat="#,##0.#0" FieldName="TotalBank" ShowInColumn="Total Bank" SummaryType="Sum" />
                                </TotalSummary>
                                <Styles>
                                    <Footer Font-Bold="True" ForeColor="Black">
                                    </Footer>
                                </Styles>
                            </dx:ASPxGridView>
                        </div>
                    </div>
                </div>
            <div class="col-md-6 col-lg-6" data-wow-delay="0.1s">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <h4 style="color: #0D6B68">Sales By Site</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <dx:ASPxGridView ID="GridViewStockSummary" runat="server" AutoGenerateColumns="False" Width="100%" DataSourceID="SqlDataSourceStockSummary">
                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                            </SettingsAdaptivity>
                            <SettingsPager PageSize="20" AlwaysShowPager="True">
                            </SettingsPager>
                            <Settings VerticalScrollableHeight="200" VerticalScrollBarMode="Visible" ShowFooter="True" HorizontalScrollBarMode="Visible" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />

                            <SettingsPopup>
                                <FilterControl AutoUpdatePosition="False"></FilterControl>
                            </SettingsPopup>
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="0" Visible="False" Width="50px">
                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="1" Caption="Site" Width="40%">
                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Visible="False" Width="50px">
                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="3" Caption="Product" Width="30%">
                                    <CellStyle HorizontalAlign="Left"></CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TotalStock" ReadOnly="True" VisibleIndex="4" Width="30%">
                                    <PropertiesTextEdit DisplayFormatString="#,##0.#0"></PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <TotalSummary>
                                <dx:ASPxSummaryItem ShowInColumn="Total Stock" FieldName="TotalStock" SummaryType="Sum" DisplayFormat="#,##0.#0"></dx:ASPxSummaryItem>
                            </TotalSummary>

                            <Styles>
                                <Footer Font-Bold="True" ForeColor="Black"></Footer>
                            </Styles>
                        </dx:ASPxGridView>
                    </div>
                </div>
            </div>

            </div>


        </div>
    </div>
    <div class="bg-light py-2" style="height:50px"></div>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceSummary" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="usp_Dashboard_Summary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserID" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceSalesSummary" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="usp_DashboardSales_Summary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserID" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceStockSummary" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="usp_DashboardStock_Summary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtUserID" PropertyName="Text" DefaultValue="-1" Name="UserID" Type="Int32"></asp:ControlParameter>

        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxTextBox ID="txtUserID" runat="server"  AutoPostBack="true" Width="20px" ClientVisible="false" Text="-1"></dx:ASPxTextBox>
</asp:Content>

