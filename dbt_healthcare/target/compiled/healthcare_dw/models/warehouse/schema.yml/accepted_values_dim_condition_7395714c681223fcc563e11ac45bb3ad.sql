
    
    

with all_values as (

    select
        severity_level as value_field,
        count(*) as n_records

    from "healthcare"."public_warehouse"."dim_condition"
    group by severity_level

)

select *
from all_values
where value_field not in (
    'Low','Medium','High','Critical'
)


