<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Root.master" CodeBehind="busInfoSetup.aspx.vb" Inherits="PetroTraderPro.busInfoSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
        <script src="../Content/myscript/jquery-3.6.0.js"></script>
    <script type="text/javascript">

        function LoadPicture(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();

                reader.onload = function (e) {

                    $('#<%=picLogo.ClientID%>').prop('src', e.target.result)
                        .Width(150)
                        .Height(150)
                };
                reader.readAsDataURL(input.files[0]);
                }
            }


            function OnSave(s, e) {
                ASPxClientEdit.ValidateEditorsInContainer(null);
                if (ASPxClientEdit.AreEditorsValid()) {
                    PopupConfirmSaveAdd.Show();
                }
            };

    </script>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageContent" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout2" runat="server" ColCount="4" ColumnCount="4" Width="100%">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500">
        </SettingsAdaptivity>
        <Items>
            <dx:LayoutItem ColSpan="4" ColumnSpan="4" ShowCaption="False" HorizontalAlign="Center">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server"  HeaderText="Business Information" HeaderStyle-ForeColor="#0D6B68" Font-Bold="True" Font-Size="X-Large">

<HeaderStyle ForeColor="#0D6B68"></HeaderStyle>

                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <dx:ASPxFormLayout ID="ASPxFormLayout3" runat="server" Width="700px" ColCount="2" ColumnCount="2">
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                                        </SettingsAdaptivity>

                                        <Items>
                                            <dx:LayoutItem Caption="Company Name" ColSpan="2" ColumnSpan="2">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxTextBox runat="server" ID="txtCompanyAdd" ClientInstanceName="txtCompanyAdd">
                                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>


                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Bus. Info" ColSpan="2" ColumnSpan="2">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxMemo runat="server" ClientInstanceName="txtBusinessInfoAdd" ID="txtBusinessInfoAdd">
                                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>

                                                        </dx:ASPxMemo>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Address" ColSpan="2" ColumnSpan="2">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxMemo runat="server" Width="100%" ClientInstanceName="txtAddressAdd" ID="txtAddressAdd">
                                                            <ValidationSettings ErrorDisplayMode="None" Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="Add">
                                                                <RequiredField IsRequired="True"></RequiredField>
                                                            </ValidationSettings>
                                                        </dx:ASPxMemo>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                            </dx:LayoutItem>
                                            <dx:LayoutGroup Caption="Business Logo" ColSpan="2" ColumnSpan="2">
                                                <GroupBoxStyle>
                                                    <Caption Font-Bold="True" ForeColor="Black"></Caption>
                                                </GroupBoxStyle>
                                                <Items>
                                                    <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td class="auto-style1">
                                                                            <dx:ASPxImage ID="picLogo" runat="server" ClientInstanceName="picLogo" ShowLoadingImage="true" Height="150px"  Width="150px" >
                                                                                <EmptyImage Url="~/img/emptyImage.png">
                                                                                </EmptyImage>
                                                                                <Border BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                                                                            </dx:ASPxImage>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="auto-style1">
                                                                            <asp:FileUpload ID="FileUploadPicture" runat="server" onchange="LoadPicture(this);" />
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                </Items>
                                            </dx:LayoutGroup>
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td style="width: 130px">
                                                                    <dx:ASPxButton runat="server" AutoPostBack="False" Text="Save" ValidationGroup="Add" Width="120px" ID="cmdSubmitAdd">
                                                                        <ClientSideEvents Click="function(s,e){ OnSave(s,e);}"></ClientSideEvents>
                                                                    </dx:ASPxButton>


                                                                </td>
                                                                <td>
                                                                    <dx:ASPxButton runat="server"  Text="Refresh" Width="120px"  ID="cmdRefreshAdd">
                                                                    </dx:ASPxButton>


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
                                                                                        <dx:ASPxButton runat="server" AutoPostBack="False" Text="No" Width="120px" BackColor="#FF3300" ID="cmdSaveNoAdd">
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
                                            <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxLabel runat="server" Font-Bold="True" ForeColor="Red" ID="lblErrMsgAdd"></dx:ASPxLabel>

                                                        <dx:ASPxLabel runat="server" Font-Bold="True" ForeColor="Blue" ID="lblSuccessMsgAdd"></dx:ASPxLabel>


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

</asp:Content>
