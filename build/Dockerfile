FROM cr-bh-cn-beijing.cr.volces.com/byconity/debian:buster-runit

ARG APP_ROOT=/opt/byconity
ARG SCM_REPO=dp/cnch/debian_base_clang
ARG SCM_VERSION=2.0.0.115

ENV PATH="${PATH}:${APP_ROOT}/bin" \
    LD_LIBRARY_PATH="${APP_ROOT}/lib:${LD_LIBRARY_PATH}" \
    APP_ROOT="${APP_ROOT}"

RUN apt-get update && apt-get install -y binutils gettext-base strace bpftrace sysstat gdb

ADD ./assets /build/
RUN /build/build.sh

VOLUME ["${APP_ROOT}/etc/clickhouse-server"]
