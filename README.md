# Project

This project is intended to provide graphs to display the availability of bushwickfoodcoop's MySQL server. It depends on rrdtool and assumes the scripts are running in a Synology 4.2 environment with ipkg installed.

# Files

## bin/mysqlcheck.sh

**NOTE**: this script was written to run on a synology server, so the paths are hard set to match that environment

A Bourne shell script, meant to be run from cron every minute. If you need to specify a directory for the .rrd files, it should be the first arguement to the script.
To use the script, you'll need to set the environment variable BFC_PASSWORD, for the bfc user.

    * * * * * sh /path/to/mysqlcheck.sh /alternate/path/to/web/root
    
## cgi-bin/index.cgi

**NOTE**: this script was written to run on a synology server, so the paths are hard set to match that environment

Output for rddcgi, which is expected to be in /opt/bin/rrdcgi. The only query parameter to the script is RRD_NAME, which should match the name of an .rrd file.

    curl http://localhost/index.cgi?RRD_NAME=mysqld
    
### Prerequisites

Create the .rrd file in the same directory as the cgi script, ie

    cd /alternate/path/to/web/root
    rrdtool create mysqld.rrd --step 60 --start `date +%s` DS:alive:GAUGE:61:0:1 RRA:AVERAGE:0.5:5:864 RRA:MIN:0.5:5:864

## html/index.html

An iframe for connecting to pcpcpc.synology.me, useful for sticking somewhere in db.buschwickfoodcoop.org.

## test/setup.sh

Used to setup a proof of concept. It will randomly distribute positive and negative hits across a database and generate pngs for AVERAGE, MINIMUM, and MAXIMUM targets.
