{% macro flatten_json(modelname,json_column)%}
{% set json_query %}
SELECT
  distinct v.key as col_name
FROM
  {{ modelname }}, 
  lateral flatten(input => {{ json_column }} ) AS K,
  lateral flatten(input => k.value) as v
{% endset %}


{% set results = run_query(json_query) %}
{% if execute %}
{% set results_List = results.columns[0].values() %}
{% else %}
{% set results_List = [] %}
{% endif %}

select 
{% for column_name in results_List %} 
k.value: {{ column_name }} ::varchar as {{ column_name }}
{% if not loop.last %},{% endif %}
{% endfor %}
from {{ modelname }},
lateral flatten(input => {{ json_column }} ) AS K

{% endmacro %}