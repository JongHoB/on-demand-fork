#!/bin/bash

MIRROR=https://ftp.kaist.ac.kr/gnu
NAME=binutils
VERSION=2.38
TARGET=x86_64-pc-linux
PREFIX=/usr/cross
BINPREFIX=odf-

# Pre-require

./pre.sh

# Get Binutils
wget $MIRROR/$NAME/$NAME-$VERSION.tar.gz -O $NAME.tar.gz
# Untar
tar -xvzf $NAME.tar.gz

# cd
pushd $NAME-$VERSION
mkdir build
pushd build
# configure
../configure --target=$TARGET \
             --prefix=$PREFIX \
             --program-prefix=$BINPREFIX \
             --with-sysroot \
             --disable-nls \
             --disable-werror
# build
make -j$(nproc)
sudo make install -j$(nproc)

# check result

echo "====== Install finished. Check your result ======"
/usr/cross/bin/${BINPREFIX}ld --help | grep "supported "
echo "================================================="
