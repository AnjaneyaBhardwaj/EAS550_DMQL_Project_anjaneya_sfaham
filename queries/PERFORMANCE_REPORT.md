# Performance Tuning Report: Indexing Strategy

## Query Analyzed
Demographics analysis query - finds age distribution by medical condition with patient counts and rankings.

---

## Performance Comparison

| Metric | Before Indexing | After Indexing |
|--------|-----------------|----------------|
| **Execution Time** | 53.422 ms | 48.729 ms |
| **Planning Time** | 0.874 ms | 0.324 ms |

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

## When Indexes Help More

Indexes provide bigger gains when queries:
- Filter specific rows
- Join on indexed columns with selective conditions
- Sort on indexed columns

---

## Conclusion

The indexes improved planning time significantly (63%) and execution time (8.8%).
