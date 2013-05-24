redis:
   pkg:
     - installed
   service:
     - running
     - require:
       - pkg: redis
