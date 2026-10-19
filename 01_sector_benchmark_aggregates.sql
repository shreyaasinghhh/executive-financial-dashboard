SELECT 
    c.sector,
    f.year,
    COUNT(DISTINCT c.company_id) AS num_companies,
    ROUND(SUM(f.revenue_crores), 2) AS total_revenue_cr,
    ROUND(SUM(f.pat_crores), 2) AS total_pat_cr,
    ROUND(AVG(f.pbdita_crores / NULLIF(f.revenue_crores, 0)) * 100, 2) AS avg_ebitda_margin_pct,
    ROUND(AVG(f.total_debt_crores / NULLIF(f.total_equity_crores, 0)), 2) AS avg_debt_to_equity
FROM fact_financials f
JOIN dim_company c ON f.company_id = c.company_id
GROUP BY c.sector, f.year
ORDER BY c.sector, f.year;