
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hospital_key
from "healthcare"."public"."dim_hospital"
where hospital_key is null



  
  
      
    ) dbt_internal_test