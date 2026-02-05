CREATE TABLE employees (
    employee_id INTEGER,
    name TEXT,
    department TEXT
);

CREATE TABLE assets (
    asset_id INTEGER,
    asset_name TEXT,
    serial_number TEXT
);

CREATE TABLE asset_assignment (
    assignment_id INTEGER,
    asset_id INTEGER,
    employee_id INTEGER,
    start_date DATE,
    end_date DATE
);

CREATE TABLE timesheets (
    timesheet_id INTEGER,
    employee_id INTEGER,
    hours_worked INTEGER,
    approved BOOLEAN,
    month TEXT
);

CREATE TABLE financial_reports (
    report_id INTEGER,
    timesheet_id INTEGER,
    month TEXT
);
