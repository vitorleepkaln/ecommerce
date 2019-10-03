connection: "thelook"

#this is SUPER COOL a test
# include all the views
include: "*.view"

datagroup: e_commerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;

  max_cache_age: "2 hours"
}


# persist_with: e_commerce_default_datagroup


explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

test: test_there_are_users {
  explore_source: users {
    column: count {}
  }
  assert: there_is_data {
    expression: ${users.count} > 0 ;;
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  # sql_always_where: ${orders.status} IS NOT NULL;;

  join: inventory_items {
    # from: inventory_items
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one

  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_2 {
  view_name: orders
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: products {
  #cancel_grouping_fields: [products.departmentconcat]
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
}

explore: users_nn {
}

explore: count_month {
  join: month {
  from:count_month
    type: left_outer
    sql_on: ${count_month.created_month} = ${month.created_month} ;;
    relationship: one_to_one

  }

}
