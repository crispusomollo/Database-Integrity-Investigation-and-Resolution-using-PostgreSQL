# Architecture Overview

## High Level Design

This project follows a layered PostgreSQL integrity management architecture.

### Components

1. Data Layer
   - Core ERP tables
   - Primary keys and foreign keys
   - Normalized schema

2. Integrity Layer
   - Unique constraints
   - Referential integrity
   - Validation rules

3. Detection Layer
   - SQL views to identify conflicts
   - Reporting queries

4. Governance Layer
   - Trigger-based auditing
   - Monitoring reports

5. Automation Layer
   - Bash installer
   - Demo scripts

## Data Flow

Clean Data → Introduce Issues → Detect Problems → Cleanup → Enforce Constraints → Continuous Monitoring

## Technology Components

| Layer | Tools Used |
|------|------------|
| Database Engine | PostgreSQL |
| Operating System | Ubuntu Linux |
| Automation | Bash scripting |
| Client Tools | PgAdmin, HeidiSQL |
| Auditing | PL/pgSQL Triggers |
| Monitoring | SQL Views |

## Key Database Objects

### Core Tables

- `employees`
- `assets`
- `asset_assignment`
- `timesheets`

### Monitoring Views

- asset_conflict_report
- missing_timesheets
- audit_summary

## Auditing Design

- Generic PL/pgSQL trigger function
- JSON-based change capture
- Table-agnostic implementation
- Historical change tracking

## Deployment Architecture

Ubuntu Linux  
↓  
PostgreSQL Server  
↓  
SQL Scripts + Bash Automation  
↓  
Client Tools (PgAdmin / HeidiSQL)

---

## Security and Governance

- Database-level constraints
- Immutable audit logs
- Role-based access
- Constraint-driven data quality

---

## Extensibility

This architecture can be extended with:

- Partitioned audit tables
- Advanced alerting
- API integration
- BI reporting tools

---

## Summary

The architecture demonstrates practical DBA skills including:

- Schema design
- Integrity enforcement
- Troubleshooting
- Automation
- Monitoring
- Auditing

All implemented using PostgreSQL native features.
