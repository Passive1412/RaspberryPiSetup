#!/bin/bash

# OpenCV 3 compiler and installer script
#
# This script is specifically created for Raspbian http://www.raspbian.org
# and Raspberry Pi http://www.raspberrypi.org but should work over any
# Debian-based distribution
# Created and mantained by Marcus Jarlbæk Homann3
# Updated for OpenCV 4.4.0 by https://opencv.org

if [ "$(whoami)" != "root" ]; then
    echo "Sorry, this script must be executed with sudo or as root"
    exit 1
fi

echo
echo "----------------"
echo "Updating and upgrading sources"
echo "----------------"
echo

#apt-get update -qq
#apt-get upgrade -qq

#echo
#echo "----------------"
#echo "Purging unneeded libraries"
#echo "----------------"
#echo
#apt-get -y purge jluej
#apt-get -y purge claws-mail
#apt-get -y purge greenfoot
#apt-get -y purge libreoffice*
apt-get -y purge mathematica
apt-get -y purge minecraft
apt-get -y purge Node-RED
apt-get -y purge Node-Scratch
apt-get -y purge Node-Strach2
apt-get -y purge Sense SmartSim
#apt-get -y purge Sense Sonic Pi
#apt-get -y purge wolfram-engine
#apt-get -y clean
#apt-get -y autoremov


echo
echo "----------------"
echo "Update & Upgrade"
echo "----------------"
echo

#apt-get -y update
#apt-get -y upgrade

echo
echo "-----------------------"
echo "Installing dependencies"
echo "-----------------------"
echo


