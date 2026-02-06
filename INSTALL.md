# Installation Guide

This guide explains how to deploy and run the PostgreSQL ERP Integrity Project.

## Prerequisites

- Ubuntu Linux (20.04+ recommended)
- PostgreSQL 14 or higher
- Bash shell access
- Git

## Setup Steps

1. Clone the repository:
```
git clone https://github.com/crispusomollo/Database-Integrity-Investigation-and-Resolution-using-PostgreSQL.git

cd database-integrity-investigation-and-resolution-using-postgresql
```
2. Ensure PostgreSQL is installed and running:
```
sudo systemctl status postgresql
```
3. Make installer executable:
```
chmod +x install.sh
```
4. Run the installer:
```
bash install.sh
```
## What the Installer Does

The installer performs the following automatically:

- Verifies PostgreSQL service
- Creates database erp_integrity_lab
- Builds schema and tables
- Loads sample clean data
- Introduces simulated data issues
- Detects inconsistencies
- Cleans up bad data
- Applies constraints
- Enables auditing and monitoring

## Verifying Installation

After installation, connect to the database:
```
psql -d erp_integrity_lab
```
Run:
```
SELECT * FROM asset_conflict_report;

SELECT * FROM missing_timesheets;

SELECT * FROM audit_summary;
```
All integrity reports should return zero rows after successful setup.

## Troubleshooting

- Ensure you can access PostgreSQL as postgres user
- Check permissions on project folder
- Review the generated log file for details

Log files are created in your home directory after each run.


