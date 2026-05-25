# SQL Retail Business Analysis

Business intelligence analysis of a national bicycle retail chain using MySQL. I used SQL to answer real strategic questions about pricing, inventory, paint color performance, and parts sales across states and stores.

The source database was provided as part of a graduate database course at ETSU. This repo contains the queries, schema, and full query output.

---

## The Business Questions I Answered

### 1. Pricing by State and Store
Which states have the highest average list price vs sale price? Which stores price above or below the Tennessee state average? Where does Tennessee rank nationally?

**What the data showed:**
- California had the highest average list price at $3,106
- Tennessee ranked 34th nationally — a balanced mid-range market
- 19 Tennessee stores priced above the state average, 18 below

### 2. Paint Color Performance
Which colors drive the most revenue? Which stores sell the most and least of the top and bottom performers?

**What the data showed:**
- Arctic White dominated with 2,000+ units sold and $6.1M in revenue
- Candy Stripe was the lowest performer
- Walk-In stores led sales for both the most and least popular colors
- Beverly Hills Bike Shop sold the least Arctic White (5 units)

### 3. Parts Manufacturer Analysis
Who is the most popular parts manufacturer? Which states and stores sell the most of their parts?

**What the data showed:**
- Shimano (USA) led with 195,000+ parts sold
- Front Derailleur was their top part
- California led state sales with 1,089 units and $3.26M in revenue
- Delaware had the lowest with just 3 units
- Budget Pro Bicycles led store sales excluding walk-in and direct channels

---

## SQL Techniques Used

- CTEs (Common Table Expressions)
- Window functions with `DENSE_RANK`
- Correlated subqueries
- `ROLLUP` for subtotals
- Multi-table JOINs across 8+ tables
- `HAVING` with aggregate filters
- `GROUP BY` with multiple dimensions

---

## Files in This Repo

| File | Description |
|------|-------------|
| `Project4_Queries.sql` | All queries with business context comments |
| `Project4_Schema.png` | Full database schema diagram |
| `Project_4_Result.docx` | Written analysis with interpretations |
| `S1.csv` | Average list price and sale price by state |
| `S2.csv` | Average prices by store |
| `S2a_above.csv` | Tennessee stores above state average |
| `S2a_below.csv` | Tennessee stores below state average |
| `S3_most.csv` | Most popular paint color results |
| `S3_least.csv` | Least popular paint color results |
| `S3ai.csv` | Stores selling most of most popular color |
| `S3aii.csv` | Stores selling least of most popular color |
| `S3bi.csv` | Stores selling most of least popular color |
| `S3bii.csv` | Stores selling least of least popular color |
| `S4.csv` | Most popular parts manufacturer |
| `S4a.csv` | States selling most of top parts |
| `S4b.csv` | States selling least of top parts |
| `S4c.csv` | Store-level parts sales excluding walk-in and direct |

---

## Tools Used

- MySQL
- MySQL Workbench
- Excel

---

## About

I'm a data analyst who finds the story behind the numbers. This project sits at the intersection of database querying and business intelligence answering the kind of questions that actually drive inventory and pricing decisions.

Connect with me on [LinkedIn](https://www.linkedin.com/in/sharon-smith-analyst)
