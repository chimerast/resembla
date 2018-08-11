#!/bin/bash

. ./env.sh

cd /build
tar zxf icu4c-59_1-src.tgz

cd /build/icu/source
./configure
make && make install
/sbin/ldconfig
