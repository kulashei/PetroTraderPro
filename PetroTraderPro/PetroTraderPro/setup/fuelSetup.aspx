<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="fuelSetup.aspx.vb" Inherits="PetroTraderPro.fuelSetup" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>
    <script src="../Content/myjs/jquery-3.6.0.js"></script>
    <script type="text/javascript">

        //Product

        function EmptyProductAdd() {
            txtProductCodeAdd.SetText("");
            txtProductNameAdd.SetText("");

        };

        function EmptyProductEdit() {
            txtProductIDEdit.SetText("0");
            txtProductCodeEdit.SetText("");
            txtProductNameEdit.SetText("");

        };

        function OnSaveProductAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveProductAdd.Show();
            }
        };
        function OnSaveProductEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveProductEdit.Show();
            }
        };

        function getProductButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdAddSiteProduct") {
                GridViewProduct.GetRowValues(e.visibleIndex, 'ProductID;ProductCode;ProductName', getEditProductRowValues);
            } else if (e.buttonID === "cmdDeleteProduct") {
                GridViewProduct.GetRowValues(e.visibleIndex, 'ProductID;ProductCode;ProductName', getDeleteProductRowValues);
            };

        };


        function getEditProductRowValues(values) {
            popupProductEdit.Show();
            EmptyProductEdit();

            txtProductIDEdit.SetText(values[0]);
            txtProductCodeEdit.SetText(values[1]);
            txtProductNameEdit.SetText(values[2]);
        };

        function getDeleteProductRowValues(values) {
            popupProductDelete.Show();
            txtProductIDDelete.SetText("0");

            txtProductIDDelete.SetText(values[0]);
        };

        //SiteProduct

        function EmptySiteProductAdd() {
            cboSiteProductProductAdd.SetSelectedIndex(-1)

        };

        function OnSaveSiteProductAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveSiteProductAdd.Show();
            }
        };

        function getSiteProductButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdDeleteSiteProduct") {
                GridViewSiteProduct.GetRowValues(e.visibleIndex, 'SiteProductID', getDeleteSiteProductRowValues);
            };

        };

        function getDeleteSiteProductRowValues(values) {
            popupSiteProductDelete.Show();
            txtSiteProductIDDelete.SetText("0");

            txtSiteProductIDDelete.SetText(values[0]);
        };


        function SiteProductLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupSiteProductAdd.Show();
                cboSiteProductProductAdd.SetSelectedIndex(-1);
            }
        };

        // RATE //


        function EmptyRateAdd() {
            cboRateProductAdd.SetSelectedIndex(-1)
            txtSellingPriceRateAdd.SetValue(0);
            txtCostPriceRateAdd.SetValue(0);


        };

        function OnSaveRateAdd(s, e) {
            lblErrMsgRateAdd.SetVisible(false);
            lblErrMsgRateAdd.SetText("");
            lblSuccessMsgRateAdd.SetVisible(false);
            lblSuccessMsgRateAdd.SetText("");

            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                var sellPrice = txtSellingPriceRateAdd.GetValue();
                var costPrice = txtCostPriceRateAdd.GetValue();
                if (parseFloat(sellPrice) <= 0) { lblErrMsgRateAdd.SetVisible(true); lblErrMsgRateAdd.SetText('Please Enter the Selling Price'); txtSellingPriceRateAdd.Focus(); return; };
                if (parseFloat(costPrice) <= 0) { lblErrMsgRateAdd.SetVisible(true); lblErrMsgRateAdd.SetText('Please Enter the Cost Price'); txtCostPriceRateAdd.Focus(); return; };
                PopupConfirmSaveRateAdd.Show();
            }
        };

        function getRateButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdDeleteRate") {
                GridViewRate.GetRowValues(e.visibleIndex, 'RateID', getDeleteRateRowValues);
            };

        };

        function getDeleteRateRowValues(values) {
            popupRateDelete.Show();
            txtRateIDDelete.SetText("0");

            txtRateIDDelete.SetText(values[0]);
        };


        function RateLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupRateAdd.Show();
                EmptyRateAdd();
            }
        };

        // Tank //


        function EmptyTankAdd() {
            cboTankProductAdd.SetSelectedIndex(-1)
            txtTankCodeAdd.SetText("");
            txtTankCapacityAdd.SetValue(0);



        };


        function EmptyTankEdit() {
            txtTankIDEdit.SetText("0");
            cboTankProductEdit.SetSelectedIndex(-1)
            txtTankCodeEdit.SetText("");
            txtTankCapacityEdit.SetValue(0);
            chkTankDisableEdit.SetChecked(false);
     };

        function OnSaveTankAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveTankAdd.Show();
            }
        };


        function OnSaveTankEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveTankEdit.Show();
            }
        };
        function getTankButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdEditTank") {
                GridViewTank.GetRowValues(e.visibleIndex, 'TankID;SiteProductID;TankCode;Capacity;Disabled', getEditTankRowValues);
            } else if (e.buttonID === "cmdDeleteTank") {
                GridViewTank.GetRowValues(e.visibleIndex, 'TankID;SiteProductID;TankCode;Capacity;Disabled', getDeleteTankRowValues);
            };

        };


        function getEditTankRowValues(values) {
            popupTankEdit.Show();
            EmptyTankEdit();

            txtTankIDEdit.SetText(values[0]);
            cboTankProductEdit.SetValue(values[1])
            txtTankCodeEdit.SetText(values[2]);
            txtTankCapacityEdit.SetValue(values[3]);
            chkTankDisableEdit.SetValue(values[4]);

            //txtTankIDEdit.SetText(values[0]);
            //txtTankCodeEdit.SetText(values[1]);
            //txtTankNameEdit.SetText(values[2]);
        };

        function getDeleteTankRowValues(values) {
            popupTankDelete.Show();
            txtTankIDDelete.SetText("0");

            txtTankIDDelete.SetText(values[0]);
        };


        function TankLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupTankAdd.Show();
                EmptyTankAdd();
            }
        };

        // Pump //


        function EmptyPumpAdd() {
            cboPumpTankAdd.SetSelectedIndex(-1)
            txtPumpCodeAdd.SetText("");



        };


        function EmptyPumpEdit() {
            txtPumpIDEdit.SetText("0");
            cboPumpTankEdit.SetSelectedIndex(-1)
            txtPumpCodeEdit.SetText("");
            chkPumpDisableEdit.SetChecked(false);
        };

        function OnSavePumpAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSavePumpAdd.Show();
            }
        };


        function OnSavePumpEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSavePumpEdit.Show();
            }
        };
        function getPumpButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdEditPump") {
                GridViewPump.GetRowValues(e.visibleIndex, 'PumpID;TankID;PumpCode;Disabled', getEditPumpRowValues);
            } else if (e.buttonID === "cmdDeletePump") {
                GridViewPump.GetRowValues(e.visibleIndex, 'PumpID;TankID;PumpCode;Disabled', getDeletePumpRowValues);
            };

        };


        function getEditPumpRowValues(values) {
            popupPumpEdit.Show();
            EmptyPumpEdit();

            txtPumpIDEdit.SetText(values[0]);
            cboPumpTankEdit.SetValue(values[1])
            txtPumpCodeEdit.SetText(values[2]);
            chkPumpDisableEdit.SetValue(values[3]);

        };

        function getDeletePumpRowValues(values) {
            popupPumpDelete.Show();
            txtPumpIDDelete.SetText("0");

            txtPumpIDDelete.SetText(values[0]);
        };


        function PumpLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupPumpAdd.Show();
                EmptyPumpAdd();
            }
        };

        // Attendant //


        function EmptyAttendantAdd() {
            GenerateAttendantTransCode();
            txtFirstNameAdd.SetText("");
            txtOtherNamesAdd.SetText("");
            cboGenderAdd.SetSelectedIndex(-1);
            dtpDateOfBirthAdd.SetText("");
            txtAddressAdd.SetText("");
            txtPhoneNumber1Add.SetText("");
            txtPhoneNumber2Add.SetText("");
            txtContactNameAdd.SetText("");
            txtContactRelationAdd.SetText("");
            txtContactAddressAdd.SetText("");
            txtContactPhoneNumberAdd.SetText("");
            picPictureAdd.SetImageUrl("");

            picPictureAdd.SetHeight(150);
            picPictureAdd.SetWidth(150);

        };


        function EmptyAttendantView() {
            txtAttendantIDView.SetText("0");
            txtStaffIDView.SetText("");
            txtFirstNameView.SetText("");
            txtOtherNamesView.SetText("");
            txtGenderView.SetText("");
            txtDateOfBirthView.SetText("");
            txtAddressView.SetText("");
            txtPhoneNumber1View.SetText("");
            txtPhoneNumber2View.SetText("");
            txtContactNameView.SetText("");
            txtContactRelationView.SetText("");
            txtContactAddressView.SetText("");
            txtContactPhoneNumberView.SetText("");
            picPictureView.SetImageUrl("");
            picPictureView.SetHeight(150);
            picPictureView.SetWidth(150);

        };
        function EmptyAttendantEdit() {
            cboSiteAttendantEdit.SetSelectedIndex(-1);
            txtAttendantID.SetText("0");
            txtAttendantIDEdit.SetText("0");
            lblAttendantIDEdit.SetText("0");
            txtStaffIDEdit.SetText("");
            txtFirstNameEdit.SetText("");
            txtOtherNamesEdit.SetText("");
            cboGenderEdit.SetSelectedIndex(-1);
            dtpDateOfBirthEdit.SetText("");
            txtAddressEdit.SetText("");
            txtPhoneNumber1Edit.SetText("");
            txtPhoneNumber2Edit.SetText("");
            txtContactNameEdit.SetText("");
            txtContactRelationEdit.SetText("");
            txtContactAddressEdit.SetText("");
            txtContactPhoneNumberEdit.SetText("");
            //picPictureEdit.SetImageUrl("");
            //picPictureEdit.SetHeight(150);
            //picPictureEdit.SetWidth(150);
            chkAttendantDisableEdit.SetChecked(false);

        };


        function OnSaveAttendantAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAttendantAdd.Show();
            }
        };


        function OnSaveAttendantEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAttendantEdit.Show();
            }
        };
        function getAttendantButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdViewAttendant") {
                GridViewAttendant.GetRowValues(e.visibleIndex, 'AttendantID;SiteID;AttendantCode;FirstName;OtherNames;AttendantName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getViewAttendantRowValues);
            } else if (e.buttonID === "cmdEditAttendant") {
                GridViewAttendant.GetRowValues(e.visibleIndex, 'AttendantID;SiteID;AttendantCode;FirstName;OtherNames;AttendantName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getEditAttendantRowValues);
            } else if (e.buttonID === "cmdDeleteAttendant") {
                GridViewAttendant.GetRowValues(e.visibleIndex, 'AttendantID;SiteID;AttendantCode;FirstName;OtherNames;AttendantName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getDeleteAttendantRowValues);
            };

        };


        function getViewAttendantRowValues(values) {
            popupAttendantView.Show();
            EmptyAttendantView();

            txtAttendantIDView.SetText(values[0]);
            txtAttendantIDView.SetText(values[0]);
            txtAttendantID.SetText(values[0]);

            txtStaffIDView.SetText(values[2]);
            txtFirstNameView.SetText(values[3]);
            txtOtherNamesView.SetText(values[4]);
            txtGenderView.SetText(values[6]);
            txtDateOfBirthView.SetText(values[7]);
            txtAddressView.SetText(values[8]);
            txtPhoneNumber1View.SetText(values[9]);
            txtPhoneNumber2View.SetText(values[10]);
            txtContactNameView.SetText(values[11]);
            txtContactRelationView.SetText(values[12]);
            txtContactAddressView.SetText(values[13]);
            txtContactPhoneNumberView.SetText(values[14]);
            picPictureView.SetImageUrl(values[18]);
            picPictureView.SetHeight(150);
            picPictureView.SetWidth(150);

        };
        function getEditAttendantRowValues(values) {
            popupAttendantEdit.Show();
            //EmptyAttendantEdit();

            txtAttendantID.SetText(values[0]);
            //txtAttendantIDEdit.SetText(values["AttendantID"]);
            cboSiteAttendantEdit.SetValue(values[1]);
            //lblAttendantIDEdit.SetText(values[0]);

            //sessionStorage.setItem("", values[0]);
            //Session["AttendantID"] = values[0];
            //txtAttendantIDEdit.SetText(values[0]);
            txtStaffIDEdit.SetText(values[2]);
            txtFirstNameEdit.SetText(values[3]);
            txtOtherNamesEdit.SetText(values[4]);
            cboGenderEdit.SetText(values[6]);
            dtpDateOfBirthEdit.SetValue(values[7]);
            txtAddressEdit.SetText(values[8]);
            txtPhoneNumber1Edit.SetText(values[9]);
            txtPhoneNumber2Edit.SetText(values[10]);
            txtContactNameEdit.SetText(values[11]);
            txtContactRelationEdit.SetText(values[12]);
            txtContactAddressEdit.SetText(values[13]);
            txtContactPhoneNumberEdit.SetText(values[14]);
            //picPictureEdit.SetImageUrl(values[18]);
            //lblAttendantIDEdit.SetText(values[0]);
            chkAttendantDisableEdit.SetValue(values[19]);

            //txtAttendantIDEdit.SetText(values[0]);

        //    picPictureEdit.SetHeight(150);
        //    picPictureEdit.SetWidth(150);
        };

        function getDeleteAttendantRowValues(values) {
            popupAttendantDelete.Show();
            txtAttendantIDDelete.SetText("0");

            txtAttendantIDDelete.SetText(values[0]);
        };


        function AttendantLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupAttendantAdd.Show();
                EmptyAttendantAdd();
            }
        };
        function GenerateAttendantTransCode() {
            let text = Math.random().toString();
            txtAttendantTransactionCode.SetText(text.replace('.', ''));
        };

        function LoadPictureAdd(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#<%=picPictureAdd.ClientID%>').prop('src', e.target.result)
                        .Width(150)
                        .Height(150)
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function LoadPictureEdit(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#<%=picPictureEdit.ClientID%>').prop('src', e.target.result)
                        .Width(150)
                        .Height(150)
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        // general 
        function GenerateTransCode() {
            let text = Math.random().toString();
            txtTransactionCode.SetText(text.replace('.', ''));
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
                    <h2 style="color: #0D6B68; font-weight: bold; font-size: x-large;">Fuel Setup</h2>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>

    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" Width="100%" ColCount="5" ColumnCount="5">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
        </SettingsAdaptivity>

        <Items>
            <dx:LayoutItem ColSpan="2" Caption="Site" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox runat="server" AutoPostBack="true" ValueType="System.Int32" DataSourceID="SqlDataSourceSearchSite" TextField="SiteName" ValueField="SiteID" ClientInstanceName="cboSiteSearch" ID="cboSiteSearch">
                            <ClientSideEvents ValueChanged="function(s, e) {txtSiteSearch.SetValue(cboSiteSearch.GetValue());}"></ClientSideEvents>
                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="LoadSite">
                                <RequiredField IsRequired="True"></RequiredField>
                            </ValidationSettings>
                        </dx:ASPxComboBox>
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
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>

            <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                </SettingsAdaptivity>
                <Items>
                    <dx:LayoutItem ShowCaption="False" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
                                    <TabPages>
                                        <dx:TabPage Text="Fuel Setup">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>

                                                        <Items>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Left">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton runat="server" ID="cmdAddProduct" AutoPostBack="false" Text="Add New" Width="120px">

                                                                            <ClientSideEvents Click="function(s, e) {popupProductAdd.Show();}"></ClientSideEvents>
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewProduct" ClientInstanceName="GridViewProduct" runat="server" AutoGenerateColumns="False" KeyFieldName="ProductID" DataSourceID="SqlDataSourceProduct" Width="100%">
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>

                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
                                                                            </SettingsPager>

                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible"></Settings>

                                                                            <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowGroup="False" AllowSort="False"></SettingsBehavior>

                                                                            <SettingsDataSecurity AllowInsert="False" AllowEdit="False" AllowDelete="False"></SettingsDataSecurity>


                                                                            <ClientSideEvents CustomButtonClick="getProductButtonClick" />

                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>


                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" Width="40px" VisibleIndex="0">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdEditProduct" Text="Edit">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#FF9900"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeleteProduct" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#CC3300"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                    <EditFormSettings Visible="False"></EditFormSettings>
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" ShowInCustomizationForm="True" Width="50px" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductName" ShowInCustomizationForm="True" Width="100px" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataCheckColumn FieldName="Disabled" ShowInCustomizationForm="True" Width="50px" VisibleIndex="4"></dx:GridViewDataCheckColumn>
                                                                            </Columns>

                                                                            <Styles>
                                                                                <HeaderPanel Font-Bold="True"></HeaderPanel>
                                                                            </Styles>
                                                                        </dx:ASPxGridView>

                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>

                                                        </Items>
                                                    </dx:ASPxFormLayout>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Site Fuel Product">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout5" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>

                                                        <Items>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Left">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton runat="server" ID="cmdAddSiteProduct" ClientInstanceName="cmdAddSiteProduct" AutoPostBack="false" Text="Add New" Width="120px" ValidationGroup="LoadSite">

                                                                            <ClientSideEvents Click="function(s, e) { SiteProductLoadAdd();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewSiteProduct" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewSiteProduct" DataSourceID="SqlDataSourceSiteFuelProduct" KeyFieldName="SiteProductID" Width="100%">
                                                                            <ClientSideEvents CustomButtonClick="getProductButtonClick" />
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True">
                                                                                </PageSizeItemSettings>
                                                                            </SettingsPager>
                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                                            <SettingsBehavior AllowFocusedRow="True" AllowGroup="False" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>


                                                                            <ClientSideEvents CustomButtonClick="getSiteProductButtonClick" />
                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" Width="20px" VisibleIndex="0">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeleteSiteProduct" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#CC3300"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataTextColumn Caption="Site" FieldName="SiteCode" ShowInCustomizationForm="True" VisibleIndex="1" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn Caption="Product" FieldName="ProductName" ShowInCustomizationForm="True" VisibleIndex="3" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteProductID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="5" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="7" Width="50px">
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

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Fuel Price">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout12" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>

                                                        <Items>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Left">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton runat="server" ID="cmdAddRate" ClientInstanceName="cmdAddRate" AutoPostBack="false" Text="Add New" Width="120px" ValidationGroup="LoadSite">
                                                                            <ClientSideEvents Click="function(s, e) { RateLoadAdd();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewRate" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewRate" DataSourceID="SqlDataSourceRate" Width="100%" KeyFieldName="RateID">
                                                                            <ClientSideEvents CustomButtonClick="getProductButtonClick" />
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True">
                                                                                </PageSizeItemSettings>
                                                                            </SettingsPager>
                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                                            <SettingsBehavior AllowFocusedRow="True" AllowGroup="False" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>

                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" Width="20px" VisibleIndex="0">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeleteSiteRate" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#CC3300"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="4" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="5" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="1" Caption="Product" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="6" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataCheckColumn FieldName="Main" VisibleIndex="7" Visible="False" Width="50px"></dx:GridViewDataCheckColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="RateID" VisibleIndex="8" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="9" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="10" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="Rate" VisibleIndex="2" Caption="Selling Price" Width="50px">
                                                                                    <PropertiesTextEdit DisplayFormatString="#,##0.###0"></PropertiesTextEdit>
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataDateColumn FieldName="RateDate" VisibleIndex="0" Caption="Date" Width="50px">
                                                                                    <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                                                                </dx:GridViewDataDateColumn>
                                                                                <dx:GridViewDataDateColumn FieldName="CostPriceDate" VisibleIndex="11" Visible="False" Width="50px"></dx:GridViewDataDateColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="CostPrice" VisibleIndex="3" Width="50px">
                                                                                    <PropertiesTextEdit DisplayFormatString="#,##0.###0"></PropertiesTextEdit>
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

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Tank Registration">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout17" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>
                                                        <Items>
                                                            <dx:LayoutItem ColSpan="1" HorizontalAlign="Left" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton ID="cmdAddTank" runat="server" ClientInstanceName="cmdAddTank" AutoPostBack="False" Text="Add New" ValidationGroup="LoadSite" Width="120px">
                                                                            <ClientSideEvents Click="function(s, e) { TankLoadAdd();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewTank" runat="server" AutoGeneTankColumns="False" ClientInstanceName="GridViewTank" DataSourceID="SqlDataSourceTank" Width="100%" AutoGenerateColumns="False" KeyFieldName="TankID">
                                                                            <ClientSideEvents CustomButtonClick="getProductButtonClick" />
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True">
                                                                                </PageSizeItemSettings>
                                                                            </SettingsPager>
                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                                            <SettingsBehavior AllowFocusedRow="True" AllowGroup="False" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>

                                                                            <ClientSideEvents CustomButtonClick="getTankButtonClick" />

                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" VisibleIndex="0" Width="50px">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdEditTank" Text="Edit">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#FF9900"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeleteTank" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style BackColor="#CC3300" Width="50px">
                                                                                                </Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="1" Caption="Site" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="6" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="7" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" VisibleIndex="8" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="9" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="4" Width="50px" Visible="False">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductID" VisibleIndex="10" Visible="False" Width="50px"></dx:GridViewDataTextColumn>

                                                                                <dx:GridViewDataTextColumn FieldName="SiteProductID" VisibleIndex="11" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="TankCode" VisibleIndex="2" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="Capacity" VisibleIndex="5" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="CreatedBy" VisibleIndex="12" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataDateColumn FieldName="CreatedDate" VisibleIndex="13" Visible="False" Width="50px">
                                                                                </dx:GridViewDataDateColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ModifiedBy" VisibleIndex="14" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataDateColumn FieldName="ModifiedDate" VisibleIndex="15" Visible="False" Width="50px">
                                                                                </dx:GridViewDataDateColumn>
                                                                                <dx:GridViewDataCheckColumn FieldName="Disabled" VisibleIndex="16" Width="40px"></dx:GridViewDataCheckColumn>

                                                                                <dx:GridViewDataTextColumn FieldName="ProductName" Width="50px" Caption="Product" VisibleIndex="3"></dx:GridViewDataTextColumn>
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
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Pump Registration">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout20" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>
                                                        <Items>
                                                            <dx:LayoutItem ColSpan="1" HorizontalAlign="Left" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton ID="cmdAddPump" runat="server" ClientInstanceName="cmdAddPump" AutoPostBack="False" Text="Add New" ValidationGroup="LoadSite" Width="120px">
                                                                            <ClientSideEvents Click="function(s, e) { PumpLoadAdd();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewPump" runat="server" AutoGenerateColumns="False" AutoGenePumpColumns="False" ClientInstanceName="GridViewPump" DataSourceID="SqlDataSourcePump" KeyFieldName="PumpID" Width="100%">
                                                                            <ClientSideEvents CustomButtonClick="getProductButtonClick" />
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True">
                                                                                </PageSizeItemSettings>
                                                                            </SettingsPager>
                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                                            <SettingsBehavior AllowFocusedRow="True" AllowGroup="False" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>
                                                                            <ClientSideEvents CustomButtonClick="getPumpButtonClick" />
                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" VisibleIndex="0" Width="40px">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdEditPump" Text="Edit">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#FF9900"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeletePump" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style BackColor="#CC3300" Width="50px">
                                                                                                </Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataTextColumn Caption="Tank" FieldName="TankCode" ShowInCustomizationForm="True" VisibleIndex="1" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteCode" ShowInCustomizationForm="True" VisibleIndex="0" Width="50px" Caption="Site">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductCode" ShowInCustomizationForm="True" Visible="False" VisibleIndex="5">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductName" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ProductID" ShowInCustomizationForm="True" VisibleIndex="7" Visible="False">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteProductID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="8">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" ShowInCustomizationForm="True" Visible="False" VisibleIndex="9">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="PumpID" ShowInCustomizationForm="True" VisibleIndex="10" ReadOnly="True" Visible="False">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="TankID" ShowInCustomizationForm="True" VisibleIndex="11" Visible="False">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="PumpCode" ShowInCustomizationForm="True" VisibleIndex="2" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataCheckColumn FieldName="Disabled" ShowInCustomizationForm="True" VisibleIndex="3" Width="50px">
                                                                                </dx:GridViewDataCheckColumn>
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
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Attendants Registration">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <dx:ASPxFormLayout ID="ASPxFormLayout25" runat="server">
                                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
                                                        </SettingsAdaptivity>
                                                        <Items>
                                                            <dx:LayoutItem ColSpan="1" HorizontalAlign="Left" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxButton ID="cmdAddAttendant" runat="server" ClientInstanceName="cmdAddAttendant" AutoPostBack="False" Text="Add New" ValidationGroup="LoadSite" Width="120px">
                                                                            <ClientSideEvents Click="function(s, e) { AttendantLoadAdd();}" />
                                                                        </dx:ASPxButton>
                                                                    </dx:LayoutItemNestedControlContainer>
                                                                </LayoutItemNestedControlCollection>
                                                            </dx:LayoutItem>
                                                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                                <LayoutItemNestedControlCollection>
                                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                                        <dx:ASPxGridView ID="GridViewAttendant" runat="server" AutoGeneAttendantColumns="False" AutoGenerateColumns="False" ClientInstanceName="GridViewAttendant" DataSourceID="SqlDataSourceAttendant" KeyFieldName="AttendantID" Width="100%">
                                                                            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                                                                            </SettingsAdaptivity>
                                                                            <SettingsPager PageSize="50" Position="Top">
                                                                                <PageSizeItemSettings Visible="True">
                                                                                </PageSizeItemSettings>
                                                                            </SettingsPager>
                                                                            <Settings VerticalScrollableHeight="350" VerticalScrollBarMode="Visible" />
                                                                            <SettingsBehavior AllowFocusedRow="True" AllowGroup="False" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" AllowSort="False" />
                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                            <SettingsPopup>
                                                                                <FilterControl AutoUpdatePosition="False">
                                                                                </FilterControl>
                                                                            </SettingsPopup>

                                                                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                                                                            <ClientSideEvents CustomButtonClick="getAttendantButtonClick" />

                                                                            <Columns>
                                                                                <dx:GridViewCommandColumn ButtonRenderMode="Button" ButtonType="Button" ShowInCustomizationForm="True" VisibleIndex="0" Width="100px">
                                                                                    <CustomButtons>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdViewAttendant" Text="View">
                                                                                            <Styles>
                                                                                                <Style BackColor="#0066cc" Width="50px">
                                                                                                </Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdEditAttendant" Text="Edit">
                                                                                            <Styles>
                                                                                                <Style Width="50px" BackColor="#FF9900"></Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                        <dx:GridViewCommandColumnCustomButton ID="cmdDeleteAttendant" Text="Delete">
                                                                                            <Styles>
                                                                                                <Style BackColor="#CC3300" Width="50px">
                                                                                                </Style>
                                                                                            </Styles>
                                                                                        </dx:GridViewCommandColumnCustomButton>
                                                                                    </CustomButtons>
                                                                                </dx:GridViewCommandColumn>
                                                                                <dx:GridViewDataImageColumn FieldName="AttendantID" VisibleIndex="1" Caption="  " Width="50px">
                                                                                    <PropertiesImage ImageUrlFormatString="/employeePics/{0}.jpg" ImageHeight="50px" ImageWidth="50px">
                                                                                        <EmptyImage Url="employeePics/0.jpg"></EmptyImage>
                                                                                    </PropertiesImage>
                                                                                </dx:GridViewDataImageColumn>

                                                                                <dx:GridViewDataTextColumn FieldName="AttendantID" VisibleIndex="3" ReadOnly="True" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteID" VisibleIndex="4" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="AttendantCode" VisibleIndex="5" Caption="Code" Width="30px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="7" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="OtherNames" VisibleIndex="8" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="AttendantName" ReadOnly="True" VisibleIndex="6" Caption="Name" Width="80px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="Gender" VisibleIndex="9" Width="30px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataDateColumn FieldName="BirthDate" VisibleIndex="10" Visible="False" Width="50px"></dx:GridViewDataDateColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="11" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="PhoneNumber1" VisibleIndex="12" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="PhoneNumber2" VisibleIndex="13" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ContactName" VisibleIndex="14" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ContactRelationship" VisibleIndex="15" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ContactAddress" VisibleIndex="16" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="ContactPhoneNumber" VisibleIndex="17" Visible="False" Width="50px"></dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataCheckColumn FieldName="Disabled" VisibleIndex="21" Width="50px"></dx:GridViewDataCheckColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteCode" VisibleIndex="22" Visible="False" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="SiteName" VisibleIndex="2" Caption="Site" Width="50px">
                                                                                </dx:GridViewDataTextColumn>
                                                                                <dx:GridViewDataTextColumn FieldName="PhotoUrl" ReadOnly="True" Visible="False" VisibleIndex="23"></dx:GridViewDataTextColumn>
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
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                    </TabPages>
                                </dx:ASPxPageControl>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
                <Items>
                </Items>
            </dx:ASPxFormLayout>

            <%-- PRODUCT --%>

            <dx:ASPxPopupControl ID="popupProductAdd" runat="server" AllowDragging="True" ClientInstanceName="popupProductAdd" CloseAction="CloseButton" HeaderText="Add Product"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" Modal="True"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

                <ClientSideEvents PopUp="function(s, e) {EmptyProductAdd();}"></ClientSideEvents>

                <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout4" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>

                            <Items>
                                <dx:LayoutItem Caption="Product Code" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtProductCodeAdd" ID="txtProductCodeAdd" Width="200px">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="ProductAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product Name" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtProductNameAdd" ID="txtProductNameAdd">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="ProductAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="ProductAdd" Width="120px" ID="cmdSubmitProductAdd">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveProductAdd(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>


                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshProductAdd">
                                                            <ClientSideEvents Click="function(s, e) {EmptyProductAdd ();  }"></ClientSideEvents>
                                                        </dx:ASPxButton>


                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl runat="server" ID="PopupConfirmSaveProductAdd" ClientInstanceName="PopupConfirmSaveProductAdd" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout6">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Add" Width="120px" ID="cmdSaveYesProductAdd">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveProductAdd.Hide();}"></ClientSideEvents>
                                                                            </dx:ASPxButton>


                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoProductAdd">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveProductAdd.Hide();}"></ClientSideEvents>
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
                                <dx:LayoutItem ShowCaption="False" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxLabel ID="lblErrMsgProductAdd" runat="server" Font-Bold="true" ForeColor="Red" Text=""></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgProductAdd" runat="server" Font-Bold="true" ForeColor="Blue" Text=""></dx:ASPxLabel>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupProductEdit" runat="server" AllowDragging="True" ClientInstanceName="popupProductEdit" CloseAction="CloseButton" HeaderText="Edit Product" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px"  CloseButtonImage-Url="~/img/close-white.png">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout7" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Product Code" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtProductCodeEdit" runat="server" ClientInstanceName="txtProductCodeEdit" Width="200px">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="ProductEdit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product Name" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtProductNameEdit" runat="server" ClientInstanceName="txtProductNameEdit">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="ProductEdit">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdSubmitProductEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="ProductEdit" Width="120px">
                                                <ClientSideEvents Click="function(s,e){ OnSaveProductEdit(s,e);}" />
                                            </dx:ASPxButton>

                                            <dx:ASPxPopupControl ID="PopupConfirmSaveProductEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveProductEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout8" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesProductEdit" runat="server" Text="Yes" ValidationGroup="ProductEdit" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveProductEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoProductEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveProductEdit.Hide();}" />
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
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgProductEdit" runat="server" Font-Bold="true" ForeColor="Red" Text="">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgProductEdit" runat="server" Font-Bold="true" ForeColor="Blue" Text="">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtProductIDEdit" runat="server" ClientInstanceName="txtProductIDEdit" Width="120px" ClientVisible="false">
                                            </dx:ASPxTextBox>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupProductDelete" runat="server" AllowDragging="True" ClientInstanceName="popupProductDelete" CloseAction="None" HeaderText="Do you want to Delete the Product?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" PopupElementID="cmdSubmitRetrun">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout9" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmProductDeleteYes" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupProductDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmProductDeleteNo" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupProductDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgProductDelete" ForeColor="Red"></dx:ASPxLabel>
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgProductDelete" ForeColor="blue"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtProductIDDelete" runat="server" ClientInstanceName="txtProductIDDelete" Width="120px" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <%-- SITE PRODUCT --%>

            <dx:ASPxPopupControl ID="popupSiteProductAdd" runat="server" AllowDragging="True" ClientInstanceName="popupSiteProductAdd" CloseAction="CloseButton" HeaderText="Add Site Product" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="500px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptySiteProductAdd();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout10" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameSiteProductAdd" runat="server" ClientInstanceName="txtSiteNameSiteProductAdd" ForeColor="Black" Font-Bold="true" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDSiteProductAdd" runat="server" ClientInstanceName="txtSiteIDSiteProductAdd" Text="0" ReadOnly="true" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox runat="server" ID="cboSiteProductProductAdd" ClientInstanceName="cboSiteProductProductAdd" ValueType="System.Int32" DataSourceID="SqlDataSourceProduct" TextField="ProductName" ValueField="ProductID">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitSiteProductAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="SiteProductAdd" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveSiteProductAdd(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshSiteProductAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptySiteProductAdd ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveSiteProductAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveSiteProductAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout11" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesSiteProductAdd" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveSiteProductAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoSiteProductAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveSiteProductAdd.Hide();}" />
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgSiteProductAdd" runat="server" Font-Bold="true" ForeColor="Red" Text="">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgSiteProductAdd" runat="server" Font-Bold="true" ForeColor="Blue" Text="">
                                            </dx:ASPxLabel>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="popupSiteProductDelete" runat="server" AllowDragging="True" ClientInstanceName="popupSiteProductDelete" CloseAction="None" HeaderText="Do you want to Delete the SiteProduct?" Modal="True" PopupElementID="cmdSubmitRetrun" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout28" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmSiteProductDeleteYes" runat="server" Text="Yes" BackColor="#FF3300" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupSiteProductDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmSiteProductDeleteNo" runat="server" AutoPostBack="False" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupSiteProductDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgSiteProductDelete" runat="server" ClientVisible="False" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgSiteProductDelete" runat="server" ClientVisible="False" ForeColor="blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtSiteProductIDDelete" runat="server" ClientInstanceName="txtSiteProductIDDelete" ClientVisible="true" Width="120px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <%--RATE --%>

            <dx:ASPxPopupControl ID="popupRateAdd" runat="server" AllowDragging="True" ClientInstanceName="popupRateAdd" CloseAction="CloseButton" HeaderText="Chang Fuel Rate" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyRateAdd();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout13" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameRateAdd" runat="server" ClientInstanceName="txtSiteNameRateAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="RateAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDRateAdd" runat="server" ClientInstanceName="txtSiteIDRateAdd" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboRateProductAdd" runat="server" ClientInstanceName="cboRateProductAdd" DataSourceID="SqlDataSourceSiteFuelProduct" TextField="ProductName" TextFormatString="{1}" ValueField="ProductID" ValueType="System.Int32">
<%--                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { var item = cboRateProductAdd.GetSelectedItem();   txtCostPriceRateAdd.SetValue( item.GetColumnText(3)); }" />--%>
                                                <Columns>
                                                    <dx:ListBoxColumn FieldName="ProductID" ClientVisible="False"></dx:ListBoxColumn>
                                                    <dx:ListBoxColumn FieldName="ProductName" Caption="Product"></dx:ListBoxColumn>
<%--                                                    <dx:ListBoxColumn FieldName="Rate" ClientVisible="False"></dx:ListBoxColumn>
                                                    <dx:ListBoxColumn FieldName="CostPrice" ClientVisible="False"></dx:ListBoxColumn>--%>
                                                </Columns>
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="RateAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Date">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpRateDateAdd" runat="server" ClientInstanceName="dtpRateDateAdd" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="RateAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" Caption="Selling Price">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.###0" DecimalPlaces="4" ClientInstanceName="txtSellingPriceRateAdd" ID="txtSellingPriceRateAdd">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtSellingPriceRateAdd.GetValue() == 0)  txtSellingPriceRateAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtSellingPriceRateAdd.GetText() == &#39;&#39;)  txtSellingPriceRateAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="RateAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                                <DisabledStyle ForeColor="Black"></DisabledStyle>
                                            </dx:ASPxSpinEdit>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Cost Price" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.###0" DecimalPlaces="4" ClientInstanceName="txtCostPriceRateAdd" ID="txtCostPriceRateAdd">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtCostPriceRateAdd.GetValue() == 0)  txtCostPriceRateAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtCostPriceRateAdd.GetText() == &#39;&#39;)  txtCostPriceRateAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="RateAdd">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                                <DisabledStyle ForeColor="Black"></DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="RateAdd" Width="120px" ID="cmdSubmitRateAdd">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveRateAdd(s,e);}"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshRateAdd">
                                                            <ClientSideEvents Click="function(s, e) {EmptyRateAdd ();  }"></ClientSideEvents>
                                                        </dx:ASPxButton>

                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveRateAdd" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveRateAdd">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout14">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Add" Width="120px" ID="cmdSaveYesRateAdd">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveRateAdd.Hide();}"></ClientSideEvents>
                                                                            </dx:ASPxButton>

                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoRateAdd">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveRateAdd.Hide();}"></ClientSideEvents>
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
                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgRateAdd" ClientInstanceName="lblErrMsgRateAdd" runat="server" Font-Bold="true" ForeColor="Red" Text="" ClientVisible="false"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgRateAdd" ClientInstanceName="lblSuccessMsgRateAdd" runat="server" Font-Bold="true" ForeColor="Blue" Text="" ClientVisible="false"></dx:ASPxLabel>


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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <%-- TANK --%>

            <dx:ASPxPopupControl ID="popupTankAdd" runat="server" AllowDragging="True" ClientInstanceName="popupTankAdd" CloseAction="CloseButton" HeaderText="Add Fuel Tank" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyTankAdd();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout15" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameTankAdd" runat="server" ClientInstanceName="txtSiteNameTankAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDTankAdd" runat="server" ClientInstanceName="txtSiteIDTankAdd" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboTankProductAdd" runat="server" ClientInstanceName="cboTankProductAdd" DataSourceID="SqlDataSourceSiteFuelProduct" TextField="ProductName" ValueField="SiteProductID" ValueType="System.Int32">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="1"></dx:EmptyLayoutItem>

                                <dx:LayoutItem Caption="Tank Code" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ID="txtTankCodeAdd" ClientInstanceName="txtTankCodeAdd"></dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Capacity" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="txtTankCapacityAdd" runat="server" AllowMouseWheel="False" ClientInstanceName="txtTankCapacityAdd" DecimalPlaces="2" DisplayFormatString="#,##0.#0" HorizontalAlign="Right" MaxValue="999999999999999999999" Number="0" Width="150px">
                                                <SpinButtons ShowIncrementButtons="False">
                                                </SpinButtons>
                                                <ClientSideEvents GotFocus="function(s, e) { if (txtTankCapacityAdd.GetValue() == 0)  txtTankCapacityAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtTankCapacityAdd.GetText() == &#39;&#39;)  txtTankCapacityAdd.SetText(&#39;0&#39;);}" />
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle ForeColor="Black">
                                                </DisabledStyle>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitTankAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="TankAdd" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveTankAdd(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshTankAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyTankAdd ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveTankAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveTankAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout16" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesTankAdd" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveTankAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoTankAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveTankAdd.Hide();}" />
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgTankAdd" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgTankAdd" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="popupTankEdit" runat="server" AllowDragging="True" ClientInstanceName="popupTankEdit" CloseAction="CloseButton" HeaderText="Edit Fuel Tank" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyTankEdit();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout18" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameTankEdit" runat="server" ClientInstanceName="txtSiteNameTankEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDTankEdit" runat="server" ClientInstanceName="txtSiteIDTankEdit" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Product" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboTankProductEdit" runat="server" ClientInstanceName="cboTankProductEdit" DataSourceID="SqlDataSourceSiteFuelProduct" TextField="ProductName" ValueField="SiteProductID" ValueType="System.Int32">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tank Code" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtTankCodeEdit" ID="txtTankCodeEdit"></dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>

                                <dx:LayoutItem Caption="Capacity" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="999999999999999999999" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtTankCapacityEdit" ID="txtTankCapacityEdit">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtTankCapacity.GetValue() == 0)  txtTankCapacity.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtTankCapacity.GetText() == &#39;&#39;)  txtTankCapacity.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Edit">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>

                                                <DisabledStyle ForeColor="Black"></DisabledStyle>
                                            </dx:ASPxSpinEdit>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Disabled" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxCheckBox runat="server" CheckState="Unchecked" ID="chkTankDisableEdit" ClientInstanceName="chkTankDisableEdit"></dx:ASPxCheckBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitTankEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="TankEdit" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveTankEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshTankEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyTankEdit ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveTankEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveTankEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout19" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesTankEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveTankEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoTankEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveTankEdit.Hide();}" />
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgTankEdit" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgTankEdit" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtTankIDEdit" runat="server" ClientInstanceName="txtTankIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>

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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupTankDelete" runat="server" AllowDragging="True" ClientInstanceName="popupTankDelete" CloseAction="None" HeaderText="Do you want to Delete the Tank?" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px" PopupElementID="cmdSubmitRetrun">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout29" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmTankDeleteYes" runat="server" Text="Yes" BackColor="#FF3300" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupTankDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmTankDeleteNo" runat="server" AutoPostBack="False" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupTankDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblErrMsgTankDelete" ForeColor="Red"></dx:ASPxLabel>
                                            <dx:ASPxLabel runat="server" ClientVisible="False" ID="lblSuccessMsgTankDelete" ForeColor="blue"></dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtTankIDDelete" runat="server" ClientInstanceName="txtTankIDDelete" Width="120px" ClientVisible="false">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <%-- PUMP --%>

            <dx:ASPxPopupControl ID="popupPumpAdd" runat="server" AllowDragging="True" ClientInstanceName="popupPumpAdd" CloseAction="CloseButton" HeaderText="Add Fuel Pump" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyPumpAdd();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout21" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNamePumpAdd" runat="server" ClientInstanceName="txtSiteNamePumpAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDPumpAdd" runat="server" ClientInstanceName="txtSiteIDPumpAdd" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tank" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboPumpTankAdd" runat="server" ClientInstanceName="cboPumpTankAdd" DataSourceID="SqlDataSourceTank" TextField="TankCode" ValueField="TankID" ValueType="System.Int32">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Pump Code" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox runat="server" ClientInstanceName="txtPumpCodeAdd" ID="txtPumpCodeAdd"></dx:ASPxTextBox>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitPumpAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="PumpAdd" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSavePumpAdd(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshPumpAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyPumpAdd ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSavePumpAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSavePumpAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout22" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesPumpAdd" runat="server" Text="Yes" ValidationGroup="Add" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePumpAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoPumpAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePumpAdd.Hide();}" />
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgPumpAdd" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgPumpAdd" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <dx:ASPxPopupControl ID="popupPumpEdit" runat="server" AllowDragging="True" ClientInstanceName="popupPumpEdit" CloseAction="CloseButton" HeaderText="Edit Fuel Pump" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyPumpEdit();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout23" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNamePumpEdit" runat="server" ClientInstanceName="txtSiteNamePumpEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDPumpEdit" runat="server" ClientInstanceName="txtSiteIDPumpEdit" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tank" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboPumpTankEdit" runat="server" ClientInstanceName="cboPumpTankEdit" DataSourceID="SqlDataSourceTank" TextField="TankCode" ValueField="TankID" ValueType="System.Int32">
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Pump Code" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPumpCodeEdit" runat="server" ClientInstanceName="txtPumpCodeEdit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Disabled" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxCheckBox runat="server" CheckState="Unchecked" ID="chkPumpDisableEdit" ClientInstanceName="chkPumpDisableEdit"></dx:ASPxCheckBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitPumpEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="PumpEdit" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSavePumpEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshPumpEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyPumpEdit ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSavePumpEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSavePumpEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout24" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesPumpEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePumpEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoPumpEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSavePumpEdit.Hide();}" />
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
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgPumpEdit" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgPumpEdit" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtPumpIDEdit" runat="server" ClientInstanceName="txtPumpIDEdit" ClientVisible="False">
                                            </dx:ASPxTextBox>

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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupPumpDelete" runat="server" AllowDragging="True" ClientInstanceName="popupPumpDelete" CloseAction="None" HeaderText="Do you want to Delete the Pump?" Modal="True" PopupElementID="cmdSubmitRetrun" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout30" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmPumpDeleteYes" runat="server" BackColor="#FF3300" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupPumpDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmPumpDeleteNo" runat="server" AutoPostBack="False" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupPumpDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgPumpDelete" runat="server" ClientVisible="False" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgPumpDelete" runat="server" ClientVisible="False" ForeColor="blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtPumpIDDelete" runat="server" ClientInstanceName="txtPumpIDDelete" ClientVisible="false" Width="120px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <%-- ATTENDANT --%>


            <dx:ASPxPopupControl ID="popupAttendantView" runat="server" AllowDragging="True" ClientInstanceName="popupAttendantView" CloseAction="CloseButton" HeaderText="View Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyAttendantView();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout31" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxButton ID="cmdPrintAttendant" runat="server" Text="Print Details" BackColor="#0066CC" Width="150px">
                                                <ClientSideEvents Click="function(s, e) {popupAttendantView.Hide();SetTarget();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxImage ID="picPictureView" runat="server" ClientInstanceName="picPictureView" Height="150px" ShowLoadingImage="True" Width="150px">
                                                <Border BorderStyle="Solid" BorderWidth="2px" />
                                            </dx:ASPxImage>
                                            <dx:ASPxTextBox ID="txtAttendantIDView" runat="server" ClientEnabled="False" ClientInstanceName="txtAttendantIDView">
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Site" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameAttendantView" runat="server" ClientEnabled="False" ClientInstanceName="txtSiteNameAttendantView" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDAttendantView" runat="server" ClientEnabled="False" ClientInstanceName="txtSiteIDAttendantView" ClientVisible="false" ReadOnly="true" Text="0">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Staff ID" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtStaffIDView" runat="server" ClientEnabled="False" ClientInstanceName="txtStaffIDView" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="First Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtFirstNameView" runat="server" ClientEnabled="False" ClientInstanceName="txtFirstNameView">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Other Names" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtOtherNamesView" runat="server" ClientEnabled="False" ClientInstanceName="txtOtherNamesView">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Gender" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtGenderView" runat="server" ClientEnabled="False" ClientInstanceName="txtGenderView">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Date of Birth" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtDateOfBirthView" runat="server" ClientEnabled="False" ClientInstanceName="txtDateOfBirthView" DisplayFormatString="dd-MMM-yyyy">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtAddressView" runat="server" ClientEnabled="False" ClientInstanceName="txtAddressView" Width="100%">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number1" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber1View" runat="server" ClientEnabled="False" ClientInstanceName="txtPhoneNumber1View">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number2" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber2View" runat="server" ClientEnabled="False" ClientInstanceName="txtPhoneNumber2View">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactNameView" runat="server" ClientEnabled="False" ClientInstanceName="txtContactNameView">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Relationship" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactRelationView" runat="server" ClientEnabled="False" ClientInstanceName="txtContactRelationView">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Address" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtContactAddressView" runat="server" ClientEnabled="False" ClientInstanceName="txtContactAddressView" Width="100%">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactPhoneNumberView" runat="server" ClientEnabled="False" ClientInstanceName="txtContactPhoneNumberView">
                                                <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                                </DisabledStyle>
                                            </dx:ASPxTextBox>
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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupAttendantDelete" runat="server" AllowDragging="True" ClientInstanceName="popupAttendantDelete" CloseAction="None" HeaderText="Do you want to Delete the Attendant?" Modal="True" PopupElementID="cmdSubmitRetrun" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <HeaderStyle HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout34" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmAttendantDeleteYes" runat="server" BackColor="#FF3300" Text="Yes" ValidationGroup="Add" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupAttendantDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxButton ID="cmdConfirmAttendantDeleteNo" runat="server" AutoPostBack="False" Text="No" Width="120px">
                                                <ClientSideEvents Click="function(s, e) {popupAttendantDelete.Hide();}" />
                                            </dx:ASPxButton>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAttendantDelete" runat="server" ClientVisible="False" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAttendantDelete" runat="server" ClientVisible="False" ForeColor="blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtAttendantIDDelete" runat="server" ClientInstanceName="txtAttendantIDDelete" ClientVisible="false" Width="120px">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupAttendantAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAttendantAdd" CloseAction="CloseButton" HeaderText="Add Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                <ClientSideEvents PopUp="function(s, e) {EmptyAttendantAdd();}" />
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout26" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtSiteNameAttendantAdd" runat="server" ClientInstanceName="txtSiteNameAttendantAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                            </dx:ASPxTextBox>
                                            <dx:ASPxTextBox ID="txtSiteIDAttendantAdd" runat="server" ClientInstanceName="txtSiteIDAttendantAdd" ClientVisible="false" ReadOnly="true" Text="0">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Staff ID" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtStaffIDAdd" runat="server" ClientInstanceName="txtStaffIDAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>

                                <dx:LayoutItem Caption="First Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtFirstNameAdd" runat="server" ClientInstanceName="txtFirstNameAdd">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Other Names" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtOtherNamesAdd" runat="server" ClientInstanceName="txtOtherNamesAdd">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Gender" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboGenderAdd" runat="server" ClientInstanceName="cboGenderAdd">
                                                <Items>
                                                    <dx:ListEditItem Text="M" Value="M"></dx:ListEditItem>
                                                    <dx:ListEditItem Text="F" Value="F"></dx:ListEditItem>
                                                </Items>
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>

                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Date of Birth" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpDateOfBirthAdd" runat="server" ClientInstanceName="dtpDateOfBirthAdd" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtAddressAdd" runat="server" ClientInstanceName="txtAddressAdd">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number1" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber1Add" runat="server" ClientInstanceName="txtPhoneNumber1Add">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number2" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber2Add" runat="server" ClientInstanceName="txtPhoneNumber2Add">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactNameAdd" runat="server" ClientInstanceName="txtContactNameAdd">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Relationship" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactRelationAdd" runat="server" ClientInstanceName="txtContactRelationAdd">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Address" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtContactAddressAdd" runat="server" ClientInstanceName="txtContactAddressAdd">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactPhoneNumberAdd" runat="server" ClientInstanceName="txtContactPhoneNumberAdd">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>
                                <dx:LayoutGroup Caption="Picture Upload" SettingsItemCaptions-Location="Top" ColSpan="1" ColumnSpan="1">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" ForeColor="#003399"></Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <dx:ASPxImage ID="picPictureAdd" ClientInstanceName="picPictureAdd" runat="server" ShowLoadingImage="true" Border-BorderStyle="Solid" Border-BorderWidth="2px" Width="150px" Height="150px">
                                                                    <Border BorderStyle="Solid" BorderWidth="2px" />
                                                                </dx:ASPxImage>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <asp:FileUpload ID="FileUploadPictureAdd" runat="server" onchange="LoadPictureAdd(this);" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>

                                    <SettingsItemCaptions Location="Top"></SettingsItemCaptions>
                                </dx:LayoutGroup>
                        <dx:LayoutGroup Caption="Opening Balance" ColSpan="1">
                            <GroupBoxStyle>
                                <Caption Font-Bold="True" ForeColor="#0D6B68"></Caption>
                            </GroupBoxStyle>
                            <CellStyle Font-Bold="False"></CellStyle>
                            <Items>
                                <dx:LayoutItem Caption="Balance Date"  ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit runat="server" EditFormat="Custom" EditFormatString="dd-MM-yyyy" DisplayFormatString="dd-MMM-yyyy" ClientInstanceName="dtpBalanceDateAdd" ID="dtpBalanceDateAdd">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Balance Type"  ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32"  ClientInstanceName="cboBalanceTypeAdd" ID="cboBalanceTypeAdd">
                                                <Items>
                                                    <dx:ListEditItem Text="Debit" Value="1"></dx:ListEditItem>
                                                    <dx:ListEditItem Text="Credit" Value="2"></dx:ListEditItem>
                                                    <dx:ListEditItem Text="Nill" Value="3"></dx:ListEditItem>
                                                </Items>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>

                                            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [TransactionType]" ID="SqlDataSourceBalanceTypeAdd"></asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Amount"  ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit runat="server" MaxValue="10000000000000000000000000000" DecimalPlaces="2" Number="0" AllowMouseWheel="False" HorizontalAlign="Right" Width="150px" DisplayFormatString="#,##0.#0" ClientInstanceName="txtBalanceAmountAdd" ID="txtBalanceAmountAdd">
                                                <SpinButtons ShowIncrementButtons="False"></SpinButtons>

                                                <ClientSideEvents GotFocus="function(s, e) { if (txtBalanceAmountAdd.GetValue() == 0)  txtBalanceAmountAdd.SetText(&#39;&#39;);}" LostFocus="function(s, e) { if (txtBalanceAmountAdd.GetText() == &#39;&#39;)  txtBalanceAmountAdd.SetText(&#39;0&#39;);}"></ClientSideEvents>

                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom"></ValidationSettings>
                                            </dx:ASPxSpinEdit>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>


                            </Items>
                        </dx:LayoutGroup>

                                <dx:LayoutItem ColSpan="1" ColumnSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitAttendantAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="AttendantAdd" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveAttendantAdd(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshAttendantAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyAttendantAdd ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveAttendantAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAttendantAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout27" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesAttendantAdd" runat="server" Text="Yes" ValidationGroup="AttendantAdd" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAttendantAdd.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoAttendantAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAttendantAdd.Hide();}" />
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
                                <dx:LayoutItem ColSpan="1" ColumnSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAttendantAdd" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAttendantAdd" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>

                                            <dx:ASPxTextBox ID="txtAttendantTransactionCode" runat="server" ClientInstanceName="txtAttendantTransactionCode" ClientVisible="false">
                                            </dx:ASPxTextBox>

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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupAttendantEdit" runat="server" AllowDragging="True" ClientInstanceName="popupAttendantEdit" CloseAction="CloseButton" HeaderText="Edit Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
<%--                <ClientSideEvents PopUp="function(s, e) {EmptyAttendantEdit();}" />--%>
                <HeaderStyle BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" HorizontalAlign="Center" />
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <dx:ASPxFormLayout ID="ASPxFormLayout32" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                            </SettingsAdaptivity>
                            <Items>
                                <dx:LayoutItem Caption="Site" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceSiteAttendant" TextField="SiteName" ValueField="SiteID" ClientInstanceName="cboSiteAttendantEdit" ID="cboSiteAttendantEdit">
                                                <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="LoadSite">
                                                    <RequiredField IsRequired="True"></RequiredField>
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                            <dx:ASPxLabel ID="lblAttendantIDEdit" ClientInstanceName="lblAttendantIDEdit" runat="server" Font-Bold="True" ForeColor="Red" ClientVisible="false">
                                            </dx:ASPxLabel>

                                            <%--                                    <dx:ASPxTextBox ID="txtSiteNameAttendantEdit" runat="server" ClientInstanceName="txtSiteNameAttendantEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                    </dx:ASPxTextBox>
                                    <dx:ASPxTextBox ID="txtSiteIDAttendantEdit" runat="server" ClientInstanceName="txtSiteIDAttendantEdit" ClientVisible="false" ReadOnly="true" Text="0">
                                    </dx:ASPxTextBox>--%>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Staff ID" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtStaffIDEdit" runat="server" ClientInstanceName="txtStaffIDEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="First Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtFirstNameEdit" runat="server" ClientInstanceName="txtFirstNameEdit">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Other Names" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtOtherNamesEdit" runat="server" ClientInstanceName="txtOtherNamesEdit">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Gender" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cboGenderEdit" runat="server" ClientInstanceName="cboGenderEdit">
                                                <Items>
                                                    <dx:ListEditItem Text="M" Value="M" />
                                                    <dx:ListEditItem Text="F" Value="F" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Date of Birth" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="dtpDateOfBirthEdit" runat="server" ClientInstanceName="dtpDateOfBirthEdit" DisplayFormatString="dd-MMM-yyyy" EditFormat="Custom" EditFormatString="dd-MM-yyyy">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtAddressEdit" runat="server" ClientInstanceName="txtAddressEdit">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number1" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber1Edit" runat="server" ClientInstanceName="txtPhoneNumber1Edit">
                                                <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditAttendant">
                                                    <RequiredField IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number2" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtPhoneNumber2Edit" runat="server" ClientInstanceName="txtPhoneNumber2Edit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Name" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactNameEdit" runat="server" ClientInstanceName="txtContactNameEdit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Relationship" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactRelationEdit" runat="server" ClientInstanceName="txtContactRelationEdit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Contact Address" ColSpan="1" RowSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="txtContactAddressEdit" runat="server" ClientInstanceName="txtContactAddressEdit">
                                            </dx:ASPxMemo>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Phone Number" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txtContactPhoneNumberEdit" runat="server" ClientInstanceName="txtContactPhoneNumberEdit">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>


                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Disabled" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxCheckBox runat="server" CheckState="Unchecked" ID="chkAttendantDisableEdit" ClientInstanceName="chkAttendantDisableEdit"></dx:ASPxCheckBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>

                                </dx:LayoutItem>

                                <dx:LayoutGroup Caption="Picture Upload" ColSpan="2" ColumnSpan="2" SettingsItemCaptions-Location="Top">
                                    <GroupBoxStyle>
                                        <Caption Font-Bold="True" ForeColor="#003399">
                                        </Caption>
                                    </GroupBoxStyle>
                                    <Items>
                                        <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <dx:ASPxImage ID="picPictureEdit" runat="server" Border-BorderStyle="Solid" Border-BorderWidth="2px" ClientInstanceName="picPictureEdit" Height="150px" ShowLoadingImage="true" Width="150px">
                                                                    <Border BorderStyle="Solid" BorderWidth="2px" />
                                                                </dx:ASPxImage>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="auto-style1">
                                                                <asp:FileUpload ID="FileUploadPictureEdit" runat="server" onchange="LoadPictureEdit(this);" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                    <SettingsItemCaptions Location="Top" />
                                </dx:LayoutGroup>
                                <dx:LayoutItem ColSpan="1" ColumnSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 130px">
                                                        <dx:ASPxButton ID="cmdSubmitAttendantEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="AttendantEdit" Width="120px">
                                                            <ClientSideEvents Click="function(s,e){ OnSaveAttendantEdit(s,e);}" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="cmdRefreshAttendantEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                            <ClientSideEvents Click="function(s, e) {EmptyAttendantEdit ();  }" />
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                            </table>
                                            <dx:ASPxPopupControl ID="PopupConfirmSaveAttendantEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAttendantEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                                <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ContentCollection>
                                                    <dx:PopupControlContentControl runat="server">
                                                        <dx:ASPxFormLayout ID="ASPxFormLayout33" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                            <Items>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveYesAttendantEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAttendantEdit.Hide();}" />
                                                                            </dx:ASPxButton>
                                                                        </dx:LayoutItemNestedControlContainer>
                                                                    </LayoutItemNestedControlCollection>
                                                                </dx:LayoutItem>
                                                                <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                                    <LayoutItemNestedControlCollection>
                                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                                            <dx:ASPxButton ID="cmdSaveNoAttendantEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                                <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAttendantEdit.Hide();}" />
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
                                <dx:LayoutItem ColSpan="1" ColumnSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="lblErrMsgAttendantEdit" runat="server" Font-Bold="True" ForeColor="Red">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblSuccessMsgAttendantEdit" runat="server" Font-Bold="True" ForeColor="Blue">
                                            </dx:ASPxLabel>
                                            <dx:ASPxTextBox ID="txtAttendantIDEdit" runat="server" ClientEnabled="True" ClientInstanceName="txtAttendantIDEdit" ClientVisible="false" ReadOnly="true" >
                                            </dx:ASPxTextBox>

                                            <dx:ASPxTextBox ID="txtAttendantIDEdit1" runat="server" ClientEnabled="True" ClientInstanceName="txtAttendantIDEdit1" ClientVisible="false" ReadOnly="true" >
                                            </dx:ASPxTextBox>

                                            <dx:ASPxTextBox ID="txtAttendantID" runat="server" ClientInstanceName="txtAttendantID">
                                            </dx:ASPxTextBox>

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
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>



            <dx:ASPxTextBox ID="txtSiteSearch" runat="server" AutoPostBack="true" ClientVisible="false" ClientInstanceName="txtSiteSearch" Text="0">
            </dx:ASPxTextBox>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceProduct" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [FuelProducts] WHERE ProductID >0 ORDER BY ProductName"></asp:SqlDataSource>




            <asp:SqlDataSource ID="SqlDataSourceSiteFuelProduct" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_SiteFuelProducts] WHERE ([SiteID] = @SiteID) ORDER BY [ProductName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM [View_FuelRate] WHERE ([SiteID] = @SiteID) ORDER BY [ProductName]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceTank" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_FuelTanks WHERE ([SiteID] = @SiteID) ORDER BY ProductName,TankCode">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourcePump" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_FuelPumps WHERE ([SiteID] = @SiteID) ORDER BY ProductName,PumpCode">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSourceAttendant" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_FuelAttendants WHERE ([SiteID] = @SiteID) ORDER BY AttendantName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
   <%--     </ContentTemplate>
    </asp:UpdatePanel>--%>

        <asp:SqlDataSource ID="SqlDataSourceSiteAttendant" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
