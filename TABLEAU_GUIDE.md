# Tableau Public — Workbook Build Guide

Step-by-step recipe for building the dashboard once Tableau Public is
installed. Don't open Tableau until the install is complete.

## Data sources (CSVs ready in `data/clean/tableau_csvs/`)

| File | Use for |
|---|---|
| `neighborhood_summary.csv` | One-glance comparison view (4 rows) — START HERE |
| `redfin_monthly.csv` | Time series chart (price trend, 676 rows, 2012-2026) |
| `zhvi_monthly.csv` | Long Zillow time series (1,256 rows, 2000-2026) |
| `zori_monthly.csv` | Rent overlay if needed (75 rows) |
| `demographics.csv` | Demographics for tooltips |
| `taxes.csv` | Tax data for tooltips |

## First open — connect to data

1. Launch **Tableau Public**
2. On the welcome screen, click **Connect to Data**
3. Choose **Text File**
4. Navigate to `C:\Users\terre\dev\nj-real-estate-analyzer\data\clean\tableau_csvs\`
5. Pick **neighborhood_summary.csv** first
6. Click **Sheet 1** at the bottom to start building

## View 1 — Map (the headline view)

**Dataset:** neighborhood_summary.csv

1. Drag **zip** to the **Detail** card
2. Tableau auto-recognizes ZIPs as geography → it builds a US map
3. Click **Show Me** in the upper right and pick **symbol map**
4. Drag **redfin_latest_sale** to **Color** → bigger circles for pricier ZIPs
5. Drag **name** to **Label** so the map shows ZIP names
6. Zoom to NJ — drag the map until just Mercer County is visible
7. Right-click the sheet tab at the bottom, rename to **Map**

## View 2 — Price trend (the time series)

**Dataset:** redfin_monthly.csv (add as second data source: Data menu → New Data Source)

1. Drag **period_begin** to **Columns**
2. Right-click it → choose **Year** (or **Quarter**) granularity
3. Drag **median_ppsf** to **Rows**
4. Drag **zip** to **Color** so each ZIP gets its own line
5. Show Me → **line chart**
6. Add a title: "Price per Sqft, 2012-2026"
7. Rename sheet to **Price Trend**

## View 3 — Tax comparison (the bar chart)

**Dataset:** neighborhood_summary.csv

1. Drag **name** to **Columns**
2. Drag **effective_tax_rate_pct** to **Rows**
3. Drag **annual_taxes** to **Label** (so each bar shows the dollar amount)
4. Color by **taxes_topcoded** so the topcoded bars are visually flagged
5. Sort descending by tax rate
6. Rename sheet to **Tax Burden**

## Combine into a dashboard

1. Click the **New Dashboard** icon at the bottom (looks like a grid)
2. Set Size → **Custom**, 1200 x 800 (or pick **Automatic**)
3. Drag **Map** sheet in (top half)
4. Drag **Price Trend** in (bottom-left)
5. Drag **Tax Burden** in (bottom-right)
6. Add a title across the top: "NJ Real Estate Market — Lawrenceville Area"
7. Add filters across all sheets — drag `name` to Filters, then right-click → Apply to All Worksheets

## Publish to Tableau Public

1. **File menu** → **Save to Tableau Public As...**
2. Sign in with the account you created during install
3. Workbook name: **NJ-Lawrenceville-Real-Estate-2026**
4. Hit save
5. Browser opens with the live URL — copy it
6. Paste the URL into the project hub note's "Live demo" line

## Style notes

- Default Tableau colors are fine. Don't reach for custom palettes until v2.
- Title every chart in plain English ("Price per Sqft" not "median_ppsf").
- Add one-line subtitle per chart explaining what it shows.
- Footer: data sources (Redfin, Zillow, Census 2022), date snapshot.

## Troubleshooting

**Map shows the whole US, not Mercer County:**
- Click the **Map** menu → **Map Layers** → uncheck most layers
- Hold Shift and drag to pan, scroll wheel to zoom

**ZIPs show as numbers (08648 → 8648):**
- Right-click `zip` in the Data pane → **Change Data Type** → **String**
- Then right-click again → **Geographic Role** → **Zip Code**

**Tableau connecting to wrong CSV:**
- Data menu → Edit Data Source → point to the right file
