# Healthcare Data Warehouse - dbt Project

This dbt project transforms OLTP data into a star schema for analytics.

## Project Structure

```
dbt_healthcare/
├── dbt_project.yml       # Project config
├── profiles.yml          # Database connection
├── models/
│   ├── staging/          # Clean source data (views)
│   │   └── stg_*.sql
│   └── warehouse/        # Star schema (tables)
│       ├── dim_*.sql     # Dimension tables
│       └── fact_*.sql    # Fact table
```

## How to Run

```bash
# 1. Go to dbt folder
cd dbt_healthcare

# 2. Test connection
dbt debug

# 3. Build all models
dbt run

# 4. Run tests
dbt test
```

## Models

### Staging (Views)
- `stg_patients` - Patient data with age_group
- `stg_doctors` - Doctor data
- `stg_hospitals` - Hospital data
- `stg_insurance_providers` - Insurance data
- `stg_medical_conditions` - Conditions with is_chronic flag
- `stg_medications` - Medication data
- `stg_admissions` - Admissions with length_of_stay

### Warehouse (Tables)
- `dim_patient` - Patient dimension
- `dim_doctor` - Doctor dimension
- `dim_hospital` - Hospital dimension
- `dim_insurance` - Insurance dimension
- `dim_condition` - Condition dimension
- `dim_medication` - Medication dimension
- `dim_date` - Date dimension with season
- `fact_admissions` - Admission facts with all foreign keys

## Sample Query

```sql
SELECT 
    p.age_group,
    c.condition_name,
    COUNT(*) AS admissions,
    AVG(f.billing_amount) AS avg_billing
FROM public_warehouse.fact_admissions f
JOIN public_warehouse.dim_patient p ON f.patient_key = p.patient_key
JOIN public_warehouse.dim_condition c ON f.condition_key = c.condition_key
GROUP BY p.age_group, c.condition_name;
```
