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

## Key Objects

- employees
- assets
- asset_assignment
- timesheets

## Monitoring Views

- asset_conflict_report
- missing_timesheets
- audit_summary

## Auditing Design

- Generic PL/pgSQL trigger function
- JSON-based change capture
- Table-agnostic implementation
- Historical change tracking

## Security Model

- Database-level constraints
- Role-based access
- Immutable audit logs

## Deployment Architecture

Ubuntu Linux  
↓  
PostgreSQL Server  
↓  
SQL Scripts + Bash Automation  
↓  
Client Tools (PgAdmin / HeidiSQL)

