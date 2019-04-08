- dashboard: local_model_dashboard
  title: Vitor is the best
  layout: newspaper
  elements:
  - title: "# Orders MOM"
    name: "# Orders MOM"
    model: e_commerce
    explore: orders
    type: looker_line
    fields: [orders.created_month, orders.count]
    fill_fields: [orders.created_month]
    sorts: [orders.created_month desc]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 6
    col: 0
    width: 24
    height: 6
  - title: Top 20 sold categories
    name: Top 10 sold categories
    model: e_commerce
    explore: order_items
    type: looker_bar
    fields: [order_items.count, products.category]
    sorts: [order_items.count desc]
    limit: 10
    query_timezone: America/Los_Angeles
    series_types: {}
    listen: {}
    row: 12
    col: 0
    width: 13
    height: 6
  - title: States x Orders
    name: States x Orders
    model: e_commerce
    explore: order_items
    type: looker_map
    fields: [order_items.count, users.state]
    sorts: [order_items.count desc]
    limit: 10
    query_timezone: America/Los_Angeles
    series_types: {}
    map_position: custom
    map_latitude: 38.35458032659834
    map_longitude: -83.79066467285158
    map_zoom: 4
    row: 12
    col: 13
    width: 11
    height: 11
  - title: Orders by Gender
    name: Orders by Gender
    model: e_commerce
    explore: order_items
    type: looker_pie
    fields: [order_items.count, users.gender]
    sorts: [order_items.count desc]
    limit: 10
    dynamic_fields: [{table_calculation: gender, label: Gender, expression: 'if(${users.gender}="m","Male","Female")',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        _type_hint: string}]
    query_timezone: America/Los_Angeles
    series_types: {}
    map_position: custom
    map_latitude: 38.35458032659834
    map_longitude: -83.79066467285158
    map_zoom: 4
    hidden_fields: [users.gender]
    row: 0
    col: 13
    width: 8
    height: 6
  - title: Total Revenue
    name: Total Revenue
    model: e_commerce
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price]
    limit: 10
    query_timezone: America/Los_Angeles
    series_types: {}
    map_position: custom
    map_latitude: 38.35458032659834
    map_longitude: -83.79066467285158
    map_zoom: 4
    hidden_fields: []
    row: 0
    col: 5
    width: 8
    height: 6
