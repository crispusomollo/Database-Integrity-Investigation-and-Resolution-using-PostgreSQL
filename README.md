<img width="1286" height="857" alt="image" src="https://github.com/user-attachments/assets/cb8e808f-3313-451c-bd24-8b2d8c16ae92" />

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

## For Interview Reviewers

To make evaluation easier, please use the following guides:

- 📌 **How to Review This Project:** [REVIEWERS_NOTE.md](REVIEWERS_NOTE.md)  
- 🛠 **Installation Guide:** [INSTALL.md](INSTALL.md)  
- 🏗 **Architecture Overview:** [ARCHITECTURE.md](ARCHITECTURE.md)  
- 🔒 **Security Notes:** [SECURITY.md](SECURITY.md)  
- 🧪 **Example Demo Queries:** [EXAMPLE_QUERIES.md](EXAMPLE_QUERIES.md)

These documents provide a structured path for quickly understanding and testing the project.

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

## Installation

A dedicated step-by-step installation guide is available here:

➡ **[INSTALL.md](INSTALL.md)**

Simply clone the repository and run:

bash install.sh

All setup, data loading, and demo execution are fully automated.

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

## Recommended Review Path

If you are reviewing this project for interview or assessment purposes:

1. Read [ARCHITECTURE.md](ARCHITECTURE.md) to understand the design  
2. Follow [INSTALL.md](INSTALL.md) to deploy the demo  
3. Use [EXAMPLE_QUERIES.md](EXAMPLE_QUERIES.md) to test functionality  
4. Review [SECURITY.md](SECURITY.md) for governance approach  
5. Check [REVIEWERS_NOTE.md](REVIEWERS_NOTE.md) for evaluation guidance  

---

## Author

**Crispus Omollo**  
PostgreSQL DBA Portfolio Project
