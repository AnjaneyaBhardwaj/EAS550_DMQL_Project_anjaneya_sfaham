
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hospital_id
from "healthcare"."public_warehouse"."dim_hospital"
where hospital_id is null



  
  
      
    ) dbt_internal_test