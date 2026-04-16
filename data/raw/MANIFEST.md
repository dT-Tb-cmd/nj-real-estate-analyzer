# Raw Data Manifest

Every file dropped into `data/raw/` gets a row in the table below.
Raw data is never committed (see `.gitignore`) — this manifest is the
only record of what existed. If you lose the files, this tells you
how to re-download them.

## How to add a row

When you download a file:
1. Drop it into `data/raw/`
2. Append a row to the table below with:
   - **Filename** — exactly as saved on disk
   - **Source** — URL it came from
   - **Downloaded** — date (YYYY-MM-DD)
   - **Description** — one line on what's inside
   - **License / TOS** — how can this be used? (e.g., "Redfin
     Data Center — public, attribution required")

## Files

| Filename | Source | Downloaded | Description | License / TOS |
|---|---|---|---|---|
| `redfin_zip_code_market_tracker_2026-04-14.tsv.gz` | [Redfin Data Center](https://www.redfin.com/news/data-center/) (S3: `redfin-public-data.s3.us-west-2.amazonaws.com/redfin_market_tracker/zip_code_market_tracker.tsv000.gz`) | 2026-04-15 | Full US ZIP-level market tracker, 58 columns × 9.6M rows. Monthly median sale price, PPSF, homes sold, pending sales, new listings, etc. | Public; attribution required ("Redfin, a national real estate brokerage"). Monthly update on 3rd full Fri. |
| `nj_mercer_4zips.tsv` | Derived from Redfin file above | 2026-04-15 | Filtered subset: just our 4 target ZIPs (08648, 08534, 08619, 08550). 2,794 rows, 1.5 MB. Regeneration command in notes below. | Inherits Redfin TOS |
| `zillow_zhvi_zip_allhomes.csv` | [Zillow Research](https://www.zillow.com/research/data/) — `files.zillowstatic.com/research/public_csvs/zhvi/Zip_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv` | 2026-04-16 | Zillow Home Value Index (ZHVI) by ZIP, all-homes tier, seasonally adjusted, monthly. 116 MB. | Public; attribution "Zillow Research" |
| `zillow_zhvi_4zips.csv` | Derived from ZHVI file | 2026-04-16 | Filtered to 4 target ZIPs. 27 KB. | Inherits Zillow TOS |
| `zillow_zori_zip_allhomes.csv` | [Zillow Research](https://www.zillow.com/research/data/) — `files.zillowstatic.com/research/public_csvs/zori/Zip_zori_uc_sfrcondomfr_sm_month.csv` | 2026-04-16 | Zillow Observed Rent Index (ZORI) by ZIP, monthly. 8.7 MB. | Public; attribution "Zillow Research" |
| `zillow_zori_4zips.csv` | Derived from ZORI file | 2026-04-16 | Filtered to target ZIPs (3 of 4 have ZORI coverage). | Inherits Zillow TOS |
| `census_acs5_2022_4zips.json` | [US Census ACS 5-yr 2022 API](https://api.census.gov/data/2022/acs/acs5) | 2026-04-16 | Demographics: population (B01003), median HH income (B19013), median age (B01002), total/owner-occ housing (B25003), median home value (B25077), median rent (B25064), bachelor+ (B15003_022). 4 ZIPs. | Public; CC-0 |
| `census_acs5_2022_4zips_taxes.json` | US Census ACS 5-yr 2022 API | 2026-04-16 | Property taxes: median real estate taxes paid (B25103), median monthly owner costs (B25105), median home value (B25077). 4 ZIPs. | Public; CC-0 |

## Regeneration commands

```bash
# Re-pull the full Redfin file (file updates monthly; re-fetch if > 5 weeks old)
curl -o data/raw/redfin_zip_code_market_tracker_YYYY-MM-DD.tsv.gz \
  https://redfin-public-data.s3.us-west-2.amazonaws.com/redfin_market_tracker/zip_code_market_tracker.tsv000.gz

# Re-filter to our 4 ZIPs
gunzip -c data/raw/redfin_zip_code_market_tracker_YYYY-MM-DD.tsv.gz | head -1 > data/raw/nj_mercer_4zips.tsv
gunzip -c data/raw/redfin_zip_code_market_tracker_YYYY-MM-DD.tsv.gz | \
  grep -E '"Zip Code: (08648|08534|08619|08550)"' >> data/raw/nj_mercer_4zips.tsv
```

## Sources still needed (blocked or deferred)

- **GreatSchools ratings (Q1)** — BLOCKED on API key signup at
  https://www.greatschools.org/api/. Free tier requires account creation
  + request form. Workaround for first cleaning pass: use NJ DOE school
  performance reports (public PDFs, scrape-only) or start with Zillow's
  aggregate school_rating field (less granular but per-ZIP).
- **Commute times to Midtown (Q3)** — not pulled. Options:
  1. NJ Transit GTFS feeds (free, but need schedule joining + station
     mapping). Best source for actual door-to-door.
  2. Google Distance Matrix API (paid, small credit for new accounts).
     Easier but has cost.
  3. Mapbox Matrix API (has free tier).
  Pick a path before Step 4 analysis.
- **Live MLS listings (Q5)** — out-of-band. Ask agent Alexander for a
  CSV export of active listings in 08648 matching your filters, or use
  realtor.com's free API tier (rate-limited).

## Source shortlist (planned)

- **Redfin Data Center** — https://www.redfin.com/news/data-center/
  — historical sales, ZIP-level time series
- **Zillow Research** — https://www.zillow.com/research/data/
  — ZHVI (home value index), ZORI (rent index), months-of-supply
- **US Census Bureau ACS** — https://www.census.gov/data/developers/data-sets/acs-5year.html
  — demographics, median income, owner-occupied % by tract
- **NJ OpenData** — https://data.nj.gov/
  — property tax records
- **GreatSchools API** — https://www.greatschools.org/api/
  — school ratings (free tier)
- **NJ MLS via agent Alexander** — active listings in 08648
