<%@ Page Language="VB" AutoEventWireup="true" MasterPageFile="~/SignInMaster.master" CodeBehind="SignIn.aspx.vb" Inherits="PetroTraderPro.SignInModule" Title="Sign In" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/SignInRegister.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/SignInRegister.js") %>'></script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">

    <div class="formLayout-verticalAlign">
        <div class="formLayout-container">
            <dx:ASPxTabControl ID="SignInRegisterTabControl" runat="server" Width="100%" TabAlign="Justify" Paddings-Padding="0">
                <Tabs>
                    <dx:Tab Text="Sign In"></dx:Tab>
                </Tabs>
            </dx:ASPxTabControl>

            <dx:ASPxFormLayout ID="FormLayout" runat="server" ClientInstanceName="formLayout" UseDefaultPaddings="False">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                <SettingsItemCaptions Location="Top" />
                <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8">
                    <LayoutItem>
                        <Paddings PaddingBottom="8px"></Paddings>
                    </LayoutItem>
                    <LayoutGroup>
                        <Cell>
                            <Paddings Padding="0px"></Paddings>
                        </Cell>
                    </LayoutGroup>
                </Styles>
                <Items>
                    <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                        <Paddings Padding="16px"></Paddings>
                        <Items>
                            <dx:LayoutItem ColSpan="1" HorizontalAlign="Center" ShowCaption="False">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxImage ID="FormLayout_E1" ImageUrl="~/img/applogo.png" Width="100%" Height="120px" runat="server">
                                        </dx:ASPxImage>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Phone Number" HelpText="Please, enter your user number">
                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="txtPhoneNumber" runat="server" Width="100%" AutoCompleteType="Disabled">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="User name is required" />
                                            </ValidationSettings>
                                            <ClientSideEvents Init="function(s, e){ s.Focus(); }" />
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Password">
                                <CaptionStyle Font-Bold="True" ForeColor="Black"></CaptionStyle>
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="txtpassword" runat="server" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ClearButton DisplayMode="Never"></ClearButton>

                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                                <PressedStyle BackColor="Transparent"></PressedStyle>
                                                <HoverStyle BackColor="Transparent"></HoverStyle>
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Password is required" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" />
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="13">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <%--<dx:ASPxCheckBox ID="RememberMeCheckBox" runat="server" Text="Remember me" Checked="true"></dx:ASPxCheckBox>--%>
                                        <label type="text" id="lblErrMsg" runat="server" style="color: #FF0000" />
                                        <%--                                        <dx:ASPxHyperLink runat="server" Text="Forgot password ?" NavigateUrl="/ForgotPassword.aspx"></dx:ASPxHyperLink>--%>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <Paddings PaddingTop="13px"></Paddings>
                            </dx:LayoutItem>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="SignInButton" runat="server" Width="200" Text="Log In" OnClick="SignInButton_Click"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                <Paddings Padding="0px"></Paddings>
                            </dx:LayoutItem>


                        </Items>
                    </dx:LayoutGroup>

                </Items>
            </dx:ASPxFormLayout>
                            <div class="footer-wrapper" id="footerWrapper">
                    <div class="footer">
                        <span class="footer-left">&copy; 2025 JSolutions Ghana LTD.</span>
                        <span class="footer-right">
                            <a class="footer-link" href="#">Privacy Policy</a>
                        </span>
                    </div>
                </div>

        </div>
    </div>

</asp:Content>
