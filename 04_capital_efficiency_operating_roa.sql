WITH efficiency_ranked AS (
    SELECT 
        c.company_name,
        c.sector,
        f.year,
        ROUND((f.pbdita_crores / NULLIF(f.total_assets_crores, 0)) * 100, 2) AS operating_roa_pct,
        DENSE_RANK() OVER (
            PARTITION BY c.sector 
            ORDER BY (f.pbdita_crores / NULLIF(f.total_assets_crores, 0)) DESC
        ) AS sector_efficiency_rank
    FROM fact_financials f
    JOIN dim_company c ON f.company_id = c.company_id
)
SELECT * FROM efficiency_ranked
ORDER BY sector, sector_efficiency_rank;
