
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hospital_key
from "healthcare"."public_warehouse"."fact_admissions"
where hospital_key is null



  
  
      
    ) dbt_internal_test