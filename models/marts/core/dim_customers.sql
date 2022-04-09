/*
Add a new field called lifetime_value to the dim_customers model:
lifetime_value: the total amount a customer has spent at jaffle_shop
Hint: The sum of lifetime_value is $1,672
*/

with
customer_orders as (
    select
        orders.customer_id,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as last_order_date,
        count(*) as number_of_orders,
        sum(case when payments.status = 'success' then payments.amount end) as lifetime_value
    from
        {{ref('stg_orders')}} as orders
    left join
        {{ref('stg_payments')}} as payments
        on payments.order_id = orders.order_id
    group by
        customer_id
)
select
    customers.*,
    customer_orders.first_order_date,
    customer_orders.last_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
    coalesce(customer_orders.lifetime_value, 0) as lifetime_value
from
    {{ref('stg_customers')}} customers
left join
    customer_orders
    on customer_orders.customer_id = customers.customer_id
