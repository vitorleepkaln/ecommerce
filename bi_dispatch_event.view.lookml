- view: bi_dispatch_event
  derived_table:
    persist_for: 24 hours
    distribution_style: all
    explore_source: dispatch_deliverystatuslogs
    columns:
    - column: delivery_pk
      field: dispatch_deliveries.delivery_pk
    - column: status_description
    - column: estimated_pickup_time
      field: dispatch_quotes.estimated_pickup_time
    - column: estimated_dropoff_time
      field: dispatch_quotes.estimated_dropoff_time
    - column: last_activity
    - derived_column: status_off_minutes
      sql: datediff(minute,estimated_pickup_time,estimated_dropoff_time)
    filters:
    - field: dispatch_deliveries.delivery_pk
      value: 920eddc5-dd0e-45bf-9568-c2e47590cd38
    - field: dispatch_deliverystatuslogs.activity_date
      value: after 2019/06/01
  fields:
  - dimension: delivery_pk
  - dimension: status_description
  - dimension: estimated_pickup_time
    type: date_time
  - dimension: estimated_dropoff_time
    type: date_time
  - dimension: last_activity
#   - dimension: status_off_minutes
#     type: number
