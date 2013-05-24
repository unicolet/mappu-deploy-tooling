base:
  '*':
{% if pillar['appserver'] == grains['id'] %}
    - nginx
    - redis
    - nodejs 
    - mappu 
{% endif %}
{% if pillar['dbserver'] == grains['id'] %}
    - postgres
{% endif %}
    - mappu.application
    - firewall

