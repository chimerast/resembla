#!/bin/bash

. ./env.sh

cd /build/resembla/misc/mecab_dic/unidic
./install-unidic.sh

cd /build/resembla/misc/mecab_dic/mecab-unidic-neologd
./install-mecab-unidic-neologd.sh
