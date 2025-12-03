
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select insurance_key
from "healthcare"."public"."dim_insurance"
where insurance_key is null



  
  
      
    ) dbt_internal_test