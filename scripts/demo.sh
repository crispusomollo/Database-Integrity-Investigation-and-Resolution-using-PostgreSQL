#!/bin/bash

DB="erp_integrity_lab"

echo "Resetting database..."
sudo -u postgres psql -c "DROP DATABASE IF EXISTS $DB;"
sudo -u postgres psql -c "CREATE DATABASE $DB;"

echo "Creating tables..."
sudo -u postgres psql -d $DB -f ../01-setup/create_tables.sql

echo "Loading initial clean data..."
sudo -u postgres psql -d $DB -f ../02-initial-data/insert_data.sql

echo "Inserting problematic ERP data..."
sudo -u postgres psql -d $DB -f ../03-problem-simulation/bad_data.sql

echo "Detecting integrity problems..."
sudo -u postgres psql -d $DB -f ../04-detection/find_issues.sql

echo "Cleaning up bad data before enforcing constraints..."
sudo -u postgres psql -d $DB -f ../05-cleanup/cleanup_bad_data.sql

echo "Applying constraints to enforce integrity..."
sudo -u postgres psql -d $DB -f ../06-constraints/add_constraints.sql

echo "Creating monitoring views and audit logging..."
sudo -u postgres psql -d $DB -f ../08-monitoring-governance/views.sql
sudo -u postgres psql -d $DB -f ../08-monitoring-governance/audit.sql

echo "--------------------------------------------"
echo "FINAL VALIDATION CHECKS"
echo "--------------------------------------------"

echo "Checking for asset conflicts..."
sudo -u postgres psql -d $DB -c "SELECT * FROM asset_conflict_report;"

echo "Checking for missing timesheets..."
sudo -u postgres psql -d $DB -c "SELECT * FROM missing_timesheets;"

echo "Checking audit log status..."
sudo -u postgres psql -d $DB -c "SELECT * FROM audit_summary;"

echo "--------------------------------------------"
echo "DEMO COMPLETE – Database integrity enforced!"
echo "--------------------------------------------"

