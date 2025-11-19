import pandas as pd
from sqlalchemy import create_engine
import kagglehub
import os

db_url = 'postgresql://sfaham_anjaneya:sfaham_anjaneya_password@localhost:5432/healthcare'
engine = create_engine(db_url)


path = kagglehub.dataset_download("prasad22/healthcare-dataset")

# Load the dataset
csv_path = os.path.join(path, "healthcare_dataset.csv")
df = pd.read_csv(csv_path)

def process_dimension(df, col_name, table_name, db_col_name, id_col_name):
    print(f"Processing {table_name}...")
    unique_vals = df[[col_name]].drop_duplicates().dropna()
    unique_vals.columns = [db_col_name] # Rename to match DB schema
    
    try:
        unique_vals.to_sql(table_name, engine, if_exists='append', index=False)
    except Exception as e:
        print(f"Note: {table_name} might already have data. Skipping insertion.")


    dim_table = pd.read_sql(f"SELECT * FROM {table_name}", engine)

    return dict(zip(dim_table[db_col_name], dim_table[id_col_name]))


patients = df[['Name', 'Age', 'Gender', 'Blood Type']].drop_duplicates()
patients.columns = ['name', 'age', 'gender', 'blood_type'] 
patients.to_sql('patients', engine, if_exists='append', index=False)
patient_map = pd.read_sql("SELECT name, patient_id FROM patients", engine)

patient_dict = dict(zip(patient_map['name'], patient_map['patient_id']))
doctor_dict = process_dimension(df, 'Doctor', 'doctors', 'name', 'doctor_id')
hospital_dict = process_dimension(df, 'Hospital', 'hospitals', 'name', 'hospital_id')
insurance_dict = process_dimension(df, 'Insurance Provider', 'insuranceproviders', 'name', 'insurance_id')
condition_dict = process_dimension(df, 'Medical Condition', 'medicalconditions', 'condition_name', 'condition_id')
medication_dict = process_dimension(df, 'Medication', 'medications', 'medication_name', 'medication_id')


admissions = df.copy()


admissions['Patient_ID'] = admissions['Name'].map(patient_dict)
admissions['Doctor_ID'] = admissions['Doctor'].map(doctor_dict)
admissions['Hospital_ID'] = admissions['Hospital'].map(hospital_dict)
admissions['Insurance_ID'] = admissions['Insurance Provider'].map(insurance_dict)
admissions['Condition_ID'] = admissions['Medical Condition'].map(condition_dict)
admissions['Medication_ID'] = admissions['Medication'].map(medication_dict)


final_df = admissions[[
    'Patient_ID', 'Doctor_ID', 'Hospital_ID', 'Insurance_ID', 
    'Condition_ID', 'Medication_ID', 
    'Date of Admission', 'Discharge Date', 'Admission Type', 
    'Room Number', 'Billing Amount', 'Test Results'
]].copy()

final_df['Billing Amount'] = final_df['Billing Amount'].abs()

final_df.columns = [
    'patient_id', 'doctor_id', 'hospital_id', 'insurance_id', 
    'condition_id', 'medication_id', 
    'date_of_admission', 'discharge_date', 'admission_type', 
    'room_number', 'billing_amount', 'test_results'
]

# Load into Postgres
final_df.to_sql('admissions', engine, if_exists='append', index=False)

print("Data Ingestion Complete!")
