#!/opt/bin/bash
now=`date +%s`
yesterday=$((now-(86400*3)))
t=$yesterday
rrd=mysqld.rrd

echo now $now
echo yesterday $yesterday

if [ ! -f $rrd ]; then 
  rrdtool create $rrd --step 60 --start $yesterday \
    DS:alive:GAUGE:60:0:1 \
    RRA:AVERAGE:0.5:5:864 \
    RRA:MIN:0.5:5:864 \
    RRA:MAX:0.5:5:864

  skip=0
  while [ $t -le $now ]; do
    if [ $skip -gt 0 ]; then
      skip=$((skip-1))
      r=100
    else
      r=$((RANDOM%100))
    fi
    #echo $r
    case $r in
    0)
      rrdtool update $rrd $t:0
      t=$((t+60))
      skip=59
    ;;
    1)
      rrdtool update $rrd $t:0
      rrdtool update $rrd $((t+60)):0
      t=$((t+(60*3)))
      skip=57
    ;;
    2)
      rrdtool update $rrd $((t+2)):0
      rrdtool update $rrd $((t+60+4)):0
      t=$((t+(60*3)))
      skip=57
    ;;
    3)
      rrdtool update $rrd $((t+30)):0
      rrdtool update $rrd $((t+(60*2)+60)):0
      t=$((t+(60*4)))
      skip=56
    ;;
    4)
      rrdtool update $rrd $t:0
      rrdtool update $rrd $((t+(60*2))):0
      rrdtool update $rrd $((t+(60*3))):0
      rrdtool update $rrd $((t+(60*4))):0
      t=$((t+(60*5)))
      skip=55
    ;;

    5)
      rrdtool update $rrd $t:0
      rrdtool update $rrd $((t+(60*2))):0
      rrdtool update $rrd $((t+(60*3))):0
      rrdtool update $rrd $((t+(60*4))):0
      rrdtool update $rrd $((t+(60*5))):0
      t=$((t+(60*6)))
      skip=54
    ;;

    6)
      rrdtool update $rrd $t:0
      rrdtool update $rrd $((t+(60*2))):0
      rrdtool update $rrd $((t+(60*3))):0
      rrdtool update $rrd $((t+(60*4))):0
      rrdtool update $rrd $((t+(60*5))):0
      rrdtool update $rrd $((t+(60*6))):0
      rrdtool update $rrd $((t+(60*7))):0
      rrdtool update $rrd $((t+(60*8))):0
      rrdtool update $rrd $((t+(60*9))):0
      rrdtool update $rrd $((t+(60*10))):0
      rrdtool update $rrd $((t+(60*11))):0
      rrdtool update $rrd $((t+(60*12))):0
      t=$((t+(60*13)))
      skip=47
    ;;

    *)
      rrdtool update $rrd $t:1
      t=$((t+60))
    ;;
    esac
  done
fi

rrdtool graph mysqldTEST.png -u 1.1 --width=800 --height=200 \
DEF:ds1=mysqld.rrd:alive:MIN  \
CDEF:ds1red=ds1,1,LT \
CDEF:ds1green=ds1,1,GE \
LINE1:ds1green#00CC00:"MySQL Available" \
LINE1:ds1red#CC0000:"MySQL Unavailable"

rrdtool graph mysqldAVG.png --width=800 --height=200 DEF:cel=mysqld.rrd:alive:AVERAGE \
  LINE1:cel#00a000:"MySQL Availability, 1=yes 0=no"
  
rrdtool graph mysqldMIN.png --width=800 --height=200 DEF:cel=mysqld.rrd:alive:MIN \
  LINE1:cel#00a000:"MySQL Availability, 1=yes 0=no"
  
rrdtool graph mysqldMAX.png --width=800 --height=200 DEF:cel=mysqld.rrd:alive:MAX \
  LINE1:cel#00a000:"MySQL Availability, 1=yes 0=no"
  
