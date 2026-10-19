# Corporate Financial Benchmark & Analytics Project
This project is an end-to-end financial analytics pipeline built across Excel, SQL, and Power BI. It benchmarks 20 years of historical performance across key players in the Indian Automotive and FMCG sectors, focusing on revenue trajectory, operational profitability (EBITDA margin), and actual cash quality (CFO to PAT conversion).

![Dashboard Preview](dashboard_preview.png)

---

## Why This Project?
Analyzing corporate growth on top-line numbers alone can often hide operating stress or poor cash realization. I built this project to answer three practical business questions:
1. Which companies consistently maintain high operating margins across distinct economic cycles?
2. Are reported accounting profits actually translating into operating cash flow (CFO vs. PAT)?
3. How do sector-wide revenue trajectories compare over a long-term horizon?

---

## The Workflow

### 1. Excel (Data Auditing & Initial Cleansing)
- Standardized reported metrics across companies and years.
- Handled missing periods, resolved inconsistencies in unit reporting (Crores), and validated core cash-flow metrics.

### 2. SQL (Relational Modeling & Aggregations)
- Structured the raw data into a clean Star Schema:
  - **`dim_company`**: Company details, sector, and industry classifications.
  - **`fact_financials`**: Financial line items across years (Revenue, EBITDA, PAT, and CFO).
- Designed queries to join dimension and fact tables, calculate YoY movements, and verify ratios before loading into BI.

### 3. Power BI (Data Modeling, DAX & Visualization)
- Established 1-to-many single-direction relationships between `dim_company` and `fact_financials`.
- Authored explicit DAX measures:
  - **Total Revenue (Cr)**:
    ```dax
    Total Revenue (Cr) = SUM(fact_financials[revenue_crores])
    ```
  - **EBITDA Margin %**:
    ```dax
    EBITDA Margin % = DIVIDE([Total EBITDA (Cr)], [Total Revenue (Cr)], 0)
    ```
  - **CFO to PAT Ratio**:
    ```dax
    CFO to PAT Ratio = DIVIDE([Total CFO (Cr)], [Total PAT (Cr)], 0)
    ```
- Built an interactive executive layout featuring dropdown slicers, real-time KPI cards, dynamic sector filtering, and multi-line historical trends.

---

## Repository Structure
- `Executive_Financial_Dashboard.pbix` — Interactive Power BI report file.
- `dashboard_preview.png` — Canvas snapshot.
- `*.sql` / `*.xlsx` — Supporting transformation scripts and source data.

---

## License & Terms

Copyright (c) 2026. All rights reserved.

This repository is shared strictly for portfolio, evaluation, and showcase purposes. No permission is granted to copy, reproduce, modify, distribute, or reuse this work, model, or visual assets for commercial or personal projects without explicit written consent.
