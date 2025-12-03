# Performance Tuning Report: Indexing Strategy

## Overview

This report shows how adding indexes to our healthcare database improved query performance. We tested the demographics analysis query which joins three tables and uses window functions.

---

## Performance Comparison

| Metric | Before Indexing | After Indexing |
|--------|-----------------|----------------|
| **Execution Time** | 616.191 ms | 53.265 ms |
| **Planning Time** | 378.115 ms | 0.341 ms |
| **Total Time** | 994.306 ms | 53.606 ms |

### What Changed in the Query Plan

**Before Indexing:**
- Sequential scan on `admissions` table: 314.220 ms
- Sequential scan on `patients` table: 241.405 ms
- Hash building for patients: 252.550 ms

**After Indexing:**
- Sequential scan on `admissions` table: 3.148 ms
- Sequential scan on `patients` table: 5.665 ms
- Hash building for patients: 12.716 ms

The big improvement came from the database having better statistics after running `ANALYZE`. The indexes also help PostgreSQL plan the query faster.

---

## Indexes Created

```sql
CREATE INDEX idx_admissions_patient_id ON Admissions(Patient_ID);
CREATE INDEX idx_admissions_condition_id ON Admissions(Condition_ID);
CREATE INDEX idx_patients_age ON Patients(Age);
CREATE INDEX idx_admissions_patient_condition ON Admissions(Patient_ID, Condition_ID);
CREATE INDEX idx_conditions_name ON MedicalConditions(Condition_Name);
```

---
1. **Foreign Key Indexes** (`idx_admissions_patient_id`, `idx_admissions_condition_id`)
   - Speed up JOIN operations between tables
   - PostgreSQL can quickly find matching rows instead of scanning whole tables

2. **Age Index** (`idx_patients_age`)
   - Helps with the age group CASE statement
   - Useful for any queries that filter by age range

3. **Composite Index** (`idx_admissions_patient_condition`)
   - Good for queries that need both Patient_ID and Condition_ID
   - Can satisfy multiple conditions with one index lookup

4. **Condition Name Index** (`idx_conditions_name`)
   - Helps with sorting results by condition name
   - Speeds up the final ORDER BY in the query

---

## Observations

- The planning time dropped dramatically (from 378ms to 0.3ms) because PostgreSQL caches the query plan after the first run
- The execution time improved by over 90% mainly due to better statistics from `ANALYZE`
- Hash joins are still used but they run much faster now
- Memory usage stayed the same (27kB for sorts, 2660kB for hash table)

---

## Conclusion

Adding indexes and running `ANALYZE` on the tables gave us vast improvement in query performance. The query went from taking almost 1 second to about 53 milliseconds.
