# 📊 Sales Performance Dashboard — SQL Server & Power BI

## Project Overview

This end-to-end Data Analytics & Business Intelligence project analyzes sales and product performance using a **Data Warehouse architecture** backed by SQL Server and visualized through a multi-page interactive Power BI dashboard. The project demonstrates a full BI pipeline — from raw data modeling in SQL to executive-ready dashboards — enabling data-driven product and sales strategy decisions.

The dashboard is structured across three dedicated pages: **Sales Overview**, **Sales Analysis**, and **Sales Details**, each serving a distinct analytical purpose.

---

## Architecture & Data Engineering

### Gold Layer — SQL Analytical View (`gold.report_products`)

The project implements a **medallion data warehouse architecture**, where the Gold Layer represents the final, business-ready data surface. A SQL analytical view was designed and implemented to:

- Aggregate raw transactional sales data into product-level summaries
- Calculate key business KPIs (sales totals, order counts, customer counts, recency, lifespan)
- Apply **product segmentation logic** classifying every product into one of three performance tiers:
  - 🟢 **High-Performers** — top revenue-generating products
  - 🟠 **Mid-Range** — moderate sales contributors
  - 🔴 **Low-Performers** — products with low sales or engagement

This Gold Layer view feeds directly into Power BI as the primary data source, ensuring a single source of truth across all dashboard pages.

---

## Key Performance Indicators

The following KPIs are surfaced on the Sales Overview page and available across the full dashboard:

| KPI | Value |
|---|---|
| **Total Products** | 130 |
| **Total Customers** | 58,922 |
| **Total Orders** | 60,398 |
| **Total Quantity Sold** | 60.42K |
| **Total Sales** | $29.36M |
| **Average Monthly Revenue** | $13.73K |

### Additional Metrics Engineered via SQL

- **Product Lifespan** — how long a product has been active in the catalog
- **Recency** — days since the product's last sale (staleness indicator)
- **Average Order Value (AOV)** — total sales divided by order count per product
- **Monthly Revenue** — time-series aggregation for trend analysis

---

## Dashboard Pages

---

### Page 1 — Sales Overview

A high-level executive summary providing headline KPIs, top performers, and underperformers at a glance.

#### 🏆 Top 10 Products by Sales

| Rank | Product | Total Sales |
|---|---|---|
| 1 | Mountain-200 Black- 46 | $1.373M |
| 2 | Mountain-200 Black- 42 | $1.363M |
| 3 | Mountain-200 Silver- 38 | $1.339M |
| 4 | Mountain-200 Silver- 46 | $1.301M |
| 5 | Mountain-200 Black- 38 | $1.295M |
| 6 | Mountain-200 Silver- 42 | $1.257M |
| 7 | Road-150 Red- 48 | $1.206M |
| 8 | Road-150 Red- 62 | $1.202M |
| 9 | Road-150 Red- 52 | $1.081M |
| 10 | Road-150 Red- 56 | $1.056M |

> The **Mountain-200** and **Road-150** series dominate the top 10, accounting for all highest-revenue products.

#### ⚠️ Bottom 5 Products by Sales

| Product | Total Sales |
|---|---|
| Touring Tire Tube | $7.44K |
| Bike Wash - Dissolver | $7.27K |
| Patch Kit/8 Patches | $6.38K |
| Racing Socks- M | $2.68K |
| Racing Socks- L | $2.43K |

> Racing Socks and the Patch Kit represent the weakest-performing products and are prime candidates for pricing review or discontinuation.

---

### Page 2 — Sales Analysis

A deep-dive analytical page examining category structure, segment performance, and cost efficiency.

#### 🌊 Sales by Product Category and Top 3 Subcategories (Decomposition Tree)
Breaking down the total $29.36M across categories:

| Category | Total Sales | Top Subcategory | Sales |
|---|---|---|---|
| **Bikes** | $28,316,272 | Road Bikes | $14,519,438 |
| | | Mountain Bikes | $9,952,254 |
| | | Touring Bikes | $3,844,580 |
| **Accessories** | $700,262 | — | — |
| **Clothing** | $339,716 | — | — |

