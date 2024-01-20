with
    customers as (select * from {{ ref("stg_customers") }}),
    orders as (select * from {{ ref("stg_orders") }}),
    customer_orders as (
        select
            c.customer_id,
            c.email,
            c.country,
            c.city,
            min(o.order_approved_at) as first_order_approved_at,
            max(o.order_delivered_at) as last_order_delivered_at,
            count(o.order_id) as total_orders,
        from orders o
        inner join customers c using (customer_id)
        group by c.customer_id, c.email, c.country, c.city
    )
select * 
from customer_orders