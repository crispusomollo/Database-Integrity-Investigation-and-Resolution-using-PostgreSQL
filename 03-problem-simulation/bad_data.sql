-- Asset assigned to two users at same time
INSERT INTO asset_assignment VALUES
(102,10,3,'2025-01-10','2025-01-20');

-- Approved timesheet missing from finance
INSERT INTO timesheets VALUES
(202,3,140,TRUE,'January');

-- Duplicate serial number
INSERT INTO assets VALUES
(12,'Laptop','SN001');
