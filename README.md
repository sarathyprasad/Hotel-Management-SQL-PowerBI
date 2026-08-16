# 🏨 Hotel Management SQL & PowerBI Analytics Dashboard

An end-to-end database management and interactive business intelligence solution designed to analyze room occupancy rates, revenue stream performance, service usage dynamics, and staff payroll structure. 

This repository contains the full SQL database schema (DDL, DML), analytical business queries (DQL), Power BI DAX measures, native `.pbix` dashboard file, and a 3-page high-resolution PDF report export.

---

## 📌 Repository Overview & Structure

The repository structure matches the exact root files uploaded:

```text
Hotel-Management-SQL-PowerBI/
├── Hotel_Management_Dashboard.pdf       # 3-Page high-resolution dashboard PDF export
├── README.md                            # Comprehensive project documentation
├── hotel_db_dashboard_measures.dax      # Complete DAX measures used across all 3 pages
├── hotel_db_dql_queries.sql             # Analytical reporting SQL queries (DQL)
├── hotel_management_system.sql          # Complete DDL database schema & sample data (DML)
└── hotel_management_system_dashboard.pbix # Interactive Power BI Desktop report file
```

---

## 🛠️ Tech Stack & Tools

* **Database Engine:** Microsoft SQL Server (T-SQL)
* **Business Intelligence & Visualization:** Microsoft Power BI Desktop
* **Analytics & Data Modeling:** DAX (Data Analysis Expressions), Power Query (M)
* **Documentation & Storage:** Git, GitHub, PDF Export

---

## 📄 File Details & Highlights

### 1. `hotel_management_system.sql`
* Contains full **DDL (Data Definition Language)** schema definitions for 8 relational tables: `Guests`, `Rooms`, `RType`, `Services`, `Staff`, `Bookings`, `PAYMENT`, and `SUSAGE`.
* Includes **DML (Data Manipulation Language)** scripts inserting 30+ records across all entities to enable end-to-end testing.

### 2. `hotel_db_dql_queries.sql`
* Advanced SQL analytical reporting queries:
  * Room Revenue vs. Service Revenue gross totals.
  * Overall hotel room occupancy rate percentage.
  * Top 5 highest-spending guest profiles.
  * Monthly staff payroll summaries grouped by Role & Shift.
  * Service utilization counts and generated revenue.
  * Online vs. Offline booking volume & cancellation rates.

### 3. `hotel_db_dashboard_measures.dax`
* Unified DAX script containing key measures for financial, operational, and HR metrics:
  * **Financials:** `Gross Projected Revenue`, `Net Cash Position`, `Total Cash Collected`, `Total Receivables (Pending)`, `Net Cash Position running total in Month Short`.
  * **Occupancy:** `Room Occupancy Rate`, `RevPAR (Revenue Per Available Room)`, `Average Room Rate`, `Rooms Clean & Ready`, `Rooms Occupied`, `Rooms Out Of Service`.
  * **Operations & HR:** `Staff Headcount`, `Total Monthly Staff Payroll`, `Average Staff Salary`, `Total Guests Accommodated`.

### 4. `hotel_management_system_dashboard.pbix` & `Hotel_Management_Dashboard.pdf`
* A **3-Page Interactive Power BI Report**:
  * **Page 1: Financial & Revenue Performance:** Tracks gross projected revenue, cash collections, pending receivables, and monthly net cash positions.
  * **Page 2: Room Occupancy & Reservation Analytics:** Visualizes room fleet breakdown (Occupied, Clean, Maintenance), RevPAR, average rates, and stay durations.
  * **Page 3: Staff & HR Operations:** Monitors staff headcount, role/shift distributions, monthly payroll totals, and average salary trends.

---

## 🚀 How to Run & Setup

1. **Database Setup:**
   * Open **SQL Server Management Studio (SSMS)** or **Azure Data Studio**.
   * Run `hotel_management_system.sql` to generate the database schema and populate sample data.
   * Run `hotel_db_dql_queries.sql` to execute analytical business reports.

2. **Power BI Setup:**
   * Open `hotel_management_system_dashboard.pbix` directly in **Power BI Desktop**.
   * Re-link your local SQL Server data source connection if prompted.
   * Review all calculated metrics or modify DAX measures using `hotel_db_dashboard_measures.dax`.
