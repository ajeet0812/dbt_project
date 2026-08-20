{% set columns = ['customer_id', 'name', 'email', 'city']%}

select
{% for column in columns %}
    {{column}} {%if not loop.last %}, {% endif %}

{% endfor %}

from customers



