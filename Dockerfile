##
## builder
##

FROM centos:7 as builder

# install g++ 5.x
RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-4

# install MeCab
RUN rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
RUN yum makecache
RUN yum install -y mecab mecab-ipadic mecab-devel

# install LIBSVM
RUN yum install -y epel-release
RUN yum install -y libsvm-devel

# install some packages
RUN yum install -y git wget sudo openssl

WORKDIR /build

RUN wget 'https://downloads.sourceforge.net/project/icu/ICU4C/59.1/icu4c-59_1-src.tgz?r=http%3A%2F%2Fapps.icu-project.org%2Ficu-jsp%2FdownloadSection.jsp%3Fver%3D59.1%26base%3Dcs%26svn%3Drelease-59-1&ts=1497872621&use_mirror=jaist' -O icu4c-59_1-src.tgz

RUN git clone https://github.com/tuem/resembla.git

RUN git clone -b v1.2.5 https://github.com/grpc/grpc.git
RUN cd /build/grpc && git submodule update --init

ENV LANG en_US.utf8
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

COPY scripts/env.sh .

COPY scripts/install-icu.sh .
RUN ./install-icu.sh

COPY scripts/install-resembla.sh .
RUN ./install-resembla.sh

COPY scripts/install-resembla-optional.sh .
RUN ./install-resembla-optional.sh

COPY scripts/install-grpc.sh .
RUN ./install-grpc.sh

COPY scripts/install-resembla-grpc.sh .
RUN ./install-resembla-grpc.sh



##
## application
##

FROM centos:7

RUN rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm \
  && yum install -y mecab mecab-ipadic \
  && yum install -y epel-release \
  && yum install -y libsvm \
  && rm -rf /var/cache/yum/* \
  && yum clean all

COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /build/resembla/example/grpc/src/resembla_server /usr/local/bin/.

WORKDIR /app

COPY --from=builder /build/resembla/misc/mecab_dic/mecab-unidic-neologd/dic/ ./dic/

COPY --from=builder /build/resembla/example/conf/ ./conf/
COPY --from=builder /build/resembla/example/regression/ ./regression/
COPY --from=builder /build/resembla/misc/icu/ ./icu/

ENV LANG en_US.utf8
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
