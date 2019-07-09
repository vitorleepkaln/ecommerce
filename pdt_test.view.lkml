view: pdt_test {
  derived_table: {
    sql:
  order_items.order_id  AS `order_items.order_id`,
  COALESCE(SUM(order_items.sale_price ), 0) AS `order_items.total_sale_price`
FROM demo_db.order_items  AS order_items
LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id

WHERE
  (((orders.created_at ) >= (TIMESTAMP('2019-05-01')) AND (orders.created_at ) < (TIMESTAMP('2019-05-31'))))
GROUP BY 1
ORDER BY COALESCE(SUM(order_items.sale_price ), 0) DESC
LIMIT 500;;

  }


}
