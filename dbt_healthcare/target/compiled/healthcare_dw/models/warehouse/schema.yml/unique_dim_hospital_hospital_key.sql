
    
    

select
    hospital_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."dim_hospital"
where hospital_key is not null
group by hospital_key
having count(*) > 1


