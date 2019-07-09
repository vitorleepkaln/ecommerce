view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    label: "Orders ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
#     html:
#       {% if orders.status._value == 'complete' %}
#         <b>{{value}}</b>
#       {% elsif orders.status._value == 'pending' %}
#         <i>{{value}}</i>
#       {% else %}
#         <style="color:red">{{value}}</style>
#       {% endif %} ;;
drill_fields: [id, status]

  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      week_of_year,
      month_name
    ]
    sql: ${TABLE}.created_at ;;
  }

  parameter: test {
    default_value: "yes"
  }
  dimension: month_name {
    label: "Month Formatted"
    type: string
    sql: ${created_month};;
    html: {{ rendered_value | append: "-01" |  date: "%B-%Y" }};;

  }

  dimension: weekyear {
    type: string
    sql:  CONCAT(${created_week_of_year},${created_year});;
  }

  dimension: status {
    type: string
    label: "Order Status"
    sql: ${TABLE}.status ;;
    # hidden: yes
  }

  dimension: filter {
    type: yesno
    sql: ${created_year} IN (2018,2019) AND
    CASE WHEN
    ${created_year} = 2019 THEN ${created_month_name}  = "January"
    WHEN ${created_year} = 2018 THEN ${created_month_name} = "February"
    END ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    # drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    # link: {
    #   label: "Drill Dashboard"
    #   url: "http://looker.com"
    # }

    # link: {
    #   label: "Drill Look"
    #   url: "http://google.com? {{ id._value }}&{{ user_id._value }}&{{order_items.count._value }}"
    # }
    # link: {

    #   label: "Filtered Drill Modal"

    #   url: "{{ link }}"

    # }
  }

  measure: count_may {
    type: count
    filters: {
      field: created_month
      value: "3 months ago for 1 month"
    }

  }
}
