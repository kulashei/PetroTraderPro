<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="EagleEyeApp.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Textual inputs</h4>
                    <p class="card-title-desc">
                        Here are examples of <code>.form-control</code> applied to each
                                            textual HTML5 <code>&lt;input&gt;</code> <code>type</code>.
                    </p>
                </div>
                <div class="card-body p-4">

                    <div class="row">
                        <div class="col-lg-6">
                            <div>
                                <div class="mb-3">
                                    <label for="example-text-input" class="form-label">Text</label>
                        <dx:BootstrapDateEdit runat="server" ID="BootstrapDateEdit3"></dx:BootstrapDateEdit>
                                </div>
                                <div class="mb-3">
                                    <label for="example-search-input" class="form-label">Search</label>
                        <dx:BootstrapDateEdit runat="server" ID="BootstrapDateEdit2" PickerType="Days" CssClasses-Control="form-control-sm" CssClasses-Input="form-control-sm" CssClasses-IconDropDownButton="fas fa-calendar-alt"></dx:BootstrapDateEdit>
                                </div>
                                <div class="mb-3">
                                    <label for="example-email-input" class="form-label">Email</label>
                                    <<dx:BootstrapTextBox ID="BootstrapTextBox1" runat="server" CssClasses-Control="form-control-sm" CssClasses-Input='form-control-sm'></dx:BootstrapTextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="example-url-input" class="form-label">URL</label>
                                    <input class="form-control" type="url" value="https://getbootstrap.com" id="example-url-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-tel-input" class="form-label">Telephone</label>
                                    <input class="form-control" type="tel" value="1-(555)-555-5555" id="example-tel-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-password-input" class="form-label">Password</label>
                                    <input class="form-control" type="password" value="hunter2" id="example-password-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-number-input" class="form-label">Number</label>
                                    <input class="form-control" type="number" value="42" id="example-number-input">
                                </div>
                                <div>
                                    <label for="example-datetime-local-input" class="form-label">Date and time</label>
                                    <input class="form-control" type="datetime-local" value="2019-08-19T13:45:00" id="example-datetime-local-input">
                                </div>

                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mt-3 mt-lg-0">
                                <div class="mb-3">
                                    <label for="example-date-input" class="form-label">Date</label>
                                    <input class="form-control" type="date" value="2019-08-19" id="example-date-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-month-input" class="form-label">Month</label>
                                    <input class="form-control" type="month" value="2019-08" id="example-month-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-week-input" class="form-label">Week</label>
                                    <input class="form-control" type="week" value="2019-W33" id="example-week-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-time-input" class="form-label">Time</label>
                                    <input class="form-control" type="time" value="13:45:00" id="example-time-input">
                                </div>
                                <div class="mb-3">
                                    <label for="example-color-input" class="form-label">Color picker</label>
                                    <input type="color" class="form-control form-control-color mw-100" id="example-color-input" value="#5156be" title="Choose your color">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Select</label>
                                    <select class="form-select">
                                        <option>Select</option>
                                        <option>Large select</option>
                                        <option>Small select</option>
                                    </select>
                                </div>

                                <div>
                                    <label for="exampleDataList" class="form-label">Datalists</label>
                                    <input class="form-control" list="datalistOptions" id="exampleDataList" placeholder="Type to search...">
                                    <datalist id="datalistOptions">
                                        <option value="San Francisco">
                                            <option value="New York">
                                                <option value="Seattle">
                                                    <option value="Los Angeles">
                                                        <option value="Chicago">
                                    </datalist>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end col -->
    </div>
    <!-- end row -->

    <!-- Start row -->
    <div class="row">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Sizing</h4>
                    <p class="card-title-desc">Set heights using classes like <code>.form-control-lg</code> and <code>.form-control-sm</code>.</p>
                </div>
                <div class="card-body">
                    <form>
                        <div class="mb-4">
                            <label class="form-label" for="default-input">Default input</label>
                            <input class="form-control" type="text" id="default-input" placeholder="Default input">
                        </div>
                        <div class="mb-4">
                            <label class="form-label" for="form-sm-input">Form Small input</label>
                        <dx:BootstrapDateEdit runat="server" ID="BootstrapDateEdit1"></dx:BootstrapDateEdit>
                        </div>
                        <div>
                            <label class="form-label" for="form-lg-input">Form Large input</label>
                            <input class="form-control form-control-lg" type="text" id="form-lg-input" placeholder=".form-control-lg">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- end col -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Range Inputs</h4>
                    <p class="card-title-desc">
                        Create custom <code>&lt;input type="range"&gt;</code>
                        controls with <code>.form-range</code>.
                    </p>
                </div>
                <div class="card-body">


                    <div class="mb-3">
                        <label for="customRange1" class="form-label">Example range</label>
                        <input type="range" class="form-range" id="customRange1">
                    </div>

                    <div class="mb-4">
                        <h5 class="font-size-14 mb-1">Min and max</h5>
                        <p class="card-title-desc mb-2">
                            Range inputs have implicit values for min and
                                                max—0 and 100, respectively.
                        </p>
                        <input type="range" class="form-range" min="0" max="5" id="customRange2">
                    </div>

                    <div>
                        <h5 class="font-size-14 mb-1">Steps</h5>
                        <p class="card-title-desc mb-2">
                            By default, range inputs “snap” to integer
                                                values. To change this, you can specify a <code>step</code> value.
                        </p>
                        <input type="range" class="form-range" min="0" max="5" id="customRange3">
                    </div>

                </div>
            </div>
        </div>
        <!-- end col -->
    </div>
    <!-- End row -->

    <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" AlignItemCaptionsInAllGroups="True" Width="100%">
        <Items>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapTextBox runat="server" ID="BootstrapFormLayout1_E2"></dx:BootstrapTextBox>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapComboBox runat="server" ID="BootstrapFormLayout1_E4"></dx:BootstrapComboBox>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapDateEdit runat="server" ID="BootstrapFormLayout1_E6"></dx:BootstrapDateEdit>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server"></dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server"></dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server"></dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server"></dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem>
                <ContentCollection>
                    <dx:ContentControl runat="server"></dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
        </Items>
    </dx:BootstrapFormLayout>
</asp:Content>
