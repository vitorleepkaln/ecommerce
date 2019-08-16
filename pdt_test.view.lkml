view: pdt_test {
  derived_table: {
    sql:
SELECT
  orders.status  AS `orders.status`,
  COUNT(*) AS `orders.count`
FROM demo_db.orders  AS orders

GROUP BY 1
ORDER BY COUNT(*) DESC
LIMIT 500;;

  }

  dimension: status {
    type: string
    sql: ${TABLE}.orders.status ;;
  }

  measure: count {
    type: count
  }


}
