mappu:
   file.managed:
     - name: /etc/yum.repos.d/mappu.repo
     - source: salt://mappu/mappu.repo
     - user: root
     - group: root
     - mode: 644
     - template: jinja

mappu-pkgs:
   pkg.latest:
     - fromrepo: mappu
     - pkgs:
       - mappu-backend
       - mappu-ui
       - mappu-print
     - require:
       - file: /etc/yum.repos.d/mappu.repo
       - pkg: other-mappu-packages

# the presence of this file instructs web apps rpm scripts
# to avoid restarting tomcat on install/upgrade/remove
/var/tmp/no-tomcat-restart:
   file.touch

other-mappu-packages:
   pkg.installed:
      - pkgs:
        - jdk
        - java-jai
        - apache-tomcat
        - mapfish-print-servlet
        - geoserver
        - make
      - require:
        - file: /var/tmp/no-tomcat-restart

# if we update any of tomcat apps/packages, restart tomcat to avoid mem leaks
/etc/init.d/tomcat7 restart:
   cmd.wait:
    - watch:
      - pkg: other-mappu-packages

tomcat7:
   service:
     - running
     - require:
       - pkg: other-mappu-packages

/opt/tomcat/webapps/print-servlet/config.yaml:
   file.managed:
     - source: salt://mappu/config.yaml
     - user: tomcat
     - group: tomcat
     - mode: 644
     - template: jinja
     - order: last

# last: remove lock
/bin/rm -f /var/tmp/no-tomcat-restart:
   cmd.run:
     - order: last

