# Healthcare Data Warehouse - Star Schema Design
---

## 1. Fact Table Definition

### FACT_ADMISSIONS

**Grain Definition:**  
> One row represents **a single hospital admission event** for a specific patient, treated by a specific doctor, at a specific hospital, on a specific date.

| Column | Type | Description |
|--------|------|-------------|
| `Admission_Key` | INT (PK) | Surrogate primary key |
| `Patient_Key` | INT (FK) | Links to DIM_PATIENT |
| `Doctor_Key` | INT (FK) | Links to DIM_DOCTOR |
| `Hospital_Key` | INT (FK) | Links to DIM_HOSPITAL |
| `Insurance_Key` | INT (FK) | Links to DIM_INSURANCE |
| `Condition_Key` | INT (FK) | Links to DIM_CONDITION |
| `Medication_Key` | INT (FK) | Links to DIM_MEDICATION |
| `Admission_Type` | VARCHAR | Emergency, Elective, Urgent |
| `Billing_Amount` | DECIMAL | Revenue measure |
| `Length_of_Stay` | INT | Days between admission and discharge (derived) |
| `Room_Number` | INT | Assigned room |
| `Test_Results` | VARCHAR | Normal, Abnormal, Inconclusive |
| `Date_of_Admission` | DATE | Admission date |
| `Discharge_Date` | DATE | Discharge date |

### Measures (Aggregatable Facts)

| Measure | Aggregation | Business Use |
|---------|-------------|--------------|
| `Billing_Amount` | SUM, AVG | Revenue analysis |
| `Length_of_Stay` | AVG, MAX | Operational efficiency |
| `Admission_Key` | COUNT | Volume analysis |

---

## 2. Dimension Tables

### DIM_PATIENT

**Purpose:** Enables analysis of admissions by patient demographics.

| Column | Description |
|--------|-------------|
| `Patient_Key` | Surrogate key |
| `Patient_ID` | Natural key from source |
| `Patient_Name` | Full name |
| `Age` | Patient age |
| `Age_Group` | Derived: Pediatric (0-18), Young Adult (19-40), Middle Age (41-60), Senior (61+) |
| `Gender` | Male, Female |
| `Blood_Type` | A+, A-, B+, B-, O+, O-, AB+, AB- |

---

### DIM_DOCTOR

**Purpose:** Enables analysis of doctor workload and patient outcomes.

| Column | Description |
|--------|-------------|
| `Doctor_Key` | Surrogate key |
| `Doctor_ID` | Natural key |
| `Doctor_Name` | Full name |

---

### DIM_HOSPITAL

**Purpose:** Enables analysis of hospital operations and load.

| Column | Description |
|--------|-------------|
| `Hospital_Key` | Surrogate key |
| `Hospital_ID` | Natural key |
| `Hospital_Name` | Hospital name |

---

### DIM_INSURANCE

**Purpose:** Enables analysis of payer mix and billing by insurance.

| Column | Description |
|--------|-------------|
| `Insurance_Key` | Surrogate key |
| `Insurance_ID` | Natural key |
| `Provider_Name` | Insurance company name |

---

### DIM_CONDITION

**Purpose:** Enables clinical analysis of medical conditions.

| Column | Description |
|--------|-------------|
| `Condition_Key` | Surrogate key |
| `Condition_ID` | Natural key |
| `Condition_Name` | Medical condition |
| `Is_Chronic` | Derived: TRUE for Diabetes, Hypertension, Arthritis, Asthma |

---

### DIM_MEDICATION

**Purpose:** Enables analysis of medication usage.

| Column | Description |
|--------|-------------|
| `Medication_Key` | Surrogate key |
| `Medication_ID` | Natural key |
| `Medication_Name` | Drug name |

---

### DIM_DATE

**Purpose:** Enables time-based analysis with calendar attributes.

| Column | Description |
|--------|-------------|
| `Date_Key` | Surrogate key (YYYYMMDD format) |
| `Full_Date` | Actual date |
| `Day_Name` | Monday, Tuesday, etc. |
| `Month` | 1-12 |
| `Month_Name` | January, February, etc. |
| `Year` | YYYY |
| `Season` | Derived: Spring (Mar-May), Summer (Jun-Aug), Fall (Sep-Nov), Winter (Dec-Feb) |

---
