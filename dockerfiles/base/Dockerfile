# Download stage
FROM alpine as downloader
WORKDIR /downloads
RUN apk --no-cache add wget
RUN wget -qO cmake.3.17.tar.gz https://cmake.org/files/v3.17/cmake-3.17.0-Linux-x86_64.tar.gz
RUN wget -q https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh
RUN wget -qO foundationdb-clients.deb https://github.com/apple/foundationdb/releases/download/7.1.27/foundationdb-clients_7.1.27-1_amd64.deb
# RUN wget https://apt.llvm.org/llvm.sh

FROM debian:11.6 as builder
LABEL description="Debian image for compiling"
LABEL org.opencontainers.image.source="https://github.com/ByConity/ByConity"
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y \
    binutils gettext-base strace bpftrace sysstat gdb maven default-jdk ninja-build \
    lsb-release wget curl software-properties-common gnupg ccache git vim

COPY --from=downloader /downloads /downloads
WORKDIR /downloads
RUN tar --strip-components=1 -xzf cmake.3.17.tar.gz -C /usr/local && rm cmake.3.17.tar.gz
RUN chmod +x llvm.sh && ./llvm.sh 11 -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt && rm llvm.sh
RUN dpkg -i foundationdb-clients.deb && rm foundationdb-clients.deb

ARG APP_ROOT=/root/ByConity/
ENV APP_ROOT="${APP_ROOT}"
WORKDIR ${APP_ROOT}

COPY build.sh /
RUN chmod +x /build.sh

ENV JAVA_HOME=/usr/lib/jvm/default-java
RUN echo "/usr/lib/jvm/default-java/lib" >> /etc/ld.so.conf.d/libjvm.conf
RUN echo "/usr/lib/jvm/default-java/lib/server" >> /etc/ld.so.conf.d/libjvm.conf
RUN ldconfig

ENV CC=clang-11
ENV CXX=clang++-11
ENV PATH="${PATH}:/opt/byconity/bin"
ENV PATH="${PATH}:/opt/local/bin"

# clean
RUN rm -rf /var/lib/apt/lists/*

FROM debian:11.6-slim as runner
LABEL description="Debian image for runtime"
LABEL org.opencontainers.image.source="https://github.com/ByConity/ByConity"

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y \
    binutils gettext-base strace bpftrace sysstat gdb curl default-jdk

COPY --from=downloader /downloads /downloads
WORKDIR /downloads
RUN dpkg -i foundationdb-clients.deb && rm foundationdb-clients.deb
RUN rm -rf /download

ENV JAVA_HOME=/usr/lib/jvm/default-java
RUN echo "/usr/lib/jvm/default-java/lib" >> /etc/ld.so.conf.d/libjvm.conf
RUN echo "/usr/lib/jvm/default-java/lib/server" >> /etc/ld.so.conf.d/libjvm.conf
RUN ldconfig

ENV PATH="${PATH}:/opt/byconity/bin"
ENV PATH="${PATH}:/opt/local/bin"

RUN rm -rf /var/lib/apt/lists/*