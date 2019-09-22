view: fcc {
 view_label: "Bosnjak"
  sql_table_name: fcc_bosnjak ;;

  dimension_group: reading {
    type: time
    timeframes: [raw, date, time, hour, hour_of_day, day_of_week, week,]
    sql: cast(TIMESTAMPTZ(${TABLE}.t1) as timestamp);;
  }

  dimension_group: t1 {
    label: "Raw"
    type: time
    timeframes: [raw, date, time, hour, month, day_of_week, week, hour_of_day, time_of_day]
    sql: cast(TIMESTAMPTZ(${TABLE}.t1) as timestamp) ;;
    drill_fields: [t1_date,t1_hour,t1_month]
  }

  dimension_group: reading_8am {
    description: "A date starts from 8am of that day and ends before 8am of the following day."
    type: time
    timeframes: [date, hour, week, month, year]
    sql: DATEADD(hour,-8,${reading_raw}) ;;
  }

  dimension: v1 {
    label: "Value"
    type: number
    sql: ${TABLE}.v1 ;;
  }

  dimension: name {
    label: "Name"
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: long_name {
    label: "Long Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: area {
    type: string
    sql: split_part(${name}, '.', 2) ;;
  }

  dimension: device {
    type: string
    sql: split_part(${name}, '.', 3) ;;
  }

  dimension:  application {
    type: string
    sql: split_part(${name}, '.', 5) ;;
  }

  dimension:  location {
    label: "Asset Location"
    type: string
    sql: split_part(${name}, '.',4 ) ;;
  }



  measure: average_value {
    type: average
    sql: ${v1} ;;
    value_format_name: decimal_2
  }
  measure: max_value {
    type: max
    sql: ${v1} ;;
    value_format_name: decimal_2
  }
  measure: min_value {
    type: min
    sql: ${v1} ;;
    value_format_name: decimal_2
  }
}
