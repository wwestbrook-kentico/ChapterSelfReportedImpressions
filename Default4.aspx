<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Default4.aspx.cs" Inherits="_tools_ChapterSelfReportedImpressions_Default4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chapter Self Reported Impressions</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>
    <script src="//ajax.microsoft.com/ajax/jquery/jquery-1.4.2.min.js" type="text/javascript"></script>

    <link href="css/jquery-ui.min.css" rel="stylesheet" />
    <link href="css/customtheme.css" rel="stylesheet" />
    <script src="scripts/jquery-1.11.1.min.js"></script>
    <script src="scripts/jquery-ui.min.js"></script>

    <script src='/_tools/IR_Admin/scripts/jquery-1.7.2.min.js' type='text/javascript'></script>
    <link href="//ajax.aspnetcdn.com/ajax/jquery.ui/1.8.13/themes/redmond/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="/_tools/IR_Admin/css/Repository/style.css" rel="stylesheet" />
    <script src='/_tools/IR_Admin/scripts/jquery-1.9.2.ui.min.js' type='text/javascript'></script>

    <style>
        .mydatagrid {
            /*width: 1520px;*/
            border: solid 2px #4a0d66;
            min-width: 80%;
        }

        .header {
            background-color: #4a0d66;
            font-family: Arial;
            color: White;
            height: 25px;
            text-align: center;
            font-size: 16px;
            vertical-align: top;
        }

        .rows {
            background-color: #fff;
            font-family: Arial;
            font-size: 14px;
            color: #000;
            min-height: 28px;
            text-align: left;
        }

            .rows:hover {
                background-color: beige;
            }

        .mydatagrid a /** FOR THE PAGING ICONS  **/ {
            background-color: Transparent;
            padding: 5px 5px 5px 5px;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }

            .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/ {
                background-color: #000;
                color: #fff;
            }

        .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/ {
            background-color: #fff;
            color: #000;
            padding: 3px 3px 3px 3px;
            /*padding: 5px 5px 5px 5px;     ORIGINAL */
        }

        .pager {
            background-color: #5badff;
            font-family: Arial;
            color: White;
            height: 30px;
            text-align: left;
        }

        .mydatagrid td {
            padding: 5px;
        }

        .mydatagrid th {
            padding: 5px;
        }

        .resizedTextbox {
            width: 60px;
            padding: 2px 2px 2px 2px;
            border-style: none;
            height: 12px;
        }

        .nopaddingright {
            padding-right: 0px !important;
        }
    </style>

    <style type="text/css">
        .hideControl {
            display: none;
        }

        .table3 {
            border-collapse: collapse !important;
            border-spacing: 0;
            width: 1520px;
            background-color: #4a0d66;
        }

        .table2 td {
            background-color: #4a0d66;
            font-family: Arial;
            color: White;
            height: 25px;
            text-align: left;
            font-size: 16px;
            padding: 5px 5px 5px 5px;
            font-weight: bold;
        }

        .mydropdownlist {
            color: #fff;
            font-size: 12px;
            padding: 5px 5px;
            border-radius: 5px;
            background-color: #4a0d66;
            font-weight: bold;
        }

        .table4 {
            width: 250px;
            background-color: white;
            border: solid;
            border-color: black;
            border-width: 2px;
            vertical-align: bottom;
        }
    </style>

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        /* The Modal (background) */
        .modalUpdate {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-contentUpdate {
            /*background-color: #fefefe;
            margin: auto;
            padding: 5px;
            border: 1px solid #888;
            width: 15%;*/
            position: absolute;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 1rem 1.5rem;
            width: 24rem;
            border-radius: 0.5rem;
            margin: auto;
        }
    </style>

    <%--START TextBox Validation--%>
    <script type="text/javascript">
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        $(function () {
            $(".numeric").bind("keypress", function (e) {
                var keyCode = e.which ? e.which : e.keyCode
                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
                if (ret) {
                    $(this).next().remove();
                } else {
                    alert("Only Numeric Values!");
                }
                return ret;
            });
            $(".numeric").bind("paste", function (e) {
                return false;
            });
            $(".numeric").bind("drop", function (e) {
                return false;
            });
        });
    </script>
    <%--END TextBox Validation--%>

    <%--START Auto Close Dialog Box--%>
    <script type="text/javascript">
        function UpdateMsg() {
            var modal = document.getElementById("myModal");
            modal.style.display = "block";

            AutoCloseDialogBox(2000);
        }

        function AutoCloseDialogBox(WaitSeconds) {
            //Auto Close Dialog Box after few seconds
            setTimeout(
                function () {
                    var modal = document.getElementById("myModal");
                    modal.style.display = "none";
                }, WaitSeconds);
        }
    </script>
    <%--END Auto Close Dialog Box--%>

    <%--START Chapter Admin--%>
    <script type="text/javascript">
        function ChptrAdmin() {
            $('[id*=grdvwdata] tr:not(:last) td').on('click', function () {
                if ($(this).index() > 0 && $(this).index() != 5) {
                    $('[id*=grdvwdata] tr:not(:last) td').each(function () {
                        if ($(this).index() > 0 && $(this).index() != 5) {
                            $(this).find('span').show();
                            $(this).find('input[type=text]').hide();
                            //$(this).find('span').html($(this).find('input[type=text]').val());
                        }
                    });
                    var val = $(this).find('span').html().replace('$', '').replace('.00', '').replace(',', '').replace(',', '');
                    $(this).find('span').hide();
                    $(this).find('input[type=text]').val(val);
                    $(this).find('input[type=text]').show();
                    $(this).find('input[type=text]').focus();
                }
            });
        };
    </script>
    <%--END Chapter Admin--%>

    <%--START Super Admin--%>
    <script type="text/javascript">
        function SuperAdmin() {
            $('[id*=grdvwdata] tr:not(:last) td').on('click', function () {
                if ($(this).index() > 0 && $(this).index() != 5) {
                    $('[id*=grdvwdata] tr:not(:last) td').each(function () {
                        if ($(this).index() > 0 && $(this).index() != 5) {
                            $(this).find('span').show();
                            $(this).find('input[type=text]').hide();
                            //$(this).find('span').html($(this).find('input[type=text]').val());
                        }
                    });
                    var val = $(this).find('span').html().replace('$', '').replace('.00', '').replace(',', '').replace(',', '');
                    $(this).find('span').hide();
                    $(this).find('input[type=text]').val(val);
                    $(this).find('input[type=text]').show();
                    $(this).find('input[type=text]').focus();
                }
            });
        };
    </script>
    <%--END Super Admin--%>

    <%--START Region Admin--%>
    <script type="text/javascript">
        function RegionAdmin() {
            $('[id*=grdvwdata] tr:not(:last) td').on('click', function () {
                if ($(this).index() > 0 && $(this).index() != 5) {
                    $('[id*=grdvwdata] tr:not(:last) td').each(function () {
                        if ($(this).index() > 0 && $(this).index() != 5) {
                            $(this).find('span').show();
                            $(this).find('input[type=text]').hide();
                            //$(this).find('span').html($(this).find('input[type=text]').val());
                        }
                    });
                    var val = $(this).find('span').html().replace('$', '').replace('.00', '').replace(',', '').replace(',', '');
                    $(this).find('span').hide();
                    $(this).find('input[type=text]').val(val);
                    $(this).find('input[type=text]').show();
                    $(this).find('input[type=text]').focus();
                }
            });
        };
    </script>
    <%--END Region Admin--%>

    <%--START Tool Tip--%>
    <style>
        .tooltipCustom {
            position: relative;
            display: inline-block;
            /*border-bottom: 1px dotted black;*/
        }

            .tooltipCustom .tooltiptext {
                visibility: hidden;
                width: 250px;
                background-color: #fff;
                color: #555;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                /*bottom: 125%;*/
                bottom: 115%;
                left: 50%;
                margin-left: -60px;
                opacity: 0;
                transition: opacity 0.3s;
            }

                .tooltipCustom .tooltiptext::after {
                    content: "";
                    position: absolute;      /*Pointer at bottom of text*/
                    top: 100%;      /*Pointer at bottom of text*/
                    left: 50%;
                    margin-left: -50px;
                    border-width: 5px;
                    border-style: solid;
                    border-color: #fff transparent transparent transparent;
                }

            .tooltipCustom:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }

            .tooltiptext {
                font-size:12px !important;
            }
    </style>
    <%--END Tool Tip--%>

    <%--START Printer Friendly--%>
    <style>
        @media screen {
            #printSection {
                display: none;
            }
        }

        @media print {
            body * {
                visibility: hidden;
            }

            #printSection, #printSection * {
                visibility: visible;
            }

            #printSection {
                position: absolute;
                left: 0;
                top: 0;
            }
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            document.getElementById("btnPrint").onclick = function () {
                printElement(document.getElementById("printThis"));
            }

            function printElement(elem) {
                var domClone = elem.cloneNode(true);

                var $printSection = document.getElementById("printSection");

                if (!$printSection) {
                    var $printSection = document.createElement("div");
                    $printSection.id = "printSection";
                    document.body.appendChild($printSection);
                }

                $printSection.innerHTML = "";
                $printSection.appendChild(domClone);
                window.print();
            }
        });
    </script>
 
    <style type="text/css">
        .hideGridColumn
        {
            display:none;
        }
     </style>
    <%--END Printer Friendly--%>

    <%--START History Styling--%>
    <link href="css/Style.css" rel="stylesheet" />
    <%--END History Styling--%>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            <table id="Tbl_Whole" runat="server">
                <tr>
                    <td>
                        <table class="table3" id="Tbl_Hdr" runat="server">
                            <tr>
                                <td>
                                    <table class="table2">
                                        <tr>
                                            <td>Media Impressions
                                                <br />
                                                <br />
                                                <asp:DropDownList ID="DrpDwnLst_Chptr2" runat="server" OnSelectedIndexChanged="DrpDwnLst_Chptr2_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true" CssClass="mydropdownlist">
                                                    <asp:ListItem Selected="True" Text="Select Chapter" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" " Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                                -
                                                <asp:Label ID="Lbl_Region" runat="server" />
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <br />
                                                <asp:DropDownList ID="DrpDwnLst_FsclYR" runat="server" AutoPostBack="true" AppendDataBoundItems="true" CssClass="mydropdownlist" OnSelectedIndexChanged="DrpDwnLst_FsclYR_SelectedIndexChanged">
                                                    <asp:ListItem Selected="True" Text="Select Fiscal Year " Value="0"></asp:ListItem>
                                                    <asp:ListItem Text=" " Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="8" style="text-align: center;">
                                                <asp:Label ID="Lbl_ChptrHdr" runat="server" Font-Size="20px" />
                                                -
                                                <asp:Label ID="Lbl_FiscalHdr" runat="server" Font-Size="20px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdvwdata" runat="server" AutoGenerateColumns="False" CssClass="mydatagrid" FooterStyle-ForeColor="White" PagerStyle-CssClass="pager" ShowFooter="true" HeaderStyle-CssClass="header" FooterStyle-Font-Bold="true" FooterStyle-CssClass="rows" RowStyle-CssClass="rows" ShowHeaderWhenEmpty="True" EmptyDataRowStyle-CssClass="header" EmptyDataRowStyle-Font-Bold="true" EmptyDataRowStyle-ForeColor="White" EmptyDataText="No Records Found" DataKeyNames="Rec_ID">
                                        <Columns>
                                            <asp:BoundField DataField="MonthName" HeaderText="Month" ItemStyle-BackColor="#4a0d66" ItemStyle-ForeColor="White" ItemStyle-Font-Bold="true" />
                                            <asp:TemplateField HeaderText="KPI3_PA1:<br>Number of Stories Developed" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI3_PA1:<br>Number of Stories Developed<span class="tooltiptext">A human interest media pitch that illuminates a problem with information and/or a call to action that presents a solution</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI3_PA1_Value" runat="server" Text='<%# Bind("KPI3_PA1_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI3_PA1_Value" runat="server" Text='<%# Bind("KPI3_PA1_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI3-PA2:<br>Number of Media Engagements with Reporters" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI3-PA2:<br>Number of Media Engagements with Reporters<span class="tooltiptext">A meaningful interaction that cultivates a relationship and positions the Association as a leader and go-to resource</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI3_PA2_Value" runat="server" Text='<%# Bind("KPI3_PA2_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI3_PA2_Value" runat="server" Text='<%# Bind("KPI3_PA2_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI3-PA3:<br>Number of Stories Placed" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI3-PA3:<br>Number of Stories Placed<span class="tooltiptext">An individual count of actual stories that were developed or contributed to by the chapter *Not included: calendar listings, auto-posted press releases, obituaries, job announcements or postings, building or event signage, stories that do not mention "Alzheimer's Association" or other trademarked events, initiatives or programs</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI3_PA3_Value" runat="server" Text='<%# Bind("KPI3_PA3_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI3_PA3_Value" runat="server" Text='<%# Bind("KPI3_PA3_Value") %>' CssClass="hideControl numeric resizedTextbox nopaddingright" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI3-MS1:<br>Social Media Earned Impressions" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI3-MS1:<br>Social Media Earned Impressions<span class="tooltiptext">Impressions garnered through organic social media. Self-reported by Chapters.</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI3_MS1_Value" runat="server" Text='<%# Bind("KPI3_MS1_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI3_MS1_Value" runat="server" Text='<%# Bind("KPI3_MS1_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI3-MS2:<br>Traditional Earned Media Impressions" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI3-MS2:<br>Traditional Earned Media Impressions<span class="tooltiptext">Monitored by Home Office vendors (Symscio, Burrelle’s, Critical Mention, TV1) – This data is not editable, fed from Data Warehouse</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI3_MS2_Value" runat="server" Text='<%# Bind("KPI3_MS2_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI3_MS2_Value" runat="server" Text='<%# Bind("KPI3_MS2_Value") %>' CssClass="hideControl numeric resizedTextbox nopaddingright"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI4-MS1:<br>Social Media Paid Impressions" HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI4-MS1:<br>Social Media Paid Impressions<span class="tooltiptext">Impressions as a result of paid advertising placements on digital/Social media channel</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI4_MS1_Value" runat="server" Text='<%# Bind("KPI4_MS1_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI4_MS1_Value" runat="server" Text='<%# Bind("KPI4_MS1_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI4-MS2:<br>Paid Advertising Impressions" HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI4-MS2:<br>Paid Advertising Impressions<span class="tooltiptext">Impressions as a result of paid advertising placements on channels such as television, radio, and print</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI4_MS2_Value" runat="server" Text='<%# Bind("KPI4_MS2_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI4_MS2_Value" runat="server" Text='<%# Bind("KPI4_MS2_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI4_PA1_Value:<br>Advertising & Social Media Spend" HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI4_PA1_Value:<br>Advertising & Social Media Spend<span class="tooltiptext">Dollars spent for any paid advertising and social media placements</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI4_PA1_Value" runat="server" Text='<%# Bind("KPI4_PA1_Value","{0:C0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI4_PA1_Value" runat="server" Text='<%# Bind("KPI4_PA1_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KPI4-MS3:<br>Donated Impressions" HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true">
                                                <HeaderTemplate>
                                                    <div class="tooltipCustom">KPI4-MS3:<br>Donated Impressions<span class="tooltiptext">If unpaid benefits from a media outlet are a conventional paid tactic, it should be considered donated media</span></div>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Lbl_KPI4_MS3_Value" runat="server" Text='<%# Bind("KPI4_MS3_Value","{0:N0}") %>'></asp:Label>
                                                    <asp:TextBox ID="TxtBx_KPI4_MS3_Value" runat="server" Text='<%# Bind("KPI4_MS3_Value") %>' CssClass="hideControl numeric resizedTextbox" AutoPostBack="true" OnTextChanged="Change"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>

                            </tr>
                            <tr>
                                <td style="text-align: center; background-color: white; color: black;">&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="text-align: center; background-color: white; color: black; font-family: Arial; font-size: 16px;">
                                    <asp:Label ID="LblFooterMsg" runat="server">To view Traditional Earned  Media Impressions, go to the BIG Dashboard at:</asp:Label>
                                    <br />
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://big.alz.org/reports/powerbi/.Strategic%20Plan%20Dashboards%20and%20Reports/Concern%20and%20Awareness%20Dashboards%20and%20Reports/Concern%20and%20Awareness%20SIP%20Dashboard">Concern and Awareness SIP Dashboard <br /> <br /></asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td style="background-color: white; color: black;">
                                    <table style="width:100%">
                                        <tr>
                                            <td style="text-align: left; background-color: white; color: black; width:10%">
                                                <%--<asp:Button ID="btnPrint" runat="server" Text="Printer Friendly" OnClick="PrintGrid" />--%>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#MyModal">
                                                    Print Friendly
                                                </button>
                                                <br /><br />
                                            </td>
                                            <td style="text-align: left; background-color: white; color: black; width:80%">&nbsp;</td>
                                            <td style="text-align: right; background-color: white; color: black; width:10%">
                                                <asp:Button ID="btnExport" runat="server" class="btn btn-primary" Text="Export To Excel" OnClick = "ExportToExcel" />
                                                <br /><br />
                                            </td>
                                        </tr>
                                    </table>                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Lbl_Error" runat="server"></asp:Label>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>

            <br /><br />

            <asp:GridView ID="grdvwdata_history" runat="server" Font-Names="Tahoma" Font-Size="Small" AutoGenerateColumns="False" DataKeyNames="Rec_ID" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" GridLines="None" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10" OnRowDataBound="grdvwdata_history_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Rec_ID" HeaderText="Rec_ID" ItemStyle-Width="100" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                    <asp:BoundField DataField="TxtBxNameValue" HeaderText="Column Name" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="DataValue_Old" HeaderText="Old Value" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="DataValue_New" HeaderText="New Value" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="UserNameValue" HeaderText="Updated By" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="DateUpdated" HeaderText="Date Updated" ItemStyle-Width="350" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="FiscalYrValue" HeaderText="Fiscal Yr" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="ChptrIDValue" HeaderText="Chptr ID" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                    <asp:BoundField DataField="MonthName" HeaderText="Month" ItemStyle-Width="160" HeaderStyle-Font-Bold="true" />
                </Columns>
            </asp:GridView>

            <!-- The Modal -->
            <div id="myModal" class="modalUpdate">
                <!-- Modal content -->
                <div class="modal-contentUpdate">
                    <span class="close"></span>
                    <p>Update was successfull..</p>
                </div>
            </div>

            <div id="printThis">
                <div id="MyModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <!-- Modal Content: begins -->
                        <div class="modal-content">
                            <!-- Modal Header -->
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabel">                                                
                                                <asp:Label ID="Lbl_ChptrHdr_Print" runat="server" Font-Size="20px" />
                                                -
                                                <asp:Label ID="Lbl_FiscalHdr_Print" runat="server" Font-Size="20px" />
                                </h4>
                            </div>
                            <!-- Modal Body -->
                            <div class="modal-body">
                                <div class="body-message">
                                        <asp:GridView ID="grdvwdata_export" runat="server" AutoGenerateColumns="False" DataKeyNames="Rec_ID" ShowFooter="true" PageIndex="0">
                                            <Columns>
                                                <asp:BoundField DataField="MonthName" HeaderText="Month" ItemStyle-Width="100" ItemStyle-BackColor="#4a0d66" ItemStyle-ForeColor="White" ItemStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI3_PA1_Value" HeaderText="KPI3_PA1: Number of Stories Developed" ItemStyle-Width="160" DataFormatString="{0:N0}" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI3_PA2_Value" HeaderText="KPI3-PA2: Number of Media Engagements with Reporters" ItemStyle-Width="260" DataFormatString="{0:N0}" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI3_PA3_Value" HeaderText="KPI3-PA3: Number of Stories Placed" ItemStyle-Width="160" DataFormatString="{0:N0}" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI3_MS1_Value" HeaderText="KPI3-MS1: Social Media Earned Impressions" ItemStyle-Width="160" DataFormatString="{0:N0}" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI3_MS2_Value" HeaderText="KPI3-MS2: Traditional Earned Media Impressions" ItemStyle-Width="160" DataFormatString="{0:N0}" HeaderStyle-BackColor="#99ccff" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI4_MS1_Value" HeaderText="KPI4-MS1: Social Media Paid Impressions" ItemStyle-Width="160" DataFormatString="{0:N0}"  HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI4_MS2_Value" HeaderText="KPI4-MS2: Paid Advertising Impressions" ItemStyle-Width="160" DataFormatString="{0:N0}"  HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI4_PA1_Value" HeaderText="KPI4_PA1_Value: Advertising & Social Media Spend" ItemStyle-Width="160" DataFormatString="{0:N0}"  HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                                <asp:BoundField DataField="KPI4_MS3_Value" HeaderText="KPI4-MS3: Donated Impressions" ItemStyle-Width="160" DataFormatString="{0:N0}"  HeaderStyle-BackColor="#ff9900" HeaderStyle-ForeColor="#4a0d66" HeaderStyle-Font-Bold="true" />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                            </div>
                            <!-- Modal Footer -->
                            <div class="modal-footer">
                                <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                <button id="btnPrint" type="button" class="btn btn-default">Print</button>
                            </div>
                        </div>
                        <!-- Modal Content: ends -->
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
