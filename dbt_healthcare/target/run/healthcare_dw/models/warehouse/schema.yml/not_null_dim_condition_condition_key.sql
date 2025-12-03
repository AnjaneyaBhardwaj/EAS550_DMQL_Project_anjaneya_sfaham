
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select condition_key
from "healthcare"."public"."dim_condition"
where condition_key is null



  
  
      
    ) dbt_internal_test