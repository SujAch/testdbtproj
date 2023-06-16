{% set json_query %}
select distinct
SELECT
  distinct v.key
FROM
  {{ source('JSON_TABLE',"MYJSONTABLE") }}, 
  lateral flatten(input => JSON_DATA ) AS K, lateral flatten(input =>k.value) as v
order by 1
{% endset %}

{% set results = run_query(json_query) %}

{% if execute %}
{# Return the first column #}
{% set results_List = results.columns[0].values() %}
{% else %}
{% set results_List = [] %}
{% endif %}


select 
JSON_DATA,
{% for column_name in results_List %}
{{json_column}}:{{ column_name }} as {{column_name}}
{% if not loop.last %},{% endif %}
{%endfor %}
from {{ source('JSON_TABLE',"MYJSONTABLE") }}

