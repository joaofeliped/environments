#!/bin/bash

if [[ "$EUID" = 0 ]]; then
  echo "Starting environment install on debian 10"
  
  if [ ! -z "$1" ] && [ $1 == "-adduser" ] ; then
    echo "Wich username?"
    read name

    sudo adduser name
  fi
  
  echo "Installing Google Chrome"
  echo "Installing Wifi Atheros"
  echo "Installing Terminator"
  
  echo "Installing Development Enviroment"

  echo "Done"
else
  echo "Must run with root"
  exit 1
fi
