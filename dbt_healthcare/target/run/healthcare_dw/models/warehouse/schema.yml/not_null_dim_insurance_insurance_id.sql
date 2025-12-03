
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select insurance_id
from "healthcare"."public_warehouse"."dim_insurance"
where insurance_id is null



  
  
      
    ) dbt_internal_test