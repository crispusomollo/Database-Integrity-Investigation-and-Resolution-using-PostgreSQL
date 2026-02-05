# PostgreSQL ERP Data Integrity Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue)
![Bash](https://img.shields.io/badge/Bash-Automation-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## Overview
This project demonstrates a practical PostgreSQL database integrity solution for a simulated ERP environment.

### Business Scenario
During month-end ERP reporting, the Finance team identified inconsistencies:

- Assets appearing assigned to multiple users
- Approved timesheets missing from financial reports
- Data conflicts affecting reconciliation

This project reproduces the problem and implements a structured PostgreSQL-based solution.

---

## What This Project Demonstrates

- PostgreSQL schema design
- Data integrity enforcement using constraints
- Data anomaly detection
- Cleanup of historical bad data
- Auditing using triggers
- Monitoring and governance
- Automation with Bash scripting

---

## Technology Stack

- PostgreSQL
- Ubuntu Linux
- Bash automation
- SQL constraints and triggers
- PgAdmin / HeidiSQL (client tools)

---

## Project Structure

01-setup/                 → Table creation  
02-initial-data/          → Clean sample data  
03-problem-simulation/    → Introduce data issues  
04-detection/             → Integrity checks  
05-cleanup/               → Data correction scripts  
06-constraints/           → Primary/foreign/unique constraints  
07-testing/               → Validation scripts  
08-monitoring-governance/ → Views and auditing  
scripts/                  → Automation scripts  

---

## How to Run

Clone the repository and execute:

bash install.sh

This will automatically:

1. Create the database  
2. Build schema  
3. Load sample data  
4. Introduce integrity problems  
5. Detect issues  
6. Clean bad data  
7. Apply constraints  
8. Enable auditing  

---

## Features

### Integrity Controls
- Primary keys  
- Foreign keys  
- Unique constraints  
- Referential integrity  

### Auditing
- Trigger-based change tracking  
- OLD/NEW data capture  
- Audit summary views  

### Monitoring
- Conflict detection views  
- Governance reports  

---

## Example Demo Queries

SELECT * FROM asset_conflict_report;
SELECT * FROM missing_timesheets;
SELECT * FROM audit_log ORDER BY changed_at DESC;

---

## Author

Crispus Omollo  
PostgreSQL DBA Portfolio Project

