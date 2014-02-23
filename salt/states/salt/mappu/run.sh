#!/bin/bash

# adapt paths
export NODE_APP_CONTEXT="/mapsocial"
export NODE_DB_URL="postgres://pg_{{ctx_name}}:{{ctx_dbpassword}}@localhost/db_{{ctx_name}}"
export NODE_COOKIE_SECRET={{ctx_cookiesecret}}
export PORT={{ctx_port}}

cd /opt/mapsocial/
/usr/bin/node /opt/mapsocial/app.js 2>&1| /usr/bin/logger -t node_{{ctx_name}}

