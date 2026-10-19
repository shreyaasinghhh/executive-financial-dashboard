WITH company_growth AS (
    SELECT 
        c.company_name,
        c.sector,
        f.year,
        f.revenue_crores,
        f.pbdita_crores,
        ROUND((f.pbdita_crores / NULLIF(f.revenue_crores, 0)) * 100, 2) AS ebitda_margin_pct,
        LAG(f.revenue_crores) OVER (PARTITION BY f.company_id ORDER BY f.year) AS prev_rev,
        LAG((f.pbdita_crores / NULLIF(f.revenue_crores, 0)) * 100) OVER (PARTITION BY f.company_id ORDER BY f.year) AS prev_margin
    FROM fact_financials f
    JOIN dim_company c ON f.company_id = c.company_id
)
SELECT 
    company_name,
    sector,
    year,
    revenue_crores,
    ROUND(((revenue_crores - prev_rev) / NULLIF(prev_rev, 0)) * 100, 2) AS yoy_rev_growth_pct,
    ebitda_margin_pct,
    ROUND(ebitda_margin_pct - prev_margin, 2) AS margin_expansion_bps
FROM company_growth
WHERE year >= 2006
ORDER BY sector, company_name, year;