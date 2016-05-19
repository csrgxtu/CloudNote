#!/bin/bash
while true
do
  if ps ax | grep -v grep | grep autossh > /dev/null
  then
    echo "autossh service running, everything is fine"
  else
    echo "autossh is not running"
  fi
  sleep 60
done
