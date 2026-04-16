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
