
    
    

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


