#!/bin/bash

# ---- CONFIGURATION ----
DB="erp_integrity_lab"
REPORT="/home/$USER/erp_integrity_report_$(date +%F).txt"
LOG="/home/$USER/erp_integrity_cron.log"

# ---- LOGGING SETUP ----
# Everything printed by this script will also go to the log file
exec >> $LOG 2>&1

echo "============================================="
echo "PostgreSQL ERP Integrity Check - $(date)"
echo "============================================="

echo "PostgreSQL ERP Integrity Check - $(date)" > $REPORT
echo "---------------------------------------" >> $REPORT

# ---- RUN CHECKS ----

echo "" >> $REPORT
echo "Checking asset assignment conflicts..." >> $REPORT

sudo -u postgres psql -d $DB -c "SELECT * FROM asset_conflict_report;" >> $REPORT

echo "" >> $REPORT
echo "Checking missing timesheets..." >> $REPORT

sudo -u postgres psql -d $DB -c "SELECT * FROM missing_timesheets;" >> $REPORT

echo "" >> $REPORT
echo "Audit summary..." >> $REPORT

sudo -u postgres psql -d $DB -c "SELECT * FROM audit_summary;" >> $REPORT

echo "" >> $REPORT
echo "Integrity check completed." >> $REPORT


# ---- ALERT LOGIC ----
# Count conflicts
CONFLICTS=$(psql -d $DB -t -c "SELECT COUNT(*) FROM asset_conflict_report;")

# If any conflicts exist, send an email alert
if [ "$CONFLICTS" -gt 0 ]; then
  mail -s "ALERT: ERP Integrity Issues Detected" crispusomollo@gmail.com < $REPORT
fi

echo "Integrity check finished at $(date)"

#sudo -u postgres psql -d erp_integrity_lab -c "SELECT * FROM asset_conflict_report;" > report.txt
#sudo -u postgres psql -d erp_integrity_lab -c "SELECT * FROM missing_timesheets;" >> report.txt

