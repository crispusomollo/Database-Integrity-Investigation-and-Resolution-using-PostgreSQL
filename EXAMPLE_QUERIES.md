# Example SQL Queries for Reviewers

## 1. View All Assets

SELECT * FROM assets;

## 2. Check Asset Assignment Conflicts

SELECT * FROM asset_conflict_report;

## 3. Find Missing Timesheets

SELECT * FROM missing_timesheets;

## 4. Show Audit History

SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 10;

## 5. Attempt Invalid Insert (Should Fail)

INSERT INTO assets VALUES (99, 'Laptop', 'SN001');

## 6. Test Foreign Key Protection

INSERT INTO asset_assignment VALUES
(500, 999, 1, '2026-01-01', '2026-01-10');

## 7. Show All Constraints

SELECT conname, conrelid::regclass
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace;

## 8. Show All Indexes

SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname='public';

## 9. Validate System Health

SELECT COUNT(*) AS conflicts FROM asset_conflict_report;
SELECT COUNT(*) AS missing FROM missing_timesheets;

## 10. Sample Update to Trigger Audit

UPDATE employees SET employee_name='Test User'
WHERE employee_id=1;

SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 5;
