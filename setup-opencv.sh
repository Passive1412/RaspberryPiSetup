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
