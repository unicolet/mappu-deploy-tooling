applications:
   - demo:
     name: demo
     title: Mappu Demo
     port: 3001
     dbserver: default
     cookiesecret: gfHF038859fd3849588Fjdj
     dbpassword: hdfg675756ddj747
     extra_reverse_proxies:
       /ms-ng/ : http://localhost:8080/ms-ng/
