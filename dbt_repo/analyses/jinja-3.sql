{% set inc_flag = 1 %}
{% set last_load = 3 %}

{% set cols_name = "sales_id", "date_sk", "gross_amount"%}

select 
    {% for col in cols_name %}
        {{ col }} {%if not loop.last%}, {%endif%}
    {% endfor %}
from
    {{ ref('bronze_sales')}}
where

{% if inc_flag == 1 %}
    where date_sk > {{ last_load }}
{% endif %}



