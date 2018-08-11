#!/bin/bash

. ./env.sh

cd /build/grpc
make && make install

cd /build/grpc/third_party/protobuf
make && make install
