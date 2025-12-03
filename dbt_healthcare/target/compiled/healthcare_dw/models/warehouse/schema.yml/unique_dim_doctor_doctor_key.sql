
    
    

select
    doctor_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."dim_doctor"
where doctor_key is not null
group by doctor_key
having count(*) > 1


