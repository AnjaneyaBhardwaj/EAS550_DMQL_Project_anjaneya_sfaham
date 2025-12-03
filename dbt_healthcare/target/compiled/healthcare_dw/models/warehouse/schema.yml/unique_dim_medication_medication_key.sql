
    
    

select
    medication_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."dim_medication"
where medication_key is not null
group by medication_key
having count(*) > 1


