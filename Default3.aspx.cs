using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;

public partial class _tools_ChapterSelfReportedImpressions_Default3 : System.Web.UI.Page
{
    void Page_PreRender(object obj, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            LoadData();
            //return;
        }
    }

    protected void DrpDwnLst_Chptr2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DrpDwnLst_Chptr2.SelectedValue != "")
        {
            BindGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

            BindHistoryGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

            BindPrintGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);
        }
    }

    protected void Change(object sender, EventArgs e)
    {
        if (sender is TextBox)
        {
            TextBox txtBox = (TextBox)sender;
            GridViewRow gvr = (GridViewRow)txtBox.NamingContainer;
            int tenderid = Convert.ToInt16(grdvwdata.DataKeys[gvr.RowIndex].Value);
            int Rindx = gvr.RowIndex;
            Label LblFld = grdvwdata.Rows[Rindx].FindControl(txtBox.ID.ToString().Replace("TxtBx", "Lbl")) as Label;

            if (txtBox.ID.ToString() != "")
            {
                ChangeValue(LblFld.Text.Replace("$", "").Replace(",", ""), txtBox.Text, tenderid, txtBox.ID.ToString());
            }
            else
            {
                Lbl_Error.Text = txtBox.ID.ToString();
            }
        }
    }

    private void ChangeValue(string DataValue_Old, string DataValue, int ID_Value, string TxtBxNameValue)
    {
        InsiteUser IU = Functions.GetUser();

        if (Session["update"].ToString() == ViewState["update"].ToString())
        {

            try
            {
                using (SqlService _SP_UpdtRcrd = new SqlService())
                {
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_Rec_ID", ID_Value));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_DataValue_Old", DataValue_Old));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_DataValue", DataValue));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_TxtBxNameValue", TxtBxNameValue));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_UserNameValue", IU.UserName));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_FiscalYrValue", DrpDwnLst_FsclYR.SelectedValue));
                    _SP_UpdtRcrd.AddParameter(new System.Data.SqlClient.SqlParameter("@_ChptrIDValue", DrpDwnLst_Chptr2.SelectedValue));

                    _SP_UpdtRcrd.ExecuteSP("sp_Insite3_ChapterSelfReportedImpressions_MonthlyValues_UpdtRcrd");
                }
                BindGridAfterUpdate(true);
                Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            }
            catch (Exception ex)
            {
                Lbl_Error.Text = ex.Message;
            }
        }
        else
        {
            BindGridAfterUpdate(false);
        }

    }

    private void LoadData()
    {
        InsiteUser IU = Functions.GetUser();
        IU.ChapterID.ToString();

        string Year = DateTime.Parse(DateTime.Now.ToString()).AddYears(1).Year.ToString();

        BindGrid("423", Year);

        BindHistoryGrid("423", Year);

        BindPrintGrid("423", Year);

        //if (_DT_PageLoadUserChptrID.Rows.Count > 0)
        //{
        using (SqlService _S = new SqlService())
            {
                DataTable _DT_DrpDwnLst_Chptr2 = _S.ExecuteSqlDataSet("SELECT ChapterID AS ChptrID,ParentID,Name AS ChptrName FROM Insite3_ChapterSelfReportedImpressionsChapters WHERE ChapterID <> 999 ORDER BY Name").Tables[0];
                for (int i = 0; i < _DT_DrpDwnLst_Chptr2.Rows.Count; i++)
                {
                    ListItem _LI = new ListItem();
                    _LI.Value = _DT_DrpDwnLst_Chptr2.Rows[i]["ChptrID"].ToString();
                    _LI.Text = _DT_DrpDwnLst_Chptr2.Rows[i]["ChptrName"].ToString();
                    DrpDwnLst_Chptr2.Items.Add(_LI);
                    //DrpDwnLst_Chptr2.SelectedValue = _DT_PageLoadUserChptrID.Rows[0]["ChptrID"].ToString();
                }

                DrpDwnLst_Chptr2.SelectedValue = "423";

                DataTable _DTYear = _S.ExecuteSqlDataSet("SELECT DISTINCT (FiscalYear) FROM [ALZ].[dbo].[Insite3_ChapterSelfReportedImpressions] WHERE FiscalYear < 2022 ORDER BY FiscalYear").Tables[0];
                for (int i = 0; i < _DTYear.Rows.Count; i++)
                {
                    ListItem _LI = new ListItem();
                    _LI.Value = _DTYear.Rows[i]["FiscalYear"].ToString();
                    _LI.Text = "FY" + _DTYear.Rows[i]["FiscalYear"].ToString().Substring(2, 2);
                    DrpDwnLst_FsclYR.Items.Add(_LI);
                    //DrpDwnLst_FsclYR.SelectedValue = _DT_PageLoadUserChptrID.Rows[0]["FiscalYear"].ToString();
                }

                DrpDwnLst_FsclYR.SelectedValue = Year;
            }
        //}
    }

    private void BindGridForExport()
    {
        DataTable _DT_PageLoadUserChptrID = new DataTable();

        using (SqlService _S = new SqlService())
        {
            _S.AddParameter(new SqlParameter("@_ChptrIDValue", DrpDwnLst_Chptr2.SelectedValue));
            _S.AddParameter(new SqlParameter("@_FiscalYrValue", DrpDwnLst_FsclYR.SelectedValue));

            _DT_PageLoadUserChptrID = _S.ExecuteSPDataSet("sp_Insite3_ChapterSelfReportedImpressions_GetData").Tables[0];

            grdvwdata_export.DataSource = _DT_PageLoadUserChptrID;
            grdvwdata_export.DataBind();
        }

        //START - Calculate Sum and display in Footer Row
        BindGridFooter(_DT_PageLoadUserChptrID, grdvwdata_export);
        //END - Calculate Sum and display in Footer Row
    }

    protected void DrpDwnLst_FsclYR_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DrpDwnLst_FsclYR.SelectedValue != "" || DrpDwnLst_FsclYR.SelectedValue != "0")
        {
            BindGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

            BindHistoryGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

            BindPrintGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);
        }
    }

    private void BindGridAfterUpdate(bool isupdated)
    {
        if (isupdated == true)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "UpdateMsg();", true);
        }

        BindGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

        BindHistoryGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

        BindPrintGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);
    }

    private void Accessibility(string LockedOut, string RegionAdmin)
    {
        InsiteUser IU = Functions.GetUser();
        IU.ChapterID.ToString();

        if (Functions.CheckGroup("Chapter Self Reported Impressions National Super Admin"))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallChptrAdminFunction", "SuperAdmin();", true);
        }

        if (Functions.CheckGroup("Chapter Self Reported Impressions Super Admin"))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallSuperAdminFunction", "ChptrAdmin();", true);
        }

        if (IU.UserName == RegionAdmin && LockedOut == "No")
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallRegionAdminFunction", "RegionAdmin();", true);
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void ExportToExcel(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=GrdVwExprt_" + DrpDwnLst_Chptr2.SelectedItem.Text + ".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";

        //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            grdvwdata_export.AllowPaging = false;
            grdvwdata_export.Caption = DrpDwnLst_Chptr2.SelectedItem.Text + " Chapter - " + DrpDwnLst_FsclYR.SelectedItem.Text;
            this.BindGridForExport();

            grdvwdata_export.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in grdvwdata_export.HeaderRow.Cells)
            {
                cell.BackColor = grdvwdata_export.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in grdvwdata_export.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = grdvwdata_export.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = grdvwdata_export.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            grdvwdata_export.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    private void BindGridFooter(DataTable DT, GridView GV)
    {
        //START - Calculate Sum and display in Footer Row
        decimal total_KPI3_PA1 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI3_PA1_Value"));
        GV.FooterRow.Cells[0].Text = "Total";
        GV.FooterRow.Cells[0].Font.Bold = true;
        GV.FooterRow.Cells[0].BackColor = Color.Wheat;
        GV.FooterRow.Cells[0].ForeColor = Color.Purple;

        GV.FooterRow.Cells[1].BackColor = Color.Wheat;
        GV.FooterRow.Cells[1].ForeColor = Color.Purple;
        GV.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[1].Text = total_KPI3_PA1.ToString("N0");
        //
        decimal total_KPI3_PA2 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI3_PA2_Value"));
        GV.FooterRow.Cells[2].BackColor = Color.Wheat;
        GV.FooterRow.Cells[2].ForeColor = Color.Purple;
        GV.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[2].Text = total_KPI3_PA2.ToString("N0");
        //
        decimal total_KPI3_PA3 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI3_PA3_Value"));
        GV.FooterRow.Cells[3].BackColor = Color.Wheat;
        GV.FooterRow.Cells[3].ForeColor = Color.Purple;
        GV.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[3].Text = total_KPI3_PA3.ToString("N0");
        //
        decimal total_KPI3_MS1 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI3_MS1_Value"));
        GV.FooterRow.Cells[4].BackColor = Color.Wheat;
        GV.FooterRow.Cells[4].ForeColor = Color.Purple;
        GV.FooterRow.Cells[4].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[4].Text = total_KPI3_MS1.ToString("N0");
        //
        decimal total_KPI3_MS2 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI3_MS2_Value"));
        GV.FooterRow.Cells[5].BackColor = Color.Wheat;
        GV.FooterRow.Cells[5].ForeColor = Color.Purple;
        GV.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[5].Text = total_KPI3_MS2.ToString("N0");
        //
        decimal total_KPI4_MS1 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI4_MS1_Value"));
        GV.FooterRow.Cells[6].BackColor = Color.Wheat;
        GV.FooterRow.Cells[6].ForeColor = Color.Purple;
        GV.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[6].Text = total_KPI4_MS1.ToString("N0");
        //
        decimal total_KPI4_MS2 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI4_MS2_Value"));
        GV.FooterRow.Cells[7].BackColor = Color.Wheat;
        GV.FooterRow.Cells[7].ForeColor = Color.Purple;
        GV.FooterRow.Cells[7].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[7].Text = total_KPI4_MS2.ToString("N0");
        //
        decimal total_KPI4_PA1 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI4_PA1_Value"));
        GV.FooterRow.Cells[8].BackColor = Color.Wheat;
        GV.FooterRow.Cells[8].ForeColor = Color.Purple;
        GV.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[8].Text = "$" + total_KPI4_PA1.ToString("N0");
        //
        decimal total_KPI4_MS3 = DT.AsEnumerable().Sum(row => row.Field<int>("KPI4_MS3_Value"));
        GV.FooterRow.Cells[9].BackColor = Color.Wheat;
        GV.FooterRow.Cells[9].ForeColor = Color.Purple;
        GV.FooterRow.Cells[9].HorizontalAlign = HorizontalAlign.Left;
        GV.FooterRow.Cells[9].Text = total_KPI4_MS3.ToString("N0");
        //END - Calculate Sum and display in Footer Row   
    }

    private void BindGrid(string ChapterID, string FiscalYear)
    {
        DataTable _DT_GrdvwData = new DataTable();

        using (SqlService _S = new SqlService())
        {
            _S.AddParameter(new SqlParameter("@_ChptrIDValue", ChapterID));
            _S.AddParameter(new SqlParameter("@_FiscalYrValue", FiscalYear));

            _DT_GrdvwData = _S.ExecuteSPDataSet("sp_Insite3_ChapterSelfReportedImpressions_GetData").Tables[0];

            grdvwdata.DataSource = _DT_GrdvwData;
            grdvwdata.DataBind();
        }

        if (_DT_GrdvwData.Rows.Count > 0)
        {
            Lbl_ChptrHdr.Text = _DT_GrdvwData.Rows[0]["ChptrName"].ToString();
            Lbl_FiscalHdr.Text = _DT_GrdvwData.Rows[0]["FY"].ToString();
            Lbl_ChptrHdr_Print.Text = _DT_GrdvwData.Rows[0]["ChptrName"].ToString();
            Lbl_FiscalHdr_Print.Text = _DT_GrdvwData.Rows[0]["FY"].ToString();
            Lbl_Region.Text = "Region # " + _DT_GrdvwData.Rows[0]["RegionNum"].ToString();
            string RegionAdmin = _DT_GrdvwData.Rows[0]["RegionAdmin"].ToString();
            string LockedOut = _DT_GrdvwData.Rows[0]["LockedOut"].ToString();

            Accessibility(LockedOut, RegionAdmin);
        }

        //START - Calculate Sum and display in Footer Row
        BindGridFooter(_DT_GrdvwData, grdvwdata);
        //END - Calculate Sum and display in Footer Row
    }

    private void BindPrintGrid(string ChapterID, string FiscalYear)
    {
        DataTable _DT_GridPrint = new DataTable();

        using (SqlService _S = new SqlService())
        {
            _S.AddParameter(new SqlParameter("@_ChptrIDValue", ChapterID));
            _S.AddParameter(new SqlParameter("@_FiscalYrValue", FiscalYear));

            _DT_GridPrint = _S.ExecuteSPDataSet("sp_Insite3_ChapterSelfReportedImpressions_GetData").Tables[0];

            grdvwdata_export.DataSource = _DT_GridPrint;
            grdvwdata_export.DataBind();
        }

        //START - Calculate Sum and display in Footer Row
        BindGridFooter(_DT_GridPrint, grdvwdata_export);
        //END - Calculate Sum and display in Footer Row
    }

    private void BindHistoryGrid(string ChapterID, string FiscalYear)
    {
        using (SqlService _S = new SqlService())
        {
            //START - Bind History Grid
            _S.AddParameter(new SqlParameter("@_ChptrIDValue_H", ChapterID));
            _S.AddParameter(new SqlParameter("@_FiscalYrValue_H", FiscalYear));

            DataTable _DT_GridHistory = _S.ExecuteSPDataSet("sp_Insite3_ChapterSelfReportedImpressions_GetHistory").Tables[0];

            grdvwdata_history.DataSource = _DT_GridHistory;
            grdvwdata_history.DataBind();
            //END - Bind History Grid
        }
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdvwdata_history.PageIndex = e.NewPageIndex;

        BindGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

        BindHistoryGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);

        BindPrintGrid(DrpDwnLst_Chptr2.SelectedValue, DrpDwnLst_FsclYR.SelectedValue);
    }

    protected void grdvwdata_history_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Text = e.Row.Cells[1].Text.Replace("TxtBx_", "").Replace("_Value", "");
        }
    }
}