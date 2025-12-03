
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_readmission
from "healthcare"."public_warehouse"."fact_admissions"
where is_readmission is null



  
  
      
    ) dbt_internal_test