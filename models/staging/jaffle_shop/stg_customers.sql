with customers as (
    select
    id as customer_id,
    first_name,
    last_name
    from
    `dataset_dbt.customers`
)
select * from customers