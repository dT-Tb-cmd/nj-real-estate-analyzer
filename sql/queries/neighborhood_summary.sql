-- Neighborhood Summary
-- Single-query snapshot comparing all 4 target ZIPs on price, income,
-- ownership, and tax burden. Pulls from 4 tables.
-- First used: Cell 9 of notebooks/01-cleaning.ipynb
-- Answers (partially): Q4 of scope

WITH latest_redfin AS (
    SELECT zip, median_sale_price, median_ppsf, homes_sold
    FROM redfin_monthly r1
    WHERE period_begin = (
        SELECT MAX(period_begin) FROM redfin_monthly r2 WHERE r2.zip = r1.zip
    )
),
latest_zhvi AS (
    SELECT zip, zhvi
    FROM zhvi_monthly z1
    WHERE month = (
        SELECT MAX(month) FROM zhvi_monthly z2 WHERE z2.zip = z1.zip
    )
)
SELECT
    d.zip,
    d.population,
    d.median_hh_income AS income,
    d.pct_owner_occupied AS owner_pct,
    lr.median_sale_price AS redfin_latest_sale,
    lz.zhvi AS zhvi_latest,
    t.median_real_estate_taxes AS annual_taxes,
    t.effective_tax_rate_pct AS tax_rate_pct,
    t.taxes_topcoded
FROM demographics d
LEFT JOIN latest_redfin lr ON d.zip = lr.zip
LEFT JOIN latest_zhvi   lz ON d.zip = lz.zip
LEFT JOIN taxes         t  ON d.zip = t.zip
ORDER BY d.zip;
