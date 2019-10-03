connection: "thelook"

# include: "*.view.lkml"

view: test {
  sql_table_name: demo_db.products  ;;

  dimension: will_it_round  {
    type: number
    sql:  72837465847562289;;
    html: {{rendered_value}} ;;
  }
}

explore: test {}
