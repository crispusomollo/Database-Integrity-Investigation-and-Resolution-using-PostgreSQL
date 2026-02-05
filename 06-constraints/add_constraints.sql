ALTER TABLE employees ADD PRIMARY KEY(employee_id);
ALTER TABLE assets ADD PRIMARY KEY(asset_id);
ALTER TABLE asset_assignment ADD PRIMARY KEY(assignment_id);
ALTER TABLE timesheets ADD PRIMARY KEY(timesheet_id);

ALTER TABLE assets ADD CONSTRAINT unique_serial UNIQUE(serial_number);

ALTER TABLE asset_assignment
ADD CONSTRAINT fk_asset FOREIGN KEY(asset_id) REFERENCES assets(asset_id);

ALTER TABLE asset_assignment
ADD CONSTRAINT fk_employee FOREIGN KEY(employee_id) REFERENCES employees(employee_id);

ALTER TABLE timesheets
ADD CONSTRAINT fk_ts_emp FOREIGN KEY(employee_id) REFERENCES employees(employee_id);

-- Enable extension required for range constraints
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- Prevent overlapping assignments for the same asset
ALTER TABLE asset_assignment
ADD CONSTRAINT ex_no_overlap
EXCLUDE USING gist (
    asset_id WITH =,
    daterange(start_date, end_date, '[]') WITH &&
);
