/*
order_id
customer_id
amount (hint: this has to come from payments)
*/

select
    customers.customer_id,
    orders.order_id,
    payments.amount
from
    {{ref('stg_customers')}} as customers
join
    {{ref('stg_orders')}} as orders
    on orders.customer_id = customers.customer_id
join
    {{ref('stg_payments')}} as payments
    on payments.order_id = orders.order_id
