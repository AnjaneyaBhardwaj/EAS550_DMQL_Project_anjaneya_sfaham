
    
    

select
    insurance_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."dim_insurance"
where insurance_key is not null
group by insurance_key
having count(*) > 1


