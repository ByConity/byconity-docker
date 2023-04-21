FROM byconity/debian:buster-runit-fdb7.1.27

RUN sed -i 's/mirrors.ustc.edu.cn/deb.debian.org/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y binutils gettext-base strace bpftrace sysstat gdb

ARG APP_ROOT=/opt/byconity/

ENV PATH="${PATH}:${APP_ROOT}/bin" \
    LD_LIBRARY_PATH="${APP_ROOT}/lib:${LD_LIBRARY_PATH}" \
    APP_ROOT="${APP_ROOT}"

ADD ./assets /build/
ADD ./clickhouse ${APP_ROOT}/bin/clickhouse

# strip the binary - skip for debug symbols
RUN strip --strip-all ${APP_ROOT}/bin/clickhouse

# install service
RUN mv /build/services/byconity /etc/service

# clean
RUN rm -rf /build && rm -rf /var/lib/apt/lists/*

VOLUME ["${APP_ROOT}/etc/clickhouse-server"]
