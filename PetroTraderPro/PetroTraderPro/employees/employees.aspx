<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="employees.aspx.vb" Inherits="PetroTraderPro.employees" %>

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
            EmptyAdd();
            popupAdd.Show();
        };

        // Employee //


        function EmptyEmployeeAdd() {
            GenerateEmployeeTransCode();
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
            dtpBalanceDateAdd.SetText("");
            cboBalanceTypeAdd.SetSelectedIndex(-1);
            txtBalanceAmountAdd.SetValue(0);

            picPictureAdd.SetHeight(150);
            picPictureAdd.SetWidth(150);

        };


        function EmptyEmployeeView() {
            txtEmployeeIDView.SetText("0");
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
        function EmptyEmployeeEdit() {
            cboSiteEmployeeEdit.SetSelectedIndex(-1);
            txtEmployeeID.SetText("0");
            txtEmployeeIDEdit.SetText("0");
            lblEmployeeIDEdit.SetText("0");
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
            chkEmployeeDisableEdit.SetChecked(false);

        };


        function OnSaveEmployeeAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveEmployeeAdd.Show();
            }
        };


        function OnSaveEmployeeEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveEmployeeEdit.Show();
            }
        };
        function getEmployeeButtonClick(s, e) {
            //alert('Selected Row Index is ' + e.visibleIndex);
            if (e.buttonID === "cmdViewEmployee") {
                GridViewEmployee.GetRowValues(e.visibleIndex, 'EmployeeID;SiteID;EmployeeCode;FirstName;OtherNames;EmployeeName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getViewEmployeeRowValues);
            } else if (e.buttonID === "cmdEditEmployee") {
                GridViewEmployee.GetRowValues(e.visibleIndex, 'EmployeeID;SiteID;EmployeeCode;FirstName;OtherNames;EmployeeName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getEditEmployeeRowValues);
            } else if (e.buttonID === "cmdDeleteEmployee") {
                GridViewEmployee.GetRowValues(e.visibleIndex, 'EmployeeID;SiteID;EmployeeCode;FirstName;OtherNames;EmployeeName;Gender;BirthDate;Address;PhoneNumber1;PhoneNumber2;ContactName;ContactRelationship;ContactAddress;ContactPhoneNumber;Disabled;SiteCode;SiteName;PhotoUrl;Disabled', getDeleteEmployeeRowValues);
            };

        };


        function getViewEmployeeRowValues(values) {
            popupEmployeeView.Show();
            EmptyEmployeeView();

            txtEmployeeIDView.SetText(values[0]);
            txtEmployeeIDView.SetText(values[0]);
            txtEmployeeID.SetText(values[0]);

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
        function getEditEmployeeRowValues(values) {
            popupEmployeeEdit.Show();
            //EmptyEmployeeEdit();

            txtEmployeeID.SetText(values[0]);
            //txtEmployeeIDEdit.SetText(values["EmployeeID"]);
            cboSiteEmployeeEdit.SetValue(values[1]);
            //lblEmployeeIDEdit.SetText(values[0]);

            //sessionStorage.setItem("", values[0]);
            //Session["EmployeeID"] = values[0];
            //txtEmployeeIDEdit.SetText(values[0]);
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
            //lblEmployeeIDEdit.SetText(values[0]);
            chkEmployeeDisableEdit.SetValue(values[19]);

            //txtEmployeeIDEdit.SetText(values[0]);

            //    picPictureEdit.SetHeight(150);
            //    picPictureEdit.SetWidth(150);
        };

        function getDeleteEmployeeRowValues(values) {
            popupEmployeeDelete.Show();
            txtEmployeeIDDelete.SetText("0");

            txtEmployeeIDDelete.SetText(values[0]);
        };


        function EmployeeLoadAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                popupEmployeeAdd.Show();
                EmptyEmployeeAdd();
            }
        };
        function GenerateEmployeeTransCode() {
            let text = Math.random().toString();
            txtEmployeeTransactionCode.SetText(text.replace('.', ''));
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
                    <h2 style="color: #0D6B68; font-weight: bold; font-size: x-large;">Employee Setup</h2>
                </Template>
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>

    <dx:ASPxFormLayout ID="ASPxFormLayout5" runat="server" Width="100%" ColCount="5" ColumnCount="5">
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

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout25" runat="server">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600">
        </SettingsAdaptivity>
        <Items>
            <dx:LayoutItem ColSpan="1" HorizontalAlign="Left" ShowCaption="False">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton ID="cmdAddEmployee" runat="server" ClientInstanceName="cmdAddEmployee" AutoPostBack="False" Text="Add New" ValidationGroup="LoadSite" Width="120px">
                            <ClientSideEvents Click="function(s, e) { EmployeeLoadAdd();}" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxGridView ID="GridViewEmployee" runat="server" AutoGeneEmployeeColumns="False" AutoGenerateColumns="False" ClientInstanceName="GridViewEmployee" DataSourceID="SqlDataSourceEmployee" KeyFieldName="AttendantID" Width="100%">
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

                            <ClientSideEvents CustomButtonClick="getEmployeeButtonClick" />

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

    <dx:ASPxPopupControl ID="popupEmployeeAdd" runat="server" AllowDragging="True" ClientInstanceName="popupEmployeeAdd" CloseAction="CloseButton" HeaderText="Add Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <ClientSideEvents PopUp="function(s, e) {EmptyEmployeeAdd();}" />
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
                                    <dx:ASPxTextBox ID="txtSiteNameEmployeeAdd" runat="server" ClientInstanceName="txtSiteNameEmployeeAdd" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                    </dx:ASPxTextBox>
                                    <dx:ASPxTextBox ID="txtSiteIDEmployeeAdd" runat="server" ClientInstanceName="txtSiteIDEmployeeAdd" ClientVisible="false" ReadOnly="true" Text="0">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddEmployee">
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
                                    <dx:ASPxMemo ID="txtAddressAdd" runat="server" ClientInstanceName="txtAddressAdd" Width="100%">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="AddEmployee">
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
                        <dx:LayoutGroup Caption="Picture Upload" SettingsItemCaptions-Location="Top" ColSpan="1">
                            <GroupBoxStyle>
                                <Caption Font-Bold="True" ForeColor="#0D6B68"></Caption>
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
                                                <dx:ASPxButton ID="cmdSubmitEmployeeAdd" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="EmployeeAdd" Width="120px">
                                                    <ClientSideEvents Click="function(s,e){ OnSaveEmployeeAdd(s,e);}" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="cmdRefreshEmployeeAdd" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                    <ClientSideEvents Click="function(s, e) {EmptyEmployeeAdd ();  }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl ID="PopupConfirmSaveEmployeeAdd" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEmployeeAdd" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout ID="ASPxFormLayout27" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveYesEmployeeAdd" runat="server" Text="Yes" ValidationGroup="EmployeeAdd" Width="120px">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEmployeeAdd.Hide();}" />
                                                                    </dx:ASPxButton>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveNoEmployeeAdd" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEmployeeAdd.Hide();}" />
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
                                    <dx:ASPxLabel ID="lblErrMsgEmployeeAdd" runat="server" Font-Bold="True" ForeColor="Red">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEmployeeAdd" runat="server" Font-Bold="True" ForeColor="Blue">
                                    </dx:ASPxLabel>

                                    <dx:ASPxTextBox ID="txtEmployeeTransactionCode" runat="server" ClientInstanceName="txtEmployeeTransactionCode" ClientVisible="false">
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

    <dx:ASPxPopupControl ID="popupEmployeeView" runat="server" AllowDragging="True" ClientInstanceName="popupEmployeeView" CloseAction="CloseButton" HeaderText="View Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <ClientSideEvents PopUp="function(s, e) {EmptyEmployeeView();}" />
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

                                    <dx:ASPxButton ID="cmdPrintEmployee" runat="server" Text="Print Details" BackColor="#0066CC" Width="150px">
                                        <ClientSideEvents Click="function(s, e) {popupEmployeeView.Hide();SetTarget();}" />
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
                                    <dx:ASPxTextBox ID="txtEmployeeIDView" runat="server" ClientEnabled="False" ClientInstanceName="txtEmployeeIDView">
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Site" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtSiteNameEmployeeView" runat="server" ClientEnabled="False" ClientInstanceName="txtSiteNameEmployeeView" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <DisabledStyle Font-Bold="True" ForeColor="#0D6B68">
                                        </DisabledStyle>
                                    </dx:ASPxTextBox>
                                    <dx:ASPxTextBox ID="txtSiteIDEmployeeView" runat="server" ClientEnabled="False" ClientInstanceName="txtSiteIDEmployeeView" ClientVisible="false" ReadOnly="true" Text="0">
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

    <dx:ASPxPopupControl ID="popupEmployeeDelete" runat="server" AllowDragging="True" ClientInstanceName="popupEmployeeDelete" CloseAction="None" HeaderText="Do you want to Delete the Attendant" Modal="True" PopupElementID="cmdSubmitRetrun" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <HeaderStyle HorizontalAlign="Center" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout34" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="cmdConfirmEmployeeDeleteYes" runat="server" BackColor="#FF3300" Text="Yes" ValidationGroup="Add" Width="120px">
                                        <ClientSideEvents Click="function(s, e) {popupEmployeeDelete.Hide();}" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="cmdConfirmEmployeeDeleteNo" runat="server" AutoPostBack="False" Text="No" Width="120px">
                                        <ClientSideEvents Click="function(s, e) {popupEmployeeDelete.Hide();}" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblErrMsgEmployeeDelete" runat="server" ClientVisible="False" ForeColor="Red">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEmployeeDelete" runat="server" ClientVisible="False" ForeColor="blue">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtEmployeeIDDelete" runat="server" ClientInstanceName="txtEmployeeIDDelete" ClientVisible="false" Width="120px">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxPopupControl ID="popupEmployeeEdit" runat="server" AllowDragging="True" ClientInstanceName="popupEmployeeEdit" CloseAction="CloseButton" HeaderText="Edit Fuel Attendant" Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="900px">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
        <%--                <ClientSideEvents PopUp="function(s, e) {EmptyEmployeeEdit();}" />--%>
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
                                    <dx:ASPxComboBox runat="server" ValueType="System.Int32" DataSourceID="SqlDataSourceSiteEmployee" TextField="SiteName" ValueField="SiteID" ClientInstanceName="cboSiteEmployeeEdit" ID="cboSiteEmployeeEdit">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="LoadSite">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                    <dx:ASPxLabel ID="lblEmployeeIDEdit" ClientInstanceName="lblEmployeeIDEdit" runat="server" Font-Bold="True" ForeColor="Red" ClientVisible="false">
                                    </dx:ASPxLabel>

                                    <%--                                    <dx:ASPxTextBox ID="txtSiteNameEmployeeEdit" runat="server" ClientInstanceName="txtSiteNameEmployeeEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                    </dx:ASPxTextBox>
                                    <dx:ASPxTextBox ID="txtSiteIDEmployeeEdit" runat="server" ClientInstanceName="txtSiteIDEmployeeEdit" ClientVisible="false" ReadOnly="true" Text="0">
                                    </dx:ASPxTextBox>--%>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>


                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Staff ID" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="txtStaffIDEdit" runat="server" ClientInstanceName="txtStaffIDEdit" Font-Bold="true" ForeColor="Black" ReadOnly="true">
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditEmployee">
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
                                        <ValidationSettings Display="Dynamic" ErrorDisplayMode="None" ErrorTextPosition="Bottom" ValidationGroup="EditEmployee">
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
                                    <dx:ASPxCheckBox runat="server" CheckState="Unchecked" ID="chkEmployeeDisableEdit" ClientInstanceName="chkEmployeeDisableEdit"></dx:ASPxCheckBox>

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
                                                <dx:ASPxButton ID="cmdSubmitEmployeeEdit" runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="EmployeeEdit" Width="120px">
                                                    <ClientSideEvents Click="function(s,e){ OnSaveEmployeeEdit(s,e);}" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="cmdRefreshEmployeeEdit" runat="server" AutoPostBack="False"  Text="Refresh" Width="120px">
                                                    <ClientSideEvents Click="function(s, e) {EmptyEmployeeEdit ();  }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl ID="PopupConfirmSaveEmployeeEdit" runat="server" AllowDragging="True" ClientInstanceName="PopupConfirmSaveEmployeeEdit" CloseAction="None" HeaderText="Confirm Save" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowCloseButton="False" Width="300px">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout ID="ASPxFormLayout33" runat="server" ColCount="2" ColumnCount="2" Width="100%">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveYesEmployeeEdit" runat="server" Text="Yes" ValidationGroup="Edit" Width="120px">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEmployeeEdit.Hide();}" />
                                                                    </dx:ASPxButton>
                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ColSpan="1" HorizontalAlign="Center" ShowCaption="False">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton ID="cmdSaveNoEmployeeEdit" runat="server" AutoPostBack="False" BackColor="#FF3300" Text="No" Width="120px">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveEmployeeEdit.Hide();}" />
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
                                    <dx:ASPxLabel ID="lblErrMsgEmployeeEdit" runat="server" Font-Bold="True" ForeColor="Red">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblSuccessMsgEmployeeEdit" runat="server" Font-Bold="True" ForeColor="Blue">
                                    </dx:ASPxLabel>
                                    <dx:ASPxTextBox ID="txtEmployeeIDEdit" runat="server" ClientEnabled="True" ClientInstanceName="txtEmployeeIDEdit" ClientVisible="false" ReadOnly="true">
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="txtEmployeeIDEdit1" runat="server" ClientEnabled="True" ClientInstanceName="txtEmployeeIDEdit1" ClientVisible="false" ReadOnly="true">
                                    </dx:ASPxTextBox>

                                    <dx:ASPxTextBox ID="txtEmployeeID" runat="server" ClientInstanceName="txtEmployeeID">
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
    <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT * FROM View_FuelAttendants WHERE ([SiteID] = @SiteID) ORDER BY AttendantName">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSiteSearch" DefaultValue="-1" Name="SiteID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--     </ContentTemplate>
    </asp:UpdatePanel>--%>

    <asp:SqlDataSource ID="SqlDataSourceSiteEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:PetroTraderConnectionString %>" SelectCommand="SELECT [SiteID], [SiteName] FROM [Sites] WHERE SiteID>0 AND SiteID IN (SELECT SiteID FROM UserSites WHERE UserID =@UserID) ORDER BY SiteName">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" DefaultValue="0" Name="UserID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

