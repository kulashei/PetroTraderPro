<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="userGroupRoles.aspx.vb" Inherits="PetroTraderPro.userGroupRoles" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/GridView.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/GridView.js") %>'></script>
    <script src="../Content/myjs/numeral.js"></script>
    <script src="../Content/myjs/moment.js"></script>

    <script type="text/javascript">

        function EmptyAdd() {
            txtUserGroupAdd.SetText("");
        };
        function EmptyEdit() {
            txtSiteCodeEdit.SetText("");
            dtpRegDateEdit.SetText("");
            txtSiteNameEdit.SetText("");
            txtAddressEdit.SetText("");
            txtCompanyEdit.SetText("");
            txtBusinessInfoEdit.SetText("");
        };


        function OnSaveAdd(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveAdd.Show();
            }
        };

        function OnSaveEdit(s, e) {
            ASPxClientEdit.ValidateEditorsInContainer(null);
            if (ASPxClientEdit.AreEditorsValid()) {
                PopupConfirmSaveEdit.Show();
            }
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
                    <h1 style="color: #0D6B68; font-weight: bold; font-size: large;">User Groups</h1>
                </Template>
            </dx:MenuItem>
            <dx:MenuItem Name="New" Text="New User Group" Alignment="Right" AdaptivePriority="2" Visible="false">
                <Image Url="../img/add-100.png" />
            </dx:MenuItem>
        </Items>
    </dx:ASPxMenu>
    <dx:ASPxPanel runat="server" ID="FilterPanel" ClientInstanceName="filterPanel"
        Collapsible="true" CssClass="filter-panel">
        <SettingsCollapsing ExpandEffect="Slide" AnimationType="Slide" ExpandButton-Visible="false" />
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxButtonEdit runat="server" ID="SearchButtonEdit" ClientInstanceName="searchButtonEdit" ClearButton-DisplayMode="Always" Caption="Search" Width="100%" />
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents Expanded="onFilterPanelExpanded" Collapsed="adjustPageControls" />
    </dx:ASPxPanel>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" ColCount="4" ColumnCount="4" Style="text-align: center">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
        </SettingsAdaptivity>

        <Items>
            <dx:LayoutItem ShowCaption="False" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton runat="server" ID="cmdAddUserGroup" AutoPostBack="False" ClientInstanceName="cmdAddUserGroup" Text="Add User Groups" Width="150px">
                            <ClientSideEvents Click="function(s, e) {popupAdd.Show(); EmptyAdd();}" />
                        </dx:ASPxButton>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2"></dx:EmptyLayoutItem>
            <dx:LayoutItem ColSpan="2" Caption="User Group" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cboUserGroupRole" runat="server" AutoPostBack="true" ClientInstanceName="cboUserGroupRole" ValueType="System.Int32" DataSourceID="SqlDataSourceUserGroups" TextField="UserGroup" ValueField="UserGroupID">
                            <ClientSideEvents ValueChanged="function(s, e) {
                                         if (cboUserGroupRole.GetSelectedIndex()==-1) {
                                                txtUserGroupRole.SetValue(0);
                                            } else if (cboUserGroupRole.GetSelectedIndex()!=-1) {
                                                txtUserGroupRole.SetValue(cboUserGroupRole.GetValue());
                                            };
                                            }"></ClientSideEvents>

<%--                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Role">
                                <RequiredField IsRequired="True"></RequiredField>
                            </ValidationSettings>--%>
                        </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ColSpan="2" Caption="Parent Role" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cboUserParentRoles" runat="server" AutoPostBack="true" ClientInstanceName="cboUserParentRoles" ValueType="System.Int32" DataSourceID="SqlDataSourceUserParentRole" TextField="ParentRole" ValueField="ParentRoleID">
                            <ClientSideEvents ValueChanged="function(s, e) {
                                           if (cboUserParentRoles.GetSelectedIndex()==-1) {
                                                txtUserParentRoles.SetValue(0);
                                            } else if (cboUserParentRoles.GetSelectedIndex()!=-1) {
                                                txtUserParentRoles.SetValue(cboUserParentRoles.GetValue());
                                            };
  
                                            }"></ClientSideEvents>

