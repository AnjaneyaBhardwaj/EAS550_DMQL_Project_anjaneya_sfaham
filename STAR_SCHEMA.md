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
| `Admission_Date_Key` | INT (FK) | Links to DIM_DATE (admission) |
| `Discharge_Date_Key` | INT (FK) | Links to DIM_DATE (discharge) |
| `Admission_Type` | VARCHAR | Emergency, Elective, Urgent |
| `Billing_Amount` | DECIMAL | Revenue measure |
| `Length_of_Stay` | INT | Days between admission and discharge |
| `Room_Number` | INT | Assigned room |
| `Test_Results` | VARCHAR | Normal, Abnormal, Inconclusive |
| `Is_Readmission` | BOOLEAN | Flag if patient readmitted within 30 days |

### Measures (Aggregatable Facts)

| Measure | Aggregation | Business Use |
|---------|-------------|--------------|
| `Billing_Amount` | SUM, AVG | Revenue analysis |
| `Length_of_Stay` | AVG, MAX | Operational efficiency |
| `Is_Readmission` | COUNT, SUM | Quality metrics |
| `Admission_Key` | COUNT | Volume analysis |

---

## 2. Dimension Tables

### DIM_PATIENT

**Purpose:** Enables analysis of admissions by patient demographics and characteristics.

| Column | Description |
|--------|-------------|
| `Patient_Key` | Surrogate key for data warehouse |
| `Patient_ID` | Natural key from source system |
| `Patient_Name` | Full name |
| `Age` | Patient age at admission |
| `Age_Group` | Derived: Pediatric, Young Adult, Middle Age, Senior |
| `Gender` | Male, Female |
| `Blood_Type` | A+, A-, B+, B-, O+, O-, AB+, AB- |
| `Blood_Type_Group` | Derived: A, B, O, AB |


---

### DIM_DOCTOR

**Purpose:** Enables analysis of doctor workload, performance, and patient outcomes.

| Column | Description |
|--------|-------------|
| `Doctor_Key` | Surrogate key |
| `Doctor_ID` | Natural key |
| `Doctor_Name` | Full name |
| `Specialty` | Derived/enriched field |
| `Experience_Level` | Junior, Mid, Senior |


---

### DIM_HOSPITAL

**Purpose:** Enables geographic and capacity-based analysis of hospital operations.

| Column | Description |
|--------|-------------|
| `Hospital_Key` | Surrogate key |
| `Hospital_ID` | Natural key |
| `Hospital_Name` | Hospital name |
| `Hospital_Type` | General, Specialty, Teaching |
| `City` | Location city |
| `State` | Location state |
| `Bed_Capacity` | Small (<100), Medium (100-500), Large (>500) |


---

### DIM_INSURANCE

**Purpose:** Enables analysis of payer mix and insurance impact on billing.

| Column | Description |
|--------|-------------|
| `Insurance_Key` | Surrogate key |
| `Insurance_ID` | Natural key |
| `Provider_Name` | Insurance company name |
| `Provider_Type` | Private, Government, Self-Pay |
| `Coverage_Level` | Basic, Standard, Premium |

---

### DIM_CONDITION

**Purpose:** Enables clinical analysis of medical conditions and disease patterns.

| Column | Description |
|--------|-------------|
| `Condition_Key` | Surrogate key |
| `Condition_ID` | Natural key |
| `Condition_Name` | Medical condition |
| `Condition_Category` | Chronic, Acute, Infectious |
| `Severity_Level` | Low, Medium, High, Critical |
| `Is_Chronic` | Boolean flag for chronic conditions |

---

### DIM_MEDICATION

**Purpose:** Enables pharmaceutical analysis and prescription patterns.

| Column | Description |
|--------|-------------|
| `Medication_Key` | Surrogate key |
| `Medication_ID` | Natural key |
| `Medication_Name` | Drug name |
| `Drug_Class` | Antibiotic, Painkiller, etc. |
| `Administration_Type` | Oral, IV, Injection |
| `Requires_Prescription` | Boolean |


---

### DIM_DATE (Role-Playing Dimension)

**Purpose:** Enables time-based analysis.

| Column | Description |
|--------|-------------|
| `Date_Key` | Surrogate key (YYYYMMDD format) |
| `Full_Date` | Actual date |
| `Day_of_Week` | 1-7 |
| `Day_Name` | Monday, Tuesday, etc. |
| `Week_of_Year` | 1-52 |
| `Month` | 1-12 |
| `Month_Name` | January, February, etc. |
| `Quarter` | Q1, Q2, Q3, Q4 |
| `Year` | YYYY |
| `Is_Weekend` | Boolean |
| `Is_Holiday` | Boolean |
| `Season` | Spring, Summer, Fall, Winter |

---
