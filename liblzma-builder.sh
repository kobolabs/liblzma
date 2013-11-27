#!/bin/bash

ARCH=$1
CODEGEN=$2
DESTDIR=$3

if [ ! -e $DESTDIR/bin/$ARCH/$CODEGEN/liblzma.a ]; then
	echo building liblzma
	CWD=`pwd`
	rm -rf $DESTDIR/3rdparty/liblzma
	mkdir -p $DESTDIR/3rdparty/liblzma/
	pushd $DESTDIR/3rdparty/liblzma/
	if [ "$ARCH" == "arm" ]; then
		LD=arm-linux-ld CC=arm-linux-gcc $CWD/configure --host=arm-linux 
	elif [ `uname -s` == "Darwin" ]; then
		CC="gcc -arch i386" CXX="g++ -arch i386" $CWD/configure
	else
		$CWD/configure
	fi
	make
	cp -a $DESTDIR/3rdparty/liblzma/src/liblzma/.libs/liblzma*.so* $DESTDIR/3rdparty/liblzma/src/liblzma/.libs/liblzma.a $DESTDIR/bin/$ARCH/$CODEGEN
	popd

fi
