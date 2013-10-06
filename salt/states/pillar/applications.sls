applications:
   - demo:
     name: demo
     title: Mappu Demo
     port: 3001
     dbserver: default
     cookiesecret: gfHF038859fd3849588Fjdj
     dbpassword: hdfg675756ddj747
     server_path: "/geoserver/wms"
     wfs_server_path: "/geoserver/wfs"
     server_cache_path: "/geoserver/gwc/service/wms"
     enable_printing: true
# example of a custom reverse proxy, geoserver is proxied by default
     extra_reverse_proxies:
       /ms-ng/ : http://localhost:8080/ms-ng/
# example of setting custom nginx params for other apps proxied by this host
#     extra_nginx_params:
#       client_max_body_size: 200M

