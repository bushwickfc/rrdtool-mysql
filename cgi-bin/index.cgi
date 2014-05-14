#!/opt/bin/rrdcgi
<html>
  <head>
    <title>MySQL uptime</title>
  </head>
  <body>
    <p>
      <RRD::GRAPH <RRD::CV::PATH RRD_NAME>.png
        --title "Stats For MySQL"
        --width=800 --height=200
        DEF:cel=<RRD::CV::PATH RRD_NAME>.rrd:alive:MIN
        LINE1:cel#00a000:"MySQL Availability, 1=yes 0=no">
  </body>
</html>
