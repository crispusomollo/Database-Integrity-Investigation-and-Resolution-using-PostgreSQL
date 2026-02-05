-- Detect asset conflicts
SELECT * FROM asset_assignment a1
JOIN asset_assignment a2
ON a1.asset_id=a2.asset_id
AND a1.assignment_id <> a2.assignment_id
AND a1.start_date <= a2.end_date
AND a2.start_date <= a1.end_date;

-- Approved timesheets missing in finance
SELECT * FROM timesheets
WHERE approved=TRUE
AND timesheet_id NOT IN (SELECT timesheet_id FROM financial_reports);

-- Duplicate serials
SELECT serial_number, COUNT(*) FROM assets
GROUP BY serial_number HAVING COUNT(*)>1;
