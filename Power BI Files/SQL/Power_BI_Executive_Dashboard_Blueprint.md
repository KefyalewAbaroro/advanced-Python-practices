# Power BI Executive Sales Dashboard — 5-Page Blueprint

**Data source:** `Sales_Dashboard_Source.xlsx` (Sales_Data table)
**Build time estimate:** 45–60 minutes in Power BI Desktop

---

## Before you start: connect and build measures

1. Home → Get Data → Excel Workbook → select `Sales_Dashboard_Source.xlsx` → check **Sales_Data** → Load.
2. Go to Model view. Confirm `OrderDate` is typed as Date.
3. Create a **Date table** for proper time intelligence: Modeling → New Table
   ```
   DateTable = CALENDAR(MIN(Sales_Data[OrderDate]), MAX(Sales_Data[OrderDate]))
   ```
   Then add columns for Year, Month, Month Name, Quarter, and mark it as a Date Table (Table tools → Mark as Date Table). Relate `DateTable[Date]` → `Sales_Data[OrderDate]`.
4. Create these core DAX measures (Modeling → New Measure) in Sales_Data:
   ```
   Total Revenue = SUM(Sales_Data[Revenue])
   Total Profit = SUM(Sales_Data[Profit])
   Profit Margin % = DIVIDE([Total Profit], [Total Revenue])
   Total Orders = DISTINCTCOUNT(Sales_Data[OrderID])
   Avg Order Value = DIVIDE([Total Revenue], [Total Orders])
   Total Units Sold = SUM(Sales_Data[Quantity])
   Revenue PY = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DateTable[Date]))
   Revenue YoY % = DIVIDE([Total Revenue] - [Revenue PY], [Revenue PY])
   ```

---

## Page 1 — Executive Overview

**Purpose:** the one page a CEO reads if they only read one.

**Layout:** top row of KPI cards, middle row of trend + breakdown charts, bottom strip of narrative summary text box.

| Element | Type | Fields |
|---|---|---|
| Total Revenue | Card | `[Total Revenue]` |
| Total Profit | Card | `[Total Profit]` |
| Profit Margin % | Card | `[Profit Margin %]` |
| Revenue YoY % | Card w/ KPI indicator | `[Revenue YoY %]` |
| Total Orders | Card | `[Total Orders]` |
| Revenue Trend | Line chart | Axis: DateTable[Month], Value: `[Total Revenue]` |
| Revenue by Region | Donut chart | Legend: Region, Value: `[Total Revenue]` |
| Revenue by Category | Bar chart (horizontal) | Axis: Category, Value: `[Total Revenue]` |
| Executive summary | Text box | 2–3 auto-updating sentences (see below) |

**Slicers (top of page, applies to all 5 pages via sync):** Date range, Region, Category.

**Executive summary text box tip:** use a measure + card visual for a dynamic sentence:
```
Summary Text =
"Revenue reached " & FORMAT([Total Revenue], "$#,##0") &
" with a " & FORMAT([Profit Margin %], "0.0%") & " margin, " &
IF([Revenue YoY %] >= 0, "up ", "down ") & FORMAT(ABS([Revenue YoY %]), "0.0%") & " YoY."
```

---

## Page 2 — Sales Performance

**Purpose:** trend detail and salesperson leaderboard.

| Element | Type | Fields |
|---|---|---|
| Revenue vs Profit Trend | Combo chart (line + column) | Axis: Month, Columns: Revenue, Line: Profit Margin % |
| Salesperson Leaderboard | Table or bar chart | Salesperson, `[Total Revenue]`, `[Total Orders]`, `[Avg Order Value]` sorted descending |
| Orders by Month | Column chart | Axis: Month, Value: `[Total Orders]` |
| Top 5 Salespeople | Ranked bar chart | Top N filter = 5 on Salesperson by Revenue |
| Region performance matrix | Matrix | Rows: Region, Columns: Category, Values: Revenue |

**Interaction tip:** enable cross-filtering so clicking a salesperson bar filters the trend chart above it.

---

## Page 3 — Product Analysis

**Purpose:** which products/categories drive revenue and margin.

| Element | Type | Fields |
|---|---|---|
| Revenue by Product | Bar chart | Axis: Product, Value: `[Total Revenue]`, sorted descending |
| Margin by Category | Bar chart | Axis: Category, Value: `[Profit Margin %]` |
| Product Revenue Share | Treemap | Group: Category → Product, Value: Revenue |
| Units Sold by Product | Column chart | Axis: Product, Value: `[Total Units Sold]` |
| Product detail table | Table | Product, Category, Revenue, Profit, Margin %, Units Sold — with data bars on Revenue column |

**Tip:** conditional formatting (background color scale) on the Margin % column highlights low-margin products for the exec team.

---

## Page 4 — Regional & Customer Analysis

**Purpose:** geographic and customer concentration view.

| Element | Type | Fields |
|---|---|---|
| Revenue by Region | Map or filled map | Location: Region, Size/Color: Revenue |
| Region Trend Comparison | Multi-line chart | Axis: Month, Legend: Region, Value: Revenue |
| Top 10 Customers | Bar chart | Top N = 10 on Customer by Revenue |
| Region KPI cards | Multi-row card | Revenue, Orders, Avg Order Value per Region |
| Customer concentration | Table | Customer, Revenue, % of Total Revenue (measure: `DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Sales_Data)))`) |

---

## Page 5 — Executive Summary / Narrative

**Purpose:** printable one-pager, board-meeting style — mostly text and key visuals, minimal clutter.

| Element | Type | Fields |
|---|---|---|
| Headline KPIs | 4 large cards | Revenue, Profit, Margin %, YoY % |
| Key trend | Small sparkline-style line chart | Monthly revenue, last 12 months |
| Top performer callouts | 3 text boxes / cards | Top Region, Top Product, Top Salesperson (use TOPN measures) |
| Narrative commentary | Text box | Bullet-point takeaways (manually written or dynamic measure-based sentences) |
| Regional snapshot | Small multiples or mini bar chart | Region vs Revenue, compact |

**Design tip:** turn off gridlines and axis clutter on this page — it should read like a printed exec memo, not a working dashboard. Use Power BI's "Page view → Fit to page" and export to PDF for distribution (File → Export → Export to PDF).

---

## General styling across all 5 pages

- **Theme:** View → Themes → pick one accent color consistent with your brand; apply to all pages.
- **Consistent slicer panel:** put Date/Region/Category slicers in the same top strip on every page, and use "Sync slicers" (View → Sync Slicers) so filtering persists as the exec clicks through pages.
- **Titles:** every page needs a clear title text box (e.g., "Sales Performance — FY24–25").
- **Card number formatting:** always show currency/percent formatting, never raw decimals.
- **Tooltips:** enable report page tooltips for extra context on hover without cluttering the page.
- **Navigation:** add a simple button/tab bar at the top of Page 1 linking to Pages 2–5 (Insert → Buttons → Page Navigator) for one-click executive navigation.
