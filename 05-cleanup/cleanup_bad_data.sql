-- CLEANUP LOGIC

-- 1. Remove the intentionally inserted duplicate asset (id 12)
DELETE FROM assets
WHERE asset_id = 12;

-- 2. Remove assignments referencing non-existent assets
DELETE FROM asset_assignment
WHERE asset_id NOT IN (SELECT asset_id FROM assets);

-- 3. Remove overlapping assignments inserted during simulation
DELETE FROM asset_assignment
WHERE assignment_id = 102;

-- 4. Correct invalid approved timesheet
UPDATE timesheets
SET approved = FALSE
WHERE timesheet_id = 202;

-- 5. Remove timesheets that should not be approved
DELETE FROM timesheets
WHERE timesheet_id = 202;

-- Ensure all approved timesheets appear in financial reports
INSERT INTO financial_reports (report_id, timesheet_id, month)
SELECT
  300 + t.timesheet_id,
  t.timesheet_id,
  t.month
FROM timesheets t
WHERE t.approved = TRUE
AND t.timesheet_id NOT IN (SELECT timesheet_id FROM financial_reports);

