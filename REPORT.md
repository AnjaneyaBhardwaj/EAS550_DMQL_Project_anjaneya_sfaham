# Healthcare Database Schema Design Report

## 1. Proposed Schema (3NF)

We analyzed the `healthcare_dataset.csv` file, and designed a schema that normalizes the data into **Third Normal Form (3NF)**. This design uses **surrogate keys** (IDs) to ensure uniqueness and stability, as the original dataset didn't have natural primary keys. We added primary keys like `Doctor_ID`, `Insurance_ID`, `Admission_ID` etc. 

### **Dimension Tables (Lookup Entities)**

These tables store data that's not transaction-related, which helps us keep things from being repetitive.

**1. Patients**
* `Patient_ID` (PK, INT)
* `Name` (VARCHAR)
* `Age` (INT)
* `Gender` (VARCHAR)
* `Blood_Type` (VARCHAR)

**2. Doctors**
* `Doctor_ID` (PK, INT)
* `Name` (VARCHAR)

**3. Hospitals**
* `Hospital_ID` (PK, INT)
* `Name` (VARCHAR)

**4. InsuranceProviders**
* `Insurance_ID` (PK, INT)
* `Name` (VARCHAR)

**5. MedicalConditions**
* `Condition_ID` (PK, INT)
* `Condition_Name` (VARCHAR)

**6. Medications**
* `Medication_ID` (PK, INT)
* `Medication_Name` (VARCHAR)

### **Fact Table (This is the main Transactional Entity)**

This table records the specific event of a hospital visit.

**7. Admissions**
* `Admission_ID` (PK, INT)
* `Patient_ID` (FK) $\rightarrow$ References `Patients(Patient_ID)`
* `Doctor_ID` (FK) $\rightarrow$ References `Doctors(Doctor_ID)`
* `Hospital_ID` (FK) $\rightarrow$ References `Hospitals(Hospital_ID)`
* `Insurance_ID` (FK) $\rightarrow$ References `InsuranceProviders(Insurance_ID)`
* `Condition_ID` (FK) $\rightarrow$ References `MedicalConditions(Condition_ID)`
* `Medication_ID` (FK) $\rightarrow$ References `Medications(Medication_ID)`
* `Date_of_Admission` (DATE)
* `Discharge_Date` (DATE)
* `Admission_Type` (VARCHAR)
* `Room_Number` (INT)
* `Billing_Amount` (DECIMAL)
* `Test_Results` (VARCHAR)

---

## 2. Justification of Design Choices

### **Extraction of Dimensions (Normalization)**
In the original dataset, strings like "Blue Cross" (Insurance) or "Aspirin" (Medication) were repeated thousands of times.
* **Design:** We extracted `Doctors`, `Hospitals`, `Insurance`, `Conditions`, and `Medications` into their own tables.
* **Justification:** This adheres to **2NF** and **3NF** by ensuring non-key attributes (like the text "Aspirin") are not dependent on the `Admission_ID`. It reduces storage space and ensures consistent naming (e.g., preventing "Aspirin" and "aspirin" from being treated as different drugs).

### **Separation of Patient Data**
* **Design:** Patient demographics (Age, Gender, Blood Type) were moved to a dedicated `Patients` table.
* **Justification:** In the original flat file, if a patient visited the hospital three times, their Blood Type was repeated three times. This violated **2NF/3NF** concepts regarding redundancy. Moving this to the `Patients` table ensures that `Blood_Type` depends only on `Patient_ID`, not on the `Admission_ID`.

### **Choice 3: Central Admissions Table**
* **Design:** The `Admissions` table contains **Foreign Keys** pointing to all other tables.
* **Justification:** This creates a "Star Schema" structure. It accurately reflects the data that an admission is an intersection of a Patient, a Doctor, a Hospital, and a Condition.

---

## 3. How This Schema Avoids Data Anomalies

By normalizing to 3NF, this design prevents the three database anomalies:

### **1. Update Anomaly**
* **Scenario:** A doctor named "Dr. Smith" changes their name to "Dr. Jones" (e.g., due to marriage).
* **Original File:** We would have to find and update potentially thousands of rows where "Dr. Smith" appears. Even if we miss one, the data becomes inconsistent.
* **Proposed Schema:** We update **one single row** in the `Doctors` table. All `Admissions` records referencing that `Doctor_ID` automatically reflect the new name.

### **2. Insert Anomaly**
* **Scenario:** A new hospital is built, but no patients have been admitted there yet.
* **Original File:** We cannot add the hospital to the database because there is no "Admission" row to store it in. We would have to enter dummy data (fake patient, fake date) just to record the hospital's existence.
* **Proposed Schema:** We can simply insert a new row into the `Hospitals` table (`Hospital_ID`, `Name`). It can exist independently of any admission. Although there would be no patients data for a new hospital, until a first patient comes in. 

### **3. Delete Anomaly**
* **Scenario:** We delete the records of the only patient who was ever prescribed "Penicillin".
* **Original File:** When we delete that patient's row, the information that "Penicillin" as a medication is deleted from the database.
* **Proposed Schema:** We delete the row from the `Admissions` and  `Patients` table. However, the record for "Penicillin" remains safely stored in the `Medications` table, available for future use.
