#!/bin/bash

. ./env.sh

cd /build/resembla/src
make && make install

cd /build/resembla/src/executable
make && make install
