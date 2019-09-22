connection: "ctsdev"

# include all the views
include: "*.view"

datagroup: hr_products_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: hr_products_default_datagroup

explore: fcc {
  label: "Bosnjak"
}
