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
| *(none yet)* | | | | |

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
