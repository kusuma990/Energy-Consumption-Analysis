# Energy Consumption Analysis
**Project Overview:**

This project explores global energy consumption, production, emissions, GDP, and population data across multiple countries.
The dataset is sourced from the EIA (U.S. Energy Information Administration), which tracks worldwide energy statistics.

Through this project, we aim to:
- Understand the relationship between economic power, energy usage, and emissions.
- Perform SQL-based data analysis to uncover global energy and environmental trends.

**Key Objectives:**
- Design and normalize a relational database using MySQL.
- Import and integrate 6 CSV datasets into relational tables.
- Perform data exploration and analysis using SQL queries.
- Answer key questions about global energy, economy, and sustainability.

**Dataset Description:**
- The project uses six structured CSV files, imported into a MySQL database named ENERGYDB2.
| Table Name    | Description                            | Key Columns                                                         | Relationship   |
| ------------- | -------------------------------------- | ------------------------------------------------------------------- | -------------- |
| `country`     | Master table of countries              | `CID`, `Country`                                                    | Primary table  |
| `consumption` | Energy consumption by country and year | `country`, `energy`, `year`, `consumption`                          | FK → `country` |
| `production`  | Energy production data                 | `country`, `energy`, `year`, `production`                           | FK → `country` |
| `emission_3`  | CO₂ emission statistics                | `country`, `energy_type`, `year`, `emission`, `per_capita_emission` | FK → `country` |
| `population`  | Population by country and year         | `countries`, `year`, `Value`                                        | FK → `country` |
| `gdp_3`       | GDP (PPP) data by country and year     | `Country`, `year`, `Value`                                          | FK → `country` |

- Each table (except country) maintains a foreign key relationship referencing the Country column in the country table.

**Database Schema (ER Diagram):**
country (1)
│
├──< emission_3

├──< population

├──< production

├──< consumption

└──< gdp_3

**Database Creation & Setup:**
1. Create Database
2. Create Tables
3. Data Import Procedure
  - Launch MySQL Workbench and create the database ENERGYDB2.
  - Right-click on the database → Table Data Import Wizard.
  - Import each CSV file into its corresponding table:
    - country.csv
    - emission_3.csv
    - population.csv
    - production.csv
    - gdp_3.csv
    - consumption.csv
   
**Data Analysis Queries:**
1. General & Comparative Analysis
2. Trend Analysis Over Time
3. Ratio & Per Capita Analysis
4. Global Comparisons

**Insights You Can Derive:**
- Which countries are most energy-efficient (low emissions, high GDP)?
- How do developed vs developing countries differ in consumption and production?
- Correlation between population growth and emissions.-
- Identifying sustainable energy leaders.

**Tools & Technologies Used:**
| Tool                            | Purpose                       |
| ------------------------------- | ----------------------------- |
| **MySQL**                       | Database design & analysis    |
| **MySQL Workbench**             | ER diagram, schema management |
| **CSV Files (EIA Data)**        | Source dataset                |
| **Excel / Power BI (optional)** | Visualization of SQL results  |

**Future Enhancements:**
- Add Power BI dashboards for visual insights.
- Use Python (Pandas + SQLAlchemy) for automation.
- Create stored procedures for complex analytics.
- Build a web-based dashboard for interactive exploration.

**Author:**
Kusuma Kumari Bodduluri
Data Science & Analytics Enthusiast
India
