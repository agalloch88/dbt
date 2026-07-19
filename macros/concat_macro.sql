{% macro concat_macro(val1, val2) %}

concat('{{val1}}', '|', '{{val2}}')

{% endmacro %}