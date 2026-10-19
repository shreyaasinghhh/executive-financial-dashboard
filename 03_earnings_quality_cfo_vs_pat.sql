SELECT 
    c.company_name,
    c.sector,
    f.year,
    f.pat_crores,
    f.operating_cash_flow_crores AS cfo_crores,
    ROUND(f.operating_cash_flow_crores - f.pat_crores, 2) AS cash_earnings_gap_cr,
    ROUND((f.operating_cash_flow_crores / NULLIF(f.pat_crores, 0)), 2) AS cfo_to_pat_ratio,
    CASE 
        WHEN (f.operating_cash_flow_crores / NULLIF(f.pat_crores, 0)) >= 1.0 THEN 'High Quality'
        WHEN (f.operating_cash_flow_crores / NULLIF(f.pat_crores, 0)) BETWEEN 0.7 AND 1.0 THEN 'Moderate'
        ELSE 'Working Capital Drag / Low Quality'
    END AS earnings_quality_flag
FROM fact_financials f
JOIN dim_company c ON f.company_id = c.company_id
ORDER BY c.sector, cfo_to_pat_ratio DESC;