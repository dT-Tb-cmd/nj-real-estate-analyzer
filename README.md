# NJ Real Estate Market Analyzer

This project pulls 14 years of public housing data
to help us decide where to buy

## What this answers

I locked in five questions before touching any data:

1. **Schools vs. price ratio** — which 08648 neighborhoods have the
   best median price for the school rating you get?
2. **Price-per-sqft trend (2012-2026)** — has 08648 grown faster or
   slower than nearby ZIPs?
3. **Commute** — which neighborhoods give my wife a ≤75 min transit
   ride to Midtown?
4. **Tax burden** — what's the property tax delta across
   Lawrenceville, Hamilton, Pennington, and Princeton Jct?
5. **Live listings** — which homes on the market right now match our
   filter (3+ bed, ≤$550K, school rating ≥7)?

Two of the five (Q2 and Q4) are answered fully in this repo. Q1 and Q3
are pulling from external sources still in flight (GreatSchools API
approval, Mapbox setup). Q5 is out-of-band — coming from our agent.

## Key findings so far

### Q2 — Price-per-sqft trend (2012-2026)

All four Mercer County ZIPs grew at remarkably similar rates between
2012 and 2026 — **4.50% to 4.67% compound annual growth**. The spread
is only 0.17 percentage points, which tells me **the region moves as
one housing market**, not four separate ones.

**Lawrenceville (08648) actually led the pack** at 4.67% CAGR, rising
from $147/sqft to $279/sqft — an **89.4% total gain**. Hamilton grew
slowest at 4.50% but still nearly doubled.

| Rank | ZIP | Name | 2012 → 2026 $/sqft | CAGR |
|---|---|---|---|---|
| 1 | 08648 | Lawrenceville | $147 → $279 | 4.67% |
| 2 | 08550 | Princeton Jct | $209 → $390 | 4.56% |
| 3 | 08534 | Pennington | $176 → $327 | 4.52% |
| 4 | 08619 | Hamilton | $145 → $268 | 4.50% |

**Takeaway:** Buying in Lawrenceville means buying into a coherent
regional market with steady appreciation — not a frothy bubble or a
stagnant zone. There's no "better" ZIP on price growth alone in this
4-ZIP set.

*Notebook: [`notebooks/02-q2-price-trends.ipynb`](notebooks/02-q2-price-trends.ipynb)*

### Q4 — Tax burden

For a hypothetical **$500K home**, annual property tax by ZIP:

| ZIP | Name | Effective rate | Annual tax on $500K |
|---|---|---|---|
| 08619 | Hamilton | 2.72% | $13,600 |
| **08648** | **Lawrenceville** | **2.28%** | **$11,400** |
| 08534 | Pennington | ≥1.83% | ≥$9,150 |
| 08550 | Princeton Jct | ≥1.40% | ≥$7,000 |

(Pennington and Princeton Jct rates are lower bounds — Census
top-codes tax data at $10,001 for privacy.)

**Takeaway:** Hamilton costs **$2,200/year more than Lawrenceville**
on the same home — **$66,000 over a 30-year mortgage**. For our
budget, **Lawrenceville has a meaningful tax advantage over Hamilton**
and is roughly break-even with the premium ZIPs once their higher
absolute home values are factored in.

*Notebook: [`notebooks/03-q4-tax-delta.ipynb`](notebooks/03-q4-tax-delta.ipynb)*

## Tech stack

- **Python** — pandas for cleaning, matplotlib for charts
- **SQLite** — local single-file database, queried with SQL
- **SQL** — CTEs, joins, window functions for time-series queries
- **Jupyter** — narrated analysis notebooks
- **Tableau Public** — interactive dashboard (`.twb` in `tableau/`)
- **git / GitHub** — version control + portfolio hosting

## Data sources (all free, all public)

- **Redfin Data Center** — quarterly market tracker by ZIP, 2012-2026
  ([source](https://www.redfin.com/news/data-center/))
- **Zillow Research** — monthly home value index (ZHVI) and rent index
  (ZORI) by ZIP ([source](https://www.zillow.com/research/data/))
- **US Census Bureau ACS 5-year (2022)** — demographics + property
  taxes by ZIP code tabulation area
  ([source](https://www.census.gov/data/developers/data-sets/acs-5year.html))

See `data/raw/MANIFEST.md` for exact file URLs, download dates, and
regeneration commands.

## Repo structure

```
nj-real-estate-analyzer/
├── README.md                      ← you are here
├── findings.md                    ← one-paragraph finding per question
├── TABLEAU_GUIDE.md               ← step-by-step dashboard build
├── notebooks/
│   ├── 01-cleaning.ipynb          ← raw → SQLite pipeline
│   ├── 02-q2-price-trends.ipynb   ← Q2 analysis
│   └── 03-q4-tax-delta.ipynb      ← Q4 analysis
├── sql/
│   ├── schema.sql                 ← table reference
│   └── queries/
│       └── neighborhood_summary.sql
├── tableau/
│   └── NJ-Lawrenceville-Real-Estate-2026.twb
└── data/
    ├── raw/MANIFEST.md            ← what raw files are needed
    └── clean/MANIFEST.md          ← built tables in housing.db
```

Raw and cleaned data files are **not committed** (see `.gitignore`).
The manifests are the reproducible record — anyone can rebuild from
scratch by following them.

## Reproducing this on your machine

```bash
# 1. Clone
git clone https://github.com/dT-Tb-cmd/nj-real-estate-analyzer.git
cd nj-real-estate-analyzer

# 2. Pull the raw data (see data/raw/MANIFEST.md for URLs)
#    Redfin (1.5 GB) + Zillow (~125 MB) + Census API calls

# 3. Run the cleaning notebook to build housing.db
jupyter lab notebooks/01-cleaning.ipynb
#    → Run All Cells

# 4. Run the analysis notebooks
jupyter lab notebooks/02-q2-price-trends.ipynb
jupyter lab notebooks/03-q4-tax-delta.ipynb

# 5. (Optional) open the Tableau workbook
#    Requires Tableau Public Desktop (free)
#    File: tableau/NJ-Lawrenceville-Real-Estate-2026.twb
```

## What's next / what's missing

- **Q1 (schools)** — waiting on GreatSchools API approval. Will pull
  ratings for all schools in the 4 ZIPs and overlay on price data.
- **Q3 (commute)** — Mapbox Distance Matrix API setup pending. Will
  compute door-to-door transit times to Midtown NYC.
- **Q5 (live listings)** — pulling current MLS feed via our agent.
- **Tableau Public hosting** — workbook lives in this repo as a
  `.twb`; live online URL deferred (install issue with the desktop
  client).

## License

Code: MIT.
Data: subject to source licenses (Redfin, Zillow, US Census). See
`data/raw/MANIFEST.md` for per-source attribution requirements.