<%--                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Role">
                                <RequiredField IsRequired="True"></RequiredField>
                            </ValidationSettings>--%>
                        </dx:ASPxComboBox>

                        <asp:SqlDataSource runat="server" ID="SqlDataSourceUserParentRole" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM [UserParentRole]"></asp:SqlDataSource>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ColSpan="4" ColumnSpan="4" HorizontalAlign="Center" ShowCaption="False">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxGridView ID="GridViewGroupRoles" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridViewGroupRoles" DataSourceID="SqlDataSourceUserGroupRole" EnableTheming="True" KeyFieldName="UserGroupRoleID" Width="100%">
                            <SettingsPager Mode="ShowAllRecords" PageSize="20">
                            </SettingsPager>
                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <Settings VerticalScrollableHeight="450" VerticalScrollBarMode="Visible" />
                            <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                            <SettingsCommandButton>
                                <EditButton ButtonType="Button" RenderMode="Button">
                                    <Styles>
                                        <Style BackColor="#FF9933">
                                        </Style>
                                    </Styles>
                                </EditButton>
                            </SettingsCommandButton>
                            <SettingsDataSecurity AllowDelete="False" AllowInsert="False" />
                            <SettingsPopup>
                                <EditForm Modal="True" HorizontalAlign="Center" VerticalAlign="Above">
                                </EditForm>
                                <FilterControl AutoUpdatePosition="False">
                                </FilterControl>
                            </SettingsPopup>
                            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                            <EditFormLayoutProperties ColCount="5" ColumnCount="5">
                                <Items>
                                    <dx:GridViewColumnLayoutItem ColSpan="5" ColumnName="User Role" ColumnSpan="5" >
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Can View Menu">
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Can Add">
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Can Edit">
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Can Delete">
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Can View">
                                        <CaptionStyle Font-Bold="True" ForeColor="Black">
                                        </CaptionStyle>
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="User Group ID" Visible="False">
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Role ID" Visible="False">
                                    </dx:GridViewColumnLayoutItem>
                                    <dx:EditModeCommandLayoutItem ColSpan="3" ColumnSpan="3">
                                    </dx:EditModeCommandLayoutItem>
                                </Items>
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit">
                                </SettingsAdaptivity>
                            </EditFormLayoutProperties>
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="UserGroup" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UserGroupRoleID" ReadOnly="True" VisibleIndex="4" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="UserGroupID" VisibleIndex="5" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="RoleID" VisibleIndex="6" Visible="False"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn FieldName="CanViewMenu" VisibleIndex="7"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn FieldName="CanAdd" VisibleIndex="8"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn FieldName="CanEdit" VisibleIndex="9"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn FieldName="CanDelete" VisibleIndex="10"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn FieldName="CanView" VisibleIndex="11"></dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn FieldName="ModifiedBy" VisibleIndex="12" Visible="False"></dx:GridViewDataTextColumn>

                                <dx:GridViewDataDateColumn FieldName="ModifiedDate" ShowInCustomizationForm="True" Visible="False" VisibleIndex="13">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="ParentRoleID" ShowInCustomizationForm="True" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>

                                <dx:GridViewDataTextColumn FieldName="UserRole" VisibleIndex="2" ReadOnly="True">
                                    <CellStyle Font-Bold="False"></CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="ParentRole" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <Styles>
                                <SelectedRow>
                                    <BackgroundImage Repeat="NoRepeat" />
                                </SelectedRow>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource runat="server" ID="SqlDataSourceUserGroupRole" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="Usp_UserGroupRole_GetByUserGroupIDByUserGroupRole" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE UserGroupRole SET	
		                            CanViewMenu=@CanViewMenu,
		                            CanAdd	= @CanAdd,
		                            CanEdit	= @CanEdit,
		                            CanDelete	= @CanDelete,
		                            CanView	= @CanView,
		                            ModifiedBy	=	@UserID,
		                            ModifiedDate	=	Getdate()
	                            WHERE UserGroupID	=	@UserGroupID AND RoleID = @RoleID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtUserGroupRole" PropertyName="Text" DefaultValue="0" Name="UserGroupID" Type="Int32"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="txtUserParentRoles" PropertyName="Text" DefaultValue="0" Name="ParentRoleID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CanViewMenu" />
                                <asp:Parameter Name="CanAdd" />
                                <asp:Parameter Name="CanEdit" />
                                <asp:Parameter Name="CanDelete" />
                                <asp:Parameter Name="CanView"></asp:Parameter>
                                <asp:SessionParameter DefaultValue="0" Name="UserID" SessionField="UserID" />
                                <asp:ControlParameter ControlID="cboUserGroupRole" DefaultValue="-1" Name="UserGroupID" PropertyName="Value" />
                                <asp:Parameter Name="RoleID" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxTextBox runat="server" ClientInstanceName="txtUserParentRoles" AutoPostBack="true" ClientVisible="false" ID="txtUserParentRoles" Text="0"></dx:ASPxTextBox>
                        <dx:ASPxTextBox runat="server" ClientInstanceName="txtUserGroupRole" AutoPostBack="true" ClientVisible="false" ID="txtUserGroupRole" Text="0"></dx:ASPxTextBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

        </Items>
    </dx:ASPxFormLayout>

        <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" ClientInstanceName="popupAdd" CloseAction="CloseButton" HeaderText="Add New User Group" PopupElementID="cmdAddUserGroup" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="600px" Modal="true">
        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700" />

        <ClientSideEvents PopUp="function(s, e) {EmptyAdd();}"></ClientSideEvents>

        <HeaderStyle HorizontalAlign="Center" BackColor="#0D6B68" Font-Bold="True" Font-Size="Large" ForeColor="White" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="100%" ColCount="2" ColumnCount="2">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                    </SettingsAdaptivity>

                    <Items>
                        <dx:LayoutItem Caption="User Group" ColumnSpan="2" ColSpan="2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox runat="server" ID="txtUserGroupAdd" ClientInstanceName="txtUserGroupAdd">
                                        <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                            <RequiredField IsRequired="True"></RequiredField>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="2" ColumnSpan="2" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 130px">
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Submit" ValidationGroup="Add" Width="120px" ID="cmdSubmitAdd">
                                                    <ClientSideEvents Click="function(s,e){ OnSaveAdd(s,e);}"></ClientSideEvents>
                                                </dx:ASPxButton>


                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" AutoPostBack="False" Text="Refresh" Width="120px"  ID="cmdRefreshAdd"></dx:ASPxButton>


                                            </td>
                                        </tr>
                                    </table>
                                    <dx:ASPxPopupControl runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Modal="True" CloseAction="None" AllowDragging="True" ClientInstanceName="PopupConfirmSaveAdd" HeaderText="Confirm Save" ShowCloseButton="False" Width="300px" ID="PopupConfirmSaveAdd">
                                        <SettingsAdaptivity Mode="OnWindowInnerWidth" SwitchAtWindowInnerWidth="700"></SettingsAdaptivity>

                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ContentCollection>
                                            <dx:PopupControlContentControl runat="server">
                                                <dx:ASPxFormLayout runat="server" ColCount="2" ColumnCount="2" Width="100%" ID="ASPxFormLayout6">
                                                    <Items>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" Text="Yes" ValidationGroup="Add" Width="120px" ID="cmdSaveYesAdd">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}"></ClientSideEvents>
                                                                    </dx:ASPxButton>


                                                                </dx:LayoutItemNestedControlContainer>
                                                            </LayoutItemNestedControlCollection>
                                                        </dx:LayoutItem>
                                                        <dx:LayoutItem Caption="" ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
                                                            <LayoutItemNestedControlCollection>
                                                                <dx:LayoutItemNestedControlContainer runat="server">
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="No"  Width="120px" BackColor="#FF3300" ID="cmdSaveNoAdd">
                                                                        <ClientSideEvents Click="function(s, e) {PopupConfirmSaveAdd.Hide();}"></ClientSideEvents>
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
                                    <dx:ASPxLabel runat="server" Text="" ClientInstanceName="lblErrMsgAdd" Font-Bold="True" ForeColor="Red" ID="lblErrMsgAdd"></dx:ASPxLabel>

                                    <dx:ASPxLabel runat="server" ClientInstanceName="lblSuccessMsgAdd" ClientVisible="False" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgAdd"></dx:ASPxLabel>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceUserGroups" ConnectionString='<%$ ConnectionStrings:PetroTraderConnectionString %>' SelectCommand="SELECT * FROM UserGroups WHERE UserGroupID>0 "></asp:SqlDataSource>


</asp:Content>

