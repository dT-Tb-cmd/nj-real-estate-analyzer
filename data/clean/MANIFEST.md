# Clean Data Manifest

Tables in `housing.db` and CSV exports for Tableau.

## SQLite tables (housing.db, 136 KB)

| Table | Rows | Source |
|---|---|---|
| `redfin_monthly` | 676 | Redfin filtered, "All Residential" only |
| `zhvi_monthly` | 1,256 | Zillow ZHVI melted to long format |
| `zori_monthly` | 75 | Zillow ZORI (3 of 4 zips have coverage) |
| `demographics` | 4 | Census ACS 5-yr 2022 |
| `taxes` | 4 | Census ACS 5-yr 2022 |

Total: 2,015 rows across 5 tables.

## CSV exports for Tableau (`tableau_csvs/`)

Tableau Public free tier doesn't connect to SQLite — these CSVs are
the consumable copies.

| File | Rows | Use |
|---|---|---|
| `neighborhood_summary.csv` | 4 | Pre-joined snapshot, start with this in Tableau |
| `redfin_monthly.csv` | 676 | Time series for price-trend chart |
| `zhvi_monthly.csv` | 1,256 | Long Zillow series |
| `zori_monthly.csv` | 75 | Rent overlay (optional) |
| `demographics.csv` | 4 | Demographics, tooltip data |
| `taxes.csv` | 4 | Tax data, tooltip data |

Regenerate by re-running `notebooks/01-cleaning.ipynb` then the CSV
export script (one-liner — see `data/raw/MANIFEST.md` regeneration section).
