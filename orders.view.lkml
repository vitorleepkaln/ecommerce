view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    drill_fields: [id, status]
    link: {
      label: "test liquid filter"
      url: "https://localhost:9999/looks/9?&f[orders.id]={{ value }}"
    }
  }

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    default_value: "Date"
  }

  dimension: dynamic_timeframe {
    type: date
    sql:
    CASE
      WHEN {% parameter timeframe_picker %} = 'Date' THEN ${orders.created_date}
      WHEN {% parameter timeframe_picker %} = 'Week' THEN ${orders.created_week}
      WHEN{% parameter timeframe_picker %} = 'Month' THEN ${orders.created_month}
      WHEN{% parameter timeframe_picker %} = 'Quarter' THEN ${orders.created_quarter}
    END ;;
  }
  # WHEN{% parameter timeframe_picker %} = 'Quarter' THEN CONCAT(${orders.created_year},'-',${created_quarter_of_year})

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
      month_name,
      day_of_month,
      quarter_of_year,
      day_of_week
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status_new {
    type: yesno
    sql: ${status} = "complete" ;;
    }

  filter: date_filter  {
    type: date
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
    drill_fields: [id]
  }

  dimension: status_case {
    type: string
    sql: CASE
          WHEN ${status} = "complete" THEN ${id}
          ELSE ${created_date}
          END;;
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

#     drill_fields: [id,order_items.total_sale_price]
  }


  measure: count_may {
    type: count
    filters: {
      field: created_month
      value: "3 months ago for 1 month"
    }

  }

  measure: ten {
    type: number
    sql: 10 ;;
  }

  measure: Negative_Ten {
    type: number
    sql: -10 ;;
  }

  measure: format_10 {
    type: number
    sql: -10 ;;
    value_format: "$#,##0.00;($#,##0.00)"

  }

  dimension: fake_year {
    type: number
    sql: 2019;;
  }
}
