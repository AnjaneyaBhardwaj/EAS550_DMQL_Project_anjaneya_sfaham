# EAS550 DMQL Project - Healthcare Data Management

## Overview

This project implements a robust data management system for healthcare records. It features a normalized PostgreSQL database schema, an automated ETL (Extract, Transform, Load) pipeline to ingest data from Kaggle, and role-based security configurations. The system is containerized using Docker for easy deployment and reproducibility.

## Features

- **Containerized Database**: Uses Docker and Docker Compose to spin up a PostgreSQL 16 instance.
- **Normalized Schema**: Data is organized into a normalized relational schema (Patients, Doctors, Hospitals, etc.) to ensure data integrity.
- **Automated Ingestion**: A Python script (`ingest_data.py`) automatically downloads the dataset from Kaggle and populates the database.
- **Security**: Includes SQL scripts for setting up Role-Based Access Control (RBAC) with distinct roles for analysts and application users.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://www.docker.com/get-started) & [Docker Compose](https://docs.docker.com/compose/install/)
- [Python 3.8+](https://www.python.org/downloads/)
- `git`

## Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd EAS550_DMQL_Project_anjaneya_sfaham
```

### 2. Start the Database

Start the PostgreSQL container using Docker Compose:

```bash
docker-compose up -d
```

This will start a PostgreSQL instance on port `5432` with the database `healthcare`.

### 3. Install Python Dependencies

Create a virtual environment and install the required packages:

```bash
pip install -r requirements.txt
```

## Database Initialization

Once the Docker container is running, you need to apply the schema and security configurations.

### 1. Apply Database Schema

Create the tables by running the `schema.sql` script inside the container:

```bash
docker exec -i healthcare_database psql -U sfaham_anjaneya -d healthcare < schema.sql
```

### 2. Apply Security Configurations

Set up users and roles by running the `security.sql` script:

```bash
docker exec -i healthcare_database psql -U sfaham_anjaneya -d healthcare < security.sql
```

## Data Ingestion

To populate the database with data from the [Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset) from kaggle, run the ingestion script:

```bash
python ingest_data.py
```

This script will:
1. Download the dataset from Kaggle.
2. Process and normalize the data.
3. Insert the data into the appropriate tables in the PostgreSQL database.

> **Note**: You may need to authenticate with Kaggle if you haven't already. Follow the instructions [here](https://github.com/Kaggle/kagglehub#authentication) if prompted.

## Project Structure

```
.
├── docker-compose.yml    # Docker Compose configuration for PostgreSQL
├── ingest_data.py        # Python ETL script for data ingestion
├── requirements.txt      # Python dependencies
├── schema.sql            # Database schema definition (DDL)
├── security.sql          # Database security and role definitions (DCL)
├── ER_Diagram.png        $ Image of ER diagram
├── REPORT.md             # Schema design report 
└── README.md             # Project documentation
```

## Database Schema

The database consists of the following main tables:
- `Patients`
- `Doctors`
- `Hospitals`
- `InsuranceProviders`
- `MedicalConditions`
- `Medications`
- `Admissions` (Fact table linking all dimensions)

## Contributors

- Anjaneya Bhardwaj
- Syed Mohammed Faham