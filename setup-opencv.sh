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

if [ "armv7l" not in "$(uname -a)" ]; then
    echo "Sorry, this script must be executed on a 32 bit system"
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
apt-get -y remove --purge bluej
apt-get -y remove --purge claws-mail*
apt-get -y remove --purge greenfoot*
apt-get -y remove --purge libreoffice
apt-get -y remove --purge wolfram-engine
apt-get -y remove --purge python-minecraftpi
apt-get -y remove --purge minecraft-pi
apt-get -y remove --purge nodered
apt-get -y remove --purge scratch
apt-get -y remove --purge scratch2
apt-get -y remove --purge scratch3
apt-get -y remove --purge smartsim
apt-get -y remove --purge sonic-pi
apt-get -y clean
apt-get -y autoremove

echo
echo "----------------"
echo "Update & Upgrade"
echo "----------------"
echo

apt-get -y update
apt-get -y upgrade

echo
echo "-----------------------"
echo "Installing dependencies"
echo "-----------------------"
echo

apt-get install build-essential cmake git unzip pkg-config
apt-get install libjpeg-dev libpng-dev libtiff-dev
apt-get install libavcodec-dev libavformat-dev libswscale-dev
apt-get install libgtk2.0-dev libcanberra-gtk*
apt-get install libxvidcore-dev libx264-dev libgtk-3-dev
apt-get install python3-dev python3-numpy python3-pip
apt-get install python-dev python-numpy
apt-get install libtbb2 libtbb-dev libdc1394-22-dev
apt-get install libv4l-dev v4l-utils
apt-get install libjasper-dev libopenblas-dev libatlas-base-dev libblas-dev
apt-get install liblapack-dev gfortran
apt-get install gcc-arm*
apt-get install protobuf-compiler


