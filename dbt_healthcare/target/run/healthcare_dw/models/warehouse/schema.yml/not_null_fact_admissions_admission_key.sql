
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select admission_key
from "healthcare"."public"."fact_admissions"
where admission_key is null



  
  
      
    ) dbt_internal_test