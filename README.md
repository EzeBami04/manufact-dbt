# Manufact dbt - Manufacturing Data Platform

A comprehensive dbt-based data modeling solution for manufacturing business intelligence and analytics. This repository contains a scalable data architecture built on Google BigQuery for transforming raw manufacturing operational data into actionable business insights.

## 📊 Project Overview

**Organization:** Manufact  
**Purpose:** Manufacturing Data Transformation & Analytics  
**Data Warehouse:** Google BigQuery  
**Technology Stack:** dbt + BigQuery + Python  
**Architecture Pattern:** Medallion (Staging → ODS → Mart)

## 🏗️ Repository Structure

```
manufact-dbt/
├── README.md                 # This file
├── requirements.txt          # Project Python dependencies
├── mdbt/                     # Python virtual environment
└── qntproj/                  # Main dbt project
    ├── README.md             # Project-specific documentation
    ├── dbt_project.yml       # dbt project configuration
    ├── profiles.yml          # Database connection profiles
    ├── source.yml            # Data source definitions
    ├── models/               # dbt models (staging, ods, mart)
    ├── tests/                # Custom data quality tests
    ├── macros/               # Reusable SQL macros
    ├── seeds/                # Static lookup data
    ├── snapshots/            # SCD (Slowly Changing Dimensions)
    ├── analyses/             # Ad-hoc analyses
    └── logs/                 # Execution logs

```

## 🚀 Quick Start

### 1. Prerequisites

- Python 3.8 or higher
- Google Cloud Project with BigQuery enabled
- Service Account with BigQuery admin/editor permissions
- Git

### 2. Setup

```bash
# Clone or navigate to repository
cd manufact-dbt

# Create virtual environment
python -m venv mdbt
source mdbt/Scripts/activate  # Windows
# OR
source mdbt/bin/activate      # macOS/Linux

# Install dependencies
pip install -r requirements.txt
```

### 3. Configure Environment

```bash
# Set required environment variables
export PROJECT_ID="your-gcp-project-id"
export SA_KEY="path/to/service-account-key.json"
export REGION="US"  # or your desired region
```

### 4. Verify Connection

```bash
cd qntproj
dbt debug
```

### 5. Run Models

```bash
# Navigate to project directory
cd qntproj

# Run all models
dbt run

# Test data quality
dbt test

# Generate and view documentation
dbt docs generate
dbt docs serve
```

## 📋 Main dbt Project - QntProj

See [qntproj/README.md](qntproj/README.md) for detailed project documentation.

### Quick Facts

- **Models:** 11 total (10 staging, 1 ODS)
- **Data Sources:** 10 staging tables from manufacturing operations
- **Layers:** 
  - **Staging (Views):** Data cleaning & standardization
  - **ODS (Views):** Operational data store for reporting
  - **Mart (Tables):** Business-focused analytics (planned)
- **Database:** BigQuery
- **Tests:** dbt built-in tests for data quality

## 🔄 Data Flow

```
Raw Data (qnt_staging schema)
    ↓
Staging Models (stg_* views)
    ├── stg_customers
    ├── stg_employees
    ├── stg_products
    ├── stg_orders
    ├── stg_order_item
    ├── stg_production
    ├── stg_inventory
    ├── stg_material
    ├── stg_maintenance
    └── stg_quality_checks
    ↓
ODS Models (fact_* & dim_* views)
    └── fact_production
    ├── dim_products
    ├── dim_material
    ├── dim_labour
    ↓
Mart Models (Business tables)
    └── [Planned: Analytics-ready aggregations]
```

## 🛠️ Common Commands

```bash
# Navigate to project
cd qntproj

# Parse and validate
dbt parse

# Run specific model
dbt run --select stg_customers

# Run and test
dbt run && dbt test

# Debug issues
dbt debug
dbt run --debug

# Generate docs
dbt docs generate
dbt docs serve

# Compile without running
dbt compile

# Dry run
dbt run --dry-run
```

## 🔐 Configuration

### Environment Variables Required

| Variable | Purpose | Example |
|---|---|---|
| `PROJECT_ID` | GCP Project ID | `my-gcp-project` |
| `SA_KEY` | Service Account JSON key path | `/path/to/key.json` |
| `REGION` | BigQuery region | `US`, `EU`, `us-central1` |

### Database Profile

- **Adapter:** BigQuery
- **Auth Method:** Service Account
- **Dataset:** `qnt_staging`
- **Threads:** 2
- **Timeout:** 300 seconds
- **Priority:** Interactive

## 📊 Data Sources

Manufacturing operational data from 10 source tables:

| Table | Purpose |
|---|---|
| customers | Customer master data |
| employees | Employee records & hierarchy |
| products | Product catalog |
| orders | Order transactions |
| order_items | Order line items & fulfillment |
| production | Manufacturing production runs |
| inventory | Stock levels & movements |
| material_usage | Raw material consumption |
| maintenance | Equipment maintenance logs |
| quality_checks | Quality inspection records |

## ✅ Data Quality

The project includes automated tests for:
- **Not Null:** Critical fields validation
- **Uniqueness:** Primary key constraints
- **Referential Integrity:** Foreign key relationships
- **Data Types:** Column type validation

Run tests:
```bash
dbt test
```

## 📚 Documentation

Comprehensive documentation is auto-generated by dbt:

```bash
cd qntproj
dbt docs generate
dbt docs serve
# Opens interactive documentation at localhost:8000
```

## 🔗 Dependencies

```
dbt-core==1.12.3              # Core dbt framework
dbt-bigquery==1.12.0          # BigQuery adapter
sqlfluff==2.x                 # SQL linting
```

See `requirements.txt` for complete list.

## 🎯 Roadmap

- [ ] Complete ODS fact tables
- [ ] Develop Mart layer analytics tables
- [ ] Add aggregated summary tables
- [ ] Implement incremental models for large fact tables
- [ ] Add more advanced data quality tests
- [ ] Create macros for common patterns
- [ ] Set up CI/CD pipeline with GitHub Actions
- [ ] Add metrics layer for BI tools

## 🤝 Contributing Guidelines

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make changes following project conventions
3. Run tests: `dbt test`
4. Generate docs: `dbt docs generate`
5. Commit with clear messages
6. Push and create pull request

## 📖 Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)
- [dbt + BigQuery Setup](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup)
- [SQL Style Guide](https://docs.getdbt.com/guides/sql-best-practices)

## 🆘 Troubleshooting

**Issue:** `dbt: command not found`
- **Solution:** Activate virtual environment: `source mdbt/Scripts/activate`

**Issue:** `Authentication failed`
- **Solution:** Verify `SA_KEY` path and service account has BigQuery permissions

**Issue:** `Dataset not found`
- **Solution:** Check `PROJECT_ID` and `REGION` environment variables

**Issue:** Tests failing
- **Solution:** Review test definitions in `models/*/schema.yml`

## 📞 Contact & Support

For issues or questions about this dbt project, refer to:
1. Project README: [qntproj/README.md](qntproj/README.md)
2. dbt Community: [Slack](https://community.getdbt.com/) | [Discourse](https://discourse.getdbt.com/)
3. BigQuery Support: [GCP Console](https://console.cloud.google.com/)

## 📝 License

[Specify your license here]

---

**Last Updated:** August 29, 2026  
**Project Version:** 1.0.0  
**Status:** Active Development
