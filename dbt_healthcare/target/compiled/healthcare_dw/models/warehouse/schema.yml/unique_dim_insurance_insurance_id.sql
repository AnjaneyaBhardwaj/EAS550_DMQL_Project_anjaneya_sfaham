
    
    

select
    insurance_id as unique_field,
    count(*) as n_records

from "healthcare"."public_warehouse"."dim_insurance"
where insurance_id is not null
group by insurance_id
having count(*) > 1


