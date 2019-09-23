# If necessary, uncomment the line below to include explore_source.
# include: "e_commerce.model.lkml"

view: count_month {
  derived_table: {
    explore_source: users {
      column: created_month {}
      column: count {}
    }
  }
  dimension: created_month {
    type: date_month
  }
  dimension: count {
    type: number
  }
}
