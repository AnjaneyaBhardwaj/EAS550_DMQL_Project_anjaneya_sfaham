
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    medication_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."dim_medication"
where medication_key is not null
group by medication_key
having count(*) > 1



  
  
      
    ) dbt_internal_test