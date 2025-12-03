
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select medication_id
from "healthcare"."public_warehouse"."dim_medication"
where medication_id is null



  
  
      
    ) dbt_internal_test