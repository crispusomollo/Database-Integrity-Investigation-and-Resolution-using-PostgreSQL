-- Make some changes to generate audit logs
INSERT INTO employees VALUES (5, 'Test User');

UPDATE assets SET asset_name='Updated Laptop'
WHERE asset_id = 10;

DELETE FROM timesheets WHERE timesheet_id = 201;

-- Check audit results
SELECT * FROM recent_audit_activity;

SELECT * FROM audit_summary;
INSERT INTO assets VALUES(20,'Phone','SN001');
INSERT INTO asset_assignment VALUES(200,10,1,'2025-01-05','2025-01-10');
