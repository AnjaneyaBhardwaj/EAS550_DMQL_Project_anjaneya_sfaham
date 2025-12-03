
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        condition_category as value_field,
        count(*) as n_records

    from "healthcare"."public_warehouse"."dim_condition"
    group by condition_category

)

select *
from all_values
where value_field not in (
    'Chronic','Acute','Infectious'
)



  
  
      
    ) dbt_internal_test