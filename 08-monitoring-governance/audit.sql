-- Central audit table (generic and table-agnostic)
CREATE TABLE IF NOT EXISTS audit_log (
    audit_id SERIAL PRIMARY KEY,
    table_name TEXT,
    action TEXT,
    old_data JSONB,
    new_data JSONB,
    changed_at TIMESTAMP DEFAULT now(),
    changed_by TEXT DEFAULT current_user
);

-- Generic audit function that works for ANY table
CREATE OR REPLACE FUNCTION log_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_log(
        table_name,
        action,
        old_data,
        new_data,
        changed_by
    )
    VALUES (
        TG_TABLE_NAME,
        TG_OP,
        CASE WHEN TG_OP IN ('UPDATE','DELETE') THEN row_to_json(OLD)::jsonb END,
        CASE WHEN TG_OP IN ('UPDATE','INSERT') THEN row_to_json(NEW)::jsonb END,
        current_user
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Drop existing triggers if they exist (to avoid duplicates)
DROP TRIGGER IF EXISTS trg_employee_audit ON employees;
DROP TRIGGER IF EXISTS trg_assets_audit ON assets;
DROP TRIGGER IF EXISTS trg_timesheets_audit ON timesheets;


-- Attach generic audit triggers

CREATE TRIGGER trg_employee_audit
AFTER INSERT OR UPDATE OR DELETE
ON employees
FOR EACH ROW EXECUTE FUNCTION log_changes();

CREATE TRIGGER trg_assets_audit
AFTER INSERT OR UPDATE OR DELETE
ON assets
FOR EACH ROW EXECUTE FUNCTION log_changes();

CREATE TRIGGER trg_timesheets_audit
AFTER INSERT OR UPDATE OR DELETE
ON timesheets
FOR EACH ROW EXECUTE FUNCTION log_changes();


-- View recent changes
CREATE OR REPLACE VIEW recent_audit_activity AS
SELECT *
FROM audit_log
ORDER BY changed_at DESC
LIMIT 20;


-- Summary of changes by table
CREATE OR REPLACE VIEW audit_summary AS
SELECT table_name, action, COUNT(*) as changes
FROM audit_log
GROUP BY table_name, action;

