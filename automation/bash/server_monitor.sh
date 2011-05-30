#!/bin/bash
####################################################
# The script checks if servers are down
# Sends an e-mail if they are.
# Install it as a cron-job.
# 
# Author: Stein Inge Morisbak (stein.inge.morisbak@BEKK.no)
#
hostname=`hostname`
ports=( "9000" )
for port in ${ports[@]}
do
  PID=`ps ax -o pid,command | grep "no.bekk.roots.RootsServer $port" \
       | grep -v grep | sed -re 's/^\s*([0-9]+)\s+.*$/\1/'`
  if [ ! "$PID" ]; then
    echo "Sever $hostname:$port is down." | mail -s "Server $hostname:$port is down (eom)" "stein.inge.morisbak@BEKK.no"
  fi
done
