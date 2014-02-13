{% if '0.14' == grains['saltversion'][0:4] %}
postgres92-repo:
   file.managed:
     - name: /etc/yum.repos.d/pgdg-92-centos.repo
     - source: salt://postgres/pgdg.repo
     - user: root
     - group: root
     - mode: 644
     - template: jinja
{% else %}
#
# Salt 0.14 has bug for which pgrepo does not work correctly for
# yum repositories, working around it with file.managed
#
postgres92-repo:
   pkgrepo.managed:
     - name: pgdg-92-centos
     - humanname: pgdg-92-centos
     - baseurl: http://yum.postgresql.org/9.2/redhat/rhel-$releasever-$basearch
     - gpgcheck: 0
{% endif %}

postgresql92-server:
   pkg:
     - installed
     - refresh: True
     - fromrepo: pgdg-92-centos
     - require:
{% if '0.14' == grains['saltversion'][0:4] %}
       - file: /etc/yum.repos.d/pgdg-92-centos.repo
{% else %}
       - pkgrepo: pgdg-92-centos
{% endif %}
   service:
     - name: postgresql-9.2
     - running
     - require:
       - cmd: postgres_initdb
       - file: /var/lib/pgsql/9.2/data/pg_hba.conf
       - file: /var/lib/pgsql/9.2/data/postgresql.conf
     - watch:
       - file: /var/lib/pgsql/9.2/data/pg_hba.conf
       - file: /var/lib/pgsql/9.2/data/postgresql.conf

postgres_initdb:
   cmd.run:
    - name: service postgresql-9.2 initdb
    - unless: /bin/ls /var/lib/pgsql/9.2/data/PG_VERSION
    - require:
      - pkg: postgresql92-server

/var/lib/pgsql/9.2/data/pg_hba.conf:
   file.managed:
     - source: salt://postgres/pg_hba.conf
     - user: postgres
     - group: postgres
     - mode: 600
     - template: jinja
     - require:
       - cmd: postgres_initdb

/var/lib/pgsql/9.2/data/postgresql.conf:
   file.sed:
     - before: "#listen_addresses = 'localhost'"
     - after: "listen_addresses = '*'"
     - require:
       - cmd: postgres_initdb

