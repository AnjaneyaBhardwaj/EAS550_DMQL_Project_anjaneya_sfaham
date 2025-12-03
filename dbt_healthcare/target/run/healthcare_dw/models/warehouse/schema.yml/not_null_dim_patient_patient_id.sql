
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select patient_id
from "healthcare"."public_warehouse"."dim_patient"
where patient_id is null



  
  
      
    ) dbt_internal_test