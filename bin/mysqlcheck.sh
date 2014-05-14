#!/bin/sh
set -e
time=`date +%s`
cd ${1:-/volume1/@tmp}
/usr/syno/mysql/bin/mysqladmin -h viewsic.mayfirst.org -u bfc --password="${BFC_PASSWORD:?missing password}" ping | grep -q alive
[[ $? -ne 0 ]]
ret=$?
for file in *.rrd; do
  /opt/bin/rrdtool update $file $time:$ret
done
