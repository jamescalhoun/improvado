view: adsets_adwords {
  sql_table_name: public.adsets_raw_table_adwords ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: adset_id {
    type: string
    sql: ${TABLE}.adset_id ;;
  }

  dimension: adset_name {
    type: string
    sql: ${TABLE}.adset_name ;;
  }

  dimension: avg_pos {
    type: number
    sql: ${TABLE}.avg_pos ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.campaign_type ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conv {
    type: number
    sql: ${TABLE}.conv ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.date ;;
  }

  dimension: date_yyyymmdd {
    type: string
    sql: ${TABLE}.date_yyyymmdd ;;
  }

  dimension: imps {
    type: number
    sql: ${TABLE}.imps ;;
  }

  dimension: purchase {
    type: number
    sql: ${TABLE}.purchase ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: views {
    type: number
    sql: ${TABLE}.views ;;
  }
  measure: cost {
    type: sum
    sql: ${spend} ;;
    drill_fields: [campaign_name, adset_name]
    value_format_name: usd
  }

  measure: conversions {
    type: sum
    sql: ${conv} ;;
    drill_fields: [campaign_name, adset_name]
  }

  measure: cpa {
    type: number
    sql: ${cost}::float/NULLIF(${conversions},0) ;;
    value_format_name: usd
  }

  measure: impressions {
    type: sum
    sql: ${imps} ;;
    drill_fields: [campaign_name, adset_name]
  }

  measure: click {
    type: sum
    sql: ${clicks} ;;
    drill_fields: [campaign_name, adset_name]
  }

  measure: ctr {
    type: number
    sql: ${click}::float/NULLIF(${impressions},0) ;;
    value_format_name: percent_2
  }

  measure: conv_rate {
    type: number
    sql: ${conversions}::float/NULLIF(${click},0) ;;
    value_format_name: percent_2
  }

  measure: cpc {
    type: number
    sql: ${cost}::float/NULLIF(${click},0) ;;
    value_format_name: usd
  }
  measure: count {
    type: count
    drill_fields: [campaign_name, adset_name]
  }
}
