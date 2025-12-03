
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    hospital_id as unique_field,
    count(*) as n_records

from "healthcare"."public_warehouse"."dim_hospital"
where hospital_id is not null
group by hospital_id
having count(*) > 1



  
  
      
    ) dbt_internal_test