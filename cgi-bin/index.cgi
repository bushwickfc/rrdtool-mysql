#!/opt/bin/rrdcgi
<html>
  <head>
    <title>MySQL uptime</title>
  </head>
  <body>
    <p>
      <RRD::GRAPH <RRD::CV::PATH RRD_NAME>.png
        -u 1.1
        --title "Stats For MySQL"
        --width=800 --height=200
        DEF:alive=<RRD::CV::PATH RRD_NAME>.rrd:alive:MIN
        CDEF:a0red=alive,1,LT,1,alive,IF
        CDEF:a1green=alive,1,GE
        LINE1:a0red#FF0000:"MySQL Unavailabile"
        LINE1:a1green#00FF00:"MySQL Availabile"
      >
  </body>
</html>
