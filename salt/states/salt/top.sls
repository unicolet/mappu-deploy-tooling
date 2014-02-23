base:
  '*':
{% if pillar['appserver'] == grains['id'] or '*' == pillar['appserver'] %}
    - nginx
    - redis
    - nodejs 
    - mappu 
    - mappu.application
{% endif %}
{% if pillar['dbserver'] == grains['id']or '*' == pillar['dbserver']  %}
    - postgres
{% endif %}
{% if not pillar.get('docker',False) %}
    - firewall
{% endif %}

