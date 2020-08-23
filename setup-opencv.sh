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

apt-get update -qq
apt-get upgrade -qq

echo
echo "----------------"
echo "Purging unneeded libraries"
echo "----------------"
echo
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

apt-get -y install build-essential cmake git unzip pkg-config
apt-get -y install libjpeg-dev libpng-dev libtiff-dev
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev
apt-get -y install libgtk2.0-dev libcanberra-gtk*
apt-get -y install libxvidcore-dev libx264-dev libgtk-3-dev
apt-get -y install python3-dev python3-numpy python3-pip
apt-get -y install python-dev python-numpy
apt-get -y install libtbb2 libtbb-dev libdc1394-22-dev
apt-get -y install libv4l-dev v4l-utils
apt-get -y install libjasper-dev libopenblas-dev libatlas-base-dev libblas-dev
apt-get -y install liblapack-dev gfortran
apt-get -y install gcc-arm*
apt-get -y install protobuf-compiler

echo
echo "-----------------------"
echo "Installing more dependencies"
echo "-----------------------"
echo

cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.4.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.4.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

mv opencv-4.4.0 opencv
mv opencv_contrib-4.4.0 opencv_contrib

echo
echo "-----------------------"
echo "Begin Compile OpenCV"
echo "-----------------------"
echo

cd ~/opencv/
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
        -D ENABLE_NEON=ON \
        -D ENABLE_VFPV3=ON \
        -D WITH_OPENMP=ON \
        -D BUILD_TIFF=ON \
        -D WITH_FFMPEG=ON \
        -D WITH_GSTREAMER=ON \
        -D WITH_TBB=ON \
        -D BUILD_TBB=ON \
        -D BUILD_TESTS=OFF \
        -D WITH_EIGEN=OFF \
        -D WITH_V4L=ON \
        -D WITH_LIBV4L=ON \
        -D WITH_VTK=OFF \
        -D OPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D BUILD_NEW_PYTHON_SUPPORT=ON \
        -D BUILD_opencv_python3=TRUE \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D BUILD_EXAMPLES=OFF ..

echo
echo "-----------------------"
echo "Updaating Swap Space Size"
echo "to use all 4 cores."
echo "-----------------------"
echo

sed -i -e 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start

echo
echo "-----------------------"
echo "Final OpenCV Compile"
echo "-----------------------"
echo

make -j4
make install
sudo ldconfig
sudo apt-get update

echo
echo "-----------------------"
echo "Reverting Swap Space Size"
echo "-----------------------"
echo

# replace CONF_SWAPSIZE from 100 to 1024 in the `/etc/dphys-swapfile` file.
sed -i -e 's/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start


echo
echo "-----------------------"
echo "Removing zip files and cleanup"
echo "-----------------------"
echo

cd ~
rm opencv.zip
rm opencv_contrib.zip

echo
echo "-----------------------"
echo "Instalation done, Checking Instalation"
echo "-----------------------"
echo

python -c "import cv2; print(cv2.__version__)"
python2 -c "import cv2; print(cv2.__version__)"


echo
echo "-----------------------"
echo "Do you see a version number or an error? Otherwise you might need to reboot"
echo "Instalation done, reboot the raspberry"
echo "-----------------------"
echo