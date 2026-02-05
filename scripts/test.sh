#!/usr/bin/env bash

echo "Resetting database..."
sudo -u postgres dropdb --if-exists erp_integrity_lab
sudo -u postgres createdb erp_integrity_lab

echo "Creating tables..."
sudo -u postgres psql -d erp_integrity_lab -f ../01-setup/create_tables.sql

echo "Loading initial clean data..."
sudo -u postgres psql -d erp_integrity_lab -f ../02-initial-data/insert_data.sql

echo "Inserting problematic ERP data..."
sudo -u postgres psql -d erp_integrity_lab -f ../03-problem-simulation/bad_data.sql

echo "Detecting integrity problems..."
sudo -u postgres psql -d erp_integrity_lab -f ../04-detection/find_issues.sql

echo "Cleaning up bad data before enforcing constraints..."
sudo -u postgres psql -d erp_integrity_lab -f ../05-cleanup/cleanup_bad_data.sql

echo "Applying constraints to enforce integrity..."
sudo -u postgres psql -d erp_integrity_lab -f ../06-constraints/add_constraints.sql

echo "Adding monitoring and governance components..."
sudo -u postgres psql -d erp_integrity_lab -f ../08-monitoring-governance/views.sql

echo "Creating audit logging components..."
sudo -u postgres psql -d erp_integrity_lab -f ../08-monitoring-governance/audit.sql

echo "Demo complete – integrity enforced successfully."

