#!/bin/bash
while true
do
  if ps ax | grep -v grep | grep autossh > /dev/null
  then
    echo "autossh service running, everything is fine"
  else
    autossh -fNR 8888:localhost:22 archer@115.28.70.69
    echo "autossh is not running"
  fi
  sleep 60
done