> Bikes represent **96.4% of total revenue**, making it the overwhelmingly dominant category. Accessories and Clothing are significant in unit volume but minimal in revenue contribution.

#### 💹 Cost vs. Sales by Product Segment (Bubble Chart)
A scatter/bubble chart plotting Total Cost vs. Total Sales per segment:
- **High-Performers** — high cost (~80K), very high sales (~$28M+) — best ROI
- **Mid-Range** — moderate cost (~20K), moderate sales (~$8M)
- **Low-Performers** — low cost, near-zero sales — poorest return

#### 🍩 Product Distribution by Segment (Donut Chart)
| Segment | Products | Share |
|---|---|---|
| High-Performers | 65 | 50.0% |
| Mid-Range | 53 | 40.8% |
| Low-Performers | 12 | 9.2% |

#### 📦 Orders by Product Category (Donut Chart)
| Category | Orders | Share |
|---|---|---|
| Bikes | 36K | 60% |
| Accessories | 15K | 25% |
| Clothing | 9K | 15% |

#### 🏅 Top 5 Subcategories by Total Sales (Donut Chart)
| Subcategory | Share |
|---|---|
| Road Bikes | 36% |
| Mountain Bikes | 26% |
| Touring Bikes | 21% |
| Tires and Tubes | 10% |
| Jerseys | 7% |

---

### Page 3 — Sales Details

A granular, filterable data table providing product-level detail for operational and inventory analysis.

**Columns displayed:**

| Column | Description |
|---|---|
| `product_name` | Full product name |
| `product_segment` | High-Performers / Mid-Range / Low-Performers |
| `category` | Accessories / Bikes / Clothing |
| `subcategory` | Specific product type |
| `Sum of total_customers` | Total unique customers per product |
| `Sum of recency` | Days since last sale (freshness indicator) |
| `Sum of lifespan` | Active days in catalog |
| `Sum of cost` | Total product cost |

This page enables analysts to drill into any product's full performance profile and supports decisions around inventory management, pricing, and catalog rationalization.

---

## Interactive Filter Panel

All three pages share a synchronized filter sidebar:

| Filter | Options |
|---|---|
| **product_segment** | High-Performers, Low-Performers, Mid-Range |
| **Product Category** | Accessories, Bikes, Clothing |
| **Product Subcategory** | All (dropdown) |

A **Clear All Slicers / Reset Filters** button is available on each page for one-click filter reset.

---

## Key Business Insights

| # | Insight | Implication |
|---|---|---|
| 1 | **Bikes generate 96.4% of revenue** | Strategic focus should be on bike product lines; accessories are volume not value drivers |
| 2 | **Mountain-200 and Road-150 dominate the top 10** | These SKUs deserve priority in inventory, marketing, and supply chain planning |
| 3 | **50% of products are High-Performers** | A healthy catalog distribution; the 9.2% Low-Performers should be reviewed for discontinuation |
| 4 | **Road Bikes lead subcategory sales at 36%** | Road segment is the primary growth engine within the Bikes category |
| 5 | **Racing Socks are the lowest-revenue product** | Candidates for removal, bundling, or significant repricing |
| 6 | **High-Performers show the best cost-to-sales ratio** | Investment in this segment yields the highest return on cost |

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL Server** | Data warehouse implementation and Gold Layer view design |
| **Data Warehouse Modeling** | Medallion architecture (Bronze → Silver → Gold) |
| **Power BI Desktop** | Multi-page dashboard design and publishing |
| **DAX** | KPI measures, segmentation logic, and calculated columns |
| **Power Query** | Data transformation and model preparation |

---

## Skills Demonstrated

- Data warehouse design with Gold Layer analytical views
- SQL aggregation, window functions, and KPI calculation
- Product segmentation logic using business rules in SQL
- Multi-page Power BI report architecture with shared slicers
- Decomposition tree and bubble chart design for executive storytelling
- Cost vs. revenue performance analysis
- Drill-down from summary KPIs to granular product detail
- End-to-end BI pipeline from SQL modeling to dashboard publication
