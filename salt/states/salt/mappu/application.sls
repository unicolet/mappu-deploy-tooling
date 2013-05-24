#
# Blueprint: create db user, database, configure node backend instance, create vhost
#
/etc/nginx/conf.d/mappu_vhosts.conf:
   file.managed:
     - source: salt://mappu/nginx_vhost.conf
     - user: root
     - group: root
     - mode: 644
     - template: jinja
     - watch_in: 
       - service: nginx

/etc/nginx/conf.d/default.conf.no:
   file.rename:
     - source: /etc/nginx/conf.d/default.conf
     - force: true
     - watch_in:
       - service: nginx

# this creates a nodejs backend instance for the app
{% for application in pillar['applications'] %}

/etc/init/node_{{- application.name -}}.conf:
   file.managed:
     - source: salt://mappu/upstart_node.conf
     - user: root
     - group: root
     - mode: 644
     - template: jinja
     - context:{% for k in application %}
       ctx_{{k}}: {{ application.get(k) }}{% endfor %}
     - require:
       - pkg: mappu-pkgs
       - file: /var/www/html/assets_{{- application.name }}/appconfig.js

#
# until salt support upstart on centos this will have to stay commented
# btw, it should work when salt reaches 14.1, see https://github.com/saltstack/salt/commit/733dbc1e67685d42a769c88769c9fa1c7107aedc
#
#node_{{- application.name -}}:
#   service:
#     - running
#     - require:
#       - file: /etc/init/node_{{- application.name -}}.conf
#     - watch:
#       - file: /etc/init/node_{{- application.name -}}.conf

stop node_{{- application.name -}}; start node_{{- application.name -}}:
   cmd:
     - wait
     - watch:
       - file: /etc/init/node_{{- application.name -}}.conf
       - pkg: mappu-pkgs

# update application db schema on package changes
DB_USER="pg_{{- application.name -}}" DB_PASSWORD="{{- application.dbpassword -}}" DB_NAME="db_{{- application.name -}}" DB_HOST="localhost" /usr/bin/make -C /opt/mapsocial -f /opt/mapsocial/Makefile liquibase_prod:
   cmd:
     - wait
     - watch:
       - file: /etc/init/node_{{- application.name -}}.conf
       - pkg: mappu-pkgs
       - postgres_database: db_{{- application.name }}
     - require:
       - postgres_database: db_{{- application.name }}


# database user
pg_{{- application.name -}}:
   postgres_user.present:
     - password: {{ application.dbpassword }}
     - require:
       - service: postgresql-9.2

db_{{- application.name -}}:
   postgres_database.present:
     - owner: pg_{{ application.name }}
     - require:
       - postgres_user: pg_{{ application.name }}

/var/www/html/assets_{{- application.name -}}/appconfig.js:
   file.managed:
     - source: salt://mappu/appconfig.js
     - user: root
     - group: root
     - mode: 644
     - makedirs: True
     - template: jinja
     - context:{% for k in application %}
       ctx_{{k}}: {{ application.get(k) }}{% endfor %}


{% endfor %}

