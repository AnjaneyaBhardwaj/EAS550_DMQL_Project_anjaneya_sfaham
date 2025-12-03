
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    admission_key as unique_field,
    count(*) as n_records

from "healthcare"."public"."fact_admissions"
where admission_key is not null
group by admission_key
having count(*) > 1



  
  
      
    ) dbt_internal_test