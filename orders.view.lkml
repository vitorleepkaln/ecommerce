view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html:
      {% if orders.status._value == 'complete' %}
        <b>{{value}}</b>
      {% elsif orders.status._value == 'pending' %}
        <i>{{value}}</i>
      {% else %}
        <style="color:red">{{value}}</style>
      {% endif %} ;;
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
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    link: {
      label: "Drill Dashboard"
      url: "http://looker.com"
    }

    link: {
      label: "Drill Look"
      url: "http://google.com"
    }
    link: {

      label: "Filtered Drill Modal"

      url: "{{ link }}"

    }
  }
}
