
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        season as value_field,
        count(*) as n_records

    from "healthcare"."public"."dim_date"
    group by season

)

select *
from all_values
where value_field not in (
    'Spring','Summer','Fall','Winter'
)



  
  
      
    ) dbt_internal_test