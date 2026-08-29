# QntProj - Manufacturing Data dbt Project

A scalable dbt project designed to create a comprehensive data model for manufacturing business operations. This project implements a three-layer architecture (Staging, ODS, and Mart) to transform raw manufacturing data into analytics-ready datasets.

## Project Overview

**Project Name:** qntproj  
**Version:** 1.0.0  
**Data Warehouse:** Google BigQuery  
**dbt Version:** 1.12.3  
**Purpose:** Manufacturing business data modeling and scalable analytics architecture

## Project Architecture

The project follows a medallion architecture with three distinct layers:

### 1. **Staging Layer** (`models/staging/`)
Views that perform initial data transformation and cleansing from raw source tables.

**Models:**
- `stg_customers` - Customer master data with data quality tests (not_null, unique on customer_id)
- `stg_employees` - Employee records
- `stg_products` - Product catalog
- `stg_orders` - Order headers and metadata
- `stg_order_item` - Order line items
- `stg_production` - Manufacturing production records
- `stg_inventory` - Inventory levels and movements
- `stg_material` - Material/component data
- `stg_maintenance` - Equipment maintenance records
- `stg_quality_checks` - Quality assurance and inspection data

**Materialization:** Views (optimized for source data alignment)

### 2. **ODS Layer** (`models/ods/`)
Operational Data Store containing fact and dimension tables for reporting.

**Models:**
- `fact_production` - Production fact table (in development)

**Materialization:** Views

### 3. **Mart Layer** (`models/mart/`)
Business-focused analytical tables and aggregations (currently planned for future development).

**Materialization:** Tables

## Data Sources

All data is sourced from the `qnt_staging` schema in BigQuery, configured via `source.yml`:

| Source Table | Description |
|---|---|
| customers | Customer master data |
| employees | Employee records |
| inventory | Inventory master |
| orders | Order transactions |
| order_items | Order line items |
| production | Production runs and output |
| products | Product master |
| quality_checks | Quality inspection records |
| material_usage | Material consumption data |
| maintenance | Equipment maintenance logs |

## Setup & Configuration

### Prerequisites

1. **Python 3.8+**
2. **Google Cloud Project** with BigQuery enabled
3. **Service Account** with BigQuery access
4. **Environment Variables** configured

### Installation

1. Create and activate Python virtual environment:
```bash
python -m venv mdbt
source mdbt/Scripts/activate  # On Windows
# or
source mdbt/bin/activate      # On macOS/Linux
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

### Environment Variables

Configure these required environment variables before running dbt:

| Variable | Description | Example |
|---|---|---|
| `PROJECT_ID` | Google Cloud Project ID | `my-gcp-project` |
| `SA_KEY` | Path to service account JSON key file | `/path/to/service-account-key.json` |
| `REGION` | BigQuery dataset region | `US` or `EU` |

Example setup:
```bash
export PROJECT_ID="your-gcp-project"
export SA_KEY="path/to/service-account-key.json"
export REGION="US"
```

### Profile Configuration

The project uses the `qntproj` profile configured in `profiles.yml`:

- **Target:** `bigquery_dev`
- **Type:** BigQuery
- **Authentication:** Service Account
- **Dataset:** `qnt_staging`
- **Threads:** 2 (for parallel execution)
- **Timeout:** 300 seconds
- **Priority:** Interactive
- **Retries:** 1

## Running dbt Commands

### Basic Operations

```bash
# Parse project and build dependencies
dbt parse

# Run all models (default in dev)
dbt run

# Run specific model
dbt run --select stg_customers

# Run by tag
dbt run --select tag:daily

# Run models and tests
dbt test

# Generate documentation
dbt docs generate

# View docs locally
dbt docs serve
```

### Testing

```bash
# Run all tests
dbt test

# Run tests for specific model
dbt test --select stg_customers

# Run tests by tag
dbt test --select tag:quality_checks
```

### Debugging

```bash
# Run with debug output
dbt run --debug

# Compile without execution
dbt compile

# Run in dry-run mode
dbt run --select stg_customers --dry-run
```

## Project Structure

```
qntproj/
├── dbt_project.yml          # Project configuration
├── profiles.yml             # Database connection profiles
├── source.yml               # Data source definitions
├── requirements.txt         # Python dependencies
├── README.md                # This file
├── models/
│   ├── staging/             # Staging layer (views)
│   │   ├── schema.yml       # Model documentation and tests
│   │   ├── stg_customers.sql
│   │   ├── stg_employees.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_item.sql
│   │   ├── stg_production.sql
│   │   ├── stg_inventory.sql
│   │   ├── stg_material.sql
│   │   ├── stg_maintenance.sql
│   │   └── stg_quality_checks.sql
│   ├── ods/                 # ODS layer (views)
│   │   └── fact_production.sql
│   └── mart/                # Mart layer (tables) - planned
├── analyses/                # Ad-hoc analyses
├── tests/                   # Custom tests
├── macros/                  # Reusable SQL macros
├── seeds/                   # Static data files (CSV)
├── snapshots/               # Slowly changing dimension snapshots
└── logs/                    # Execution logs
```

## Data Quality & Testing

The project includes dbt tests defined in `models/staging/schema.yml`:

- **Not Null Tests:** Ensure critical fields are populated
- **Unique Tests:** Validate primary keys (e.g., `customer_id` in stg_customers)
- **Referential Integrity:** Tests between related models

Run tests with:
```bash
dbt test
```

## Next Steps & Planned Features

1. **Complete ODS Layer:** Develop remaining fact and dimension tables
2. **Mart Layer Development:** Create business-focused analytical tables
3. **Aggregation Tables:** Build pre-aggregated tables for performance
4. **Enhanced Tests:** Add more comprehensive data quality checks
5. **Documentation:** Add column-level descriptions to all models
6. **Macros:** Develop reusable macros for common transformations
7. **CI/CD Integration:** Set up automated testing and deployment

## Dependencies

```
dbt-core          # Core dbt framework
dbt-bigquery      # BigQuery adapter
sqlfluff          # SQL linting and formatting
```

See `requirements.txt` for versions.

## Database Configuration

- **Database:** BigQuery (Google Cloud)
- **Staging Dataset:** `qnt_staging`
- **Region:** Configurable via `REGION` environment variable
- **Authentication:** Service Account JSON key
- **Processing Model:** Interactive priority with 1 retry

## Resources & Documentation

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Community Discourse](https://discourse.getdbt.com/)
- [dbt Slack Community](https://community.getdbt.com/)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)
- [dbt BigQuery Adapter](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup)

## Support & Troubleshooting

For common issues:

1. **Authentication Errors:** Verify `SA_KEY` path and service account permissions
2. **Dataset Not Found:** Ensure `PROJECT_ID` and `REGION` are correctly set
3. **Test Failures:** Review test configurations in `schema.yml`
4. **Query Timeouts:** Check resource availability in BigQuery project

## Contributing

When adding new models:
1. Place in appropriate layer (staging/ods/mart)
2. Add descriptions and column documentation in schema.yml
3. Include data quality tests
4. Update this README if adding new layers or significant functionality
5. Follow SQL formatting standards (validated by sqlfluff)

## Last Updated

Generated: August 29, 2026
