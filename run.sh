#!/bin/bash

# Start the Shiny app
# exec shiny-server --pidfile=/var/run/shiny-server.pid 2>&1

# Open server
if [ -z "$1" ]; then
  PORT=3838
else
  PORT="$1"
fi
R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = ${PORT}, launch.browser = FALSE)"
