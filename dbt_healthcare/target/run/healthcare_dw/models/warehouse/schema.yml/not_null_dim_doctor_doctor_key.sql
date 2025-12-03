
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select doctor_key
from "healthcare"."public"."dim_doctor"
where doctor_key is null



  
  
      
    ) dbt_internal_test