#!/bin/bash

MIRROR=https://ftp.kaist.ac.kr/gnu
NAME=gcc
VERSION=11.2.0
TARGET=x86_64-pc-linux
PREFIX=/usr/cross
BINPREFIX=odf-

# pre

./pre.sh
# Get Binutils
wget $MIRROR/$NAME/$NAME-$VERSION/$NAME-$VERSION.tar.gz -O $NAME.tar.gz
# Untar
tar -xvzf $NAME.tar.gz

# cd
pushd $NAME-$VERSION
mkdir build
pushd build
# configure
#
../configure --target=$TARGET \
             --prefix=$PREFIX \
             --program-prefix=$BINPREFIX \
             --enable-languages=c \
             --without-headers \
             --disable-multilib

# build
make all-gcc -j$(nproc)
make all-target-libgcc -j$(nproc)
sudo make install-gcc -j$(nproc)
sudo make install-target-libgcc -j$(nproc)

# check result

echo "====== Install finished. Check your result ======"
/usr/cross/bin/${BINPREFIX}gcc --version 
echo "================================================="
