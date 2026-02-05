#!/bin/bash
set -e

DB="erp_integrity_lab"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
LOGFILE="/home/$USER/erp_integrity_install_$(date +%F_%H%M%S).log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

TOTAL_STEPS=9
CURRENT_STEP=0

progress() {
  CURRENT_STEP=$((CURRENT_STEP+1))
  PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
  echo -e "${CYAN}[Step $CURRENT_STEP/$TOTAL_STEPS] ${PERCENT}% complete${NC}"
}

log() {
  echo -e "$1"
  echo -e "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

success() {
  echo -e "${GREEN}$1${NC}"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

warn() {
  echo -e "${YELLOW}$1${NC}"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $1" >> "$LOGFILE"
}

echo "============================================" | tee -a "$LOGFILE"
echo " PostgreSQL ERP Integrity Project Installer " | tee -a "$LOGFILE"
echo " Log file: $LOGFILE" | tee -a "$LOGFILE"
echo "============================================" | tee -a "$LOGFILE"

# ---- PostgreSQL Service Status ----
progress
log "Checking PostgreSQL service status..."

sudo systemctl status postgresql --no-pager | tee -a "$LOGFILE"
sudo systemctl start postgresql || warn "PostgreSQL already running"

# ---- PRE-CHECKS ----
progress
log "Checking PostgreSQL access..."

if ! sudo -u postgres psql -c "SELECT 1;" >/dev/null 2>&1; then
  echo -e "${RED}PostgreSQL not accessible!${NC}"
  exit 1
fi

success "PostgreSQL access OK"

# ---- PERMISSIONS ----
progress
log "Ensuring file permissions..."
chmod -R o+rx "$BASE_DIR"
success "Permissions adjusted"

# ---- DATABASE RESET ----
progress
log "Resetting database..."

sudo -u postgres psql -c "DROP DATABASE IF EXISTS $DB;" | tee -a "$LOGFILE"
sudo -u postgres psql -c "CREATE DATABASE $DB;" | tee -a "$LOGFILE"

echo -e "\n${CYAN}Database Created:${NC}"
sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -w "$DB" | tee -a "$LOGFILE"

# ---- SCHEMA SETUP ----
progress
log "Creating schema..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/01-setup/create_tables.sql" | tee -a "$LOGFILE"

echo -e "\n${CYAN}Tables Created:${NC}"
sudo -u postgres psql -d $DB -c "\dt" | tee -a "$LOGFILE"

# ---- LOAD INITIAL DATA ----
progress
log "Loading initial clean data..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/02-initial-data/insert_data.sql" >> "$LOGFILE" 2>&1

echo -e "\n${CYAN}Initial Data:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM employees;" | tee -a "$LOGFILE"
sudo -u postgres psql -d $DB -c "SELECT * FROM assets;" | tee -a "$LOGFILE"

# ---- SIMULATE PROBLEMS ----
progress
log "Inserting problematic ERP data..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/03-problem-simulation/bad_data.sql" >> "$LOGFILE" 2>&1

echo -e "\n${YELLOW}Data After Introducing Problems:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM asset_assignment;" | tee -a "$LOGFILE"
sudo -u postgres psql -d $DB -c "SELECT * FROM timesheets;" | tee -a "$LOGFILE"

# ---- DETECTION ----
progress
log "Running detection scripts..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/04-detection/find_issues.sql" >> "$LOGFILE" 2>&1

# Create views BEFORE querying them
log "Creating monitoring views..."
sudo -u postgres psql -d $DB -f "$BASE_DIR/08-monitoring-governance/views.sql" >> "$LOGFILE" 2>&1

echo -e "\n${RED}Detected Issues:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM asset_conflict_report;" | tee -a "$LOGFILE"
sudo -u postgres psql -d $DB -c "SELECT * FROM missing_timesheets;" | tee -a "$LOGFILE"

# ---- CLEANUP ----
progress
log "Cleaning up bad data..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/05-cleanup/cleanup_bad_data.sql" >> "$LOGFILE" 2>&1

echo -e "\n${YELLOW}After Cleanup:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM asset_conflict_report;" | tee -a "$LOGFILE"
sudo -u postgres psql -d $DB -c "SELECT * FROM missing_timesheets;" | tee -a "$LOGFILE"

# ---- CONSTRAINTS + AUDIT ----
progress
log "Applying constraints..."

sudo -u postgres psql -d $DB -f "$BASE_DIR/06-constraints/add_constraints.sql" >> "$LOGFILE" 2>&1

log "Creating audit logging..."
sudo -u postgres psql -d $DB -f "$BASE_DIR/08-monitoring-governance/audit.sql" >> "$LOGFILE" 2>&1

echo -e "\n${GREEN}Final Database Integrity State:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM asset_conflict_report;" | tee -a "$LOGFILE"
sudo -u postgres psql -d $DB -c "SELECT * FROM missing_timesheets;" | tee -a "$LOGFILE"

# ---- SHOW ONLY CURRENT DB CONSTRAINTS ----
echo -e "\n${CYAN}Constraints in This Database:${NC}"

sudo -u postgres psql -d $DB -c "
SELECT 
  conname AS constraint_name,
  contype AS type,
  conrelid::regclass AS table_name
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace;
" | tee -a "$LOGFILE"

# ---- SHOW ONLY CURRENT DB INDEXES ----
echo -e "\n${CYAN}Indexes in This Database:${NC}"

sudo -u postgres psql -d $DB -c "
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname='public';
" | tee -a "$LOGFILE"

# ---- AUDIT OUTPUT ----
echo -e "\n${CYAN}Audit Summary:${NC}"
sudo -u postgres psql -d $DB -c "SELECT * FROM audit_summary;" | tee -a "$LOGFILE"

success "INSTALL COMPLETE – DEMO READY"
echo "Logs available at: $LOGFILE"

