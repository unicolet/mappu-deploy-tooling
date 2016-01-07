firewall:
  service:
     - name: iptables
     - running
     - watch:
       - file: /etc/sysconfig/iptables

# enable http, postgres and ssh
/etc/sysconfig/iptables:
  file.replace:
    - pattern: tcp -p tcp --dport 22
    - repl: multiport -p tcp --dports 22,80,5432
    - count: 1
