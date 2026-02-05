# Security Considerations

## Database Security Controls

This project demonstrates several security best practices:

### 1. Data Integrity as Security

- Primary keys prevent duplicates
- Unique constraints enforce business rules
- Foreign keys prevent orphan records
- Check constraints validate input

### 2. Auditing

- All changes logged via triggers
- OLD and NEW values captured
- User performing change recorded
- Time of change preserved

### 3. Least Privilege

Recommended roles:

CREATE ROLE app_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO app_user;

Audit tables should be restricted to administrators only.

### 4. Error Handling

Constraint violations are handled at the database level to prevent bad data entry.

### 5. Logging

PostgreSQL server logs capture:

- Failed statements
- Constraint violations
- Unauthorized access attempts

### 6. Production Hardening Suggestions

For real deployments:

- Enable SSL connections
- Use dedicated application roles
- Restrict direct table access
- Implement audit retention policies
- Encrypt backups
- Regular permission reviews

