FROM debian:10

ARG APP_ROOT=/opt/byconity
ARG SCM_REPO=dp/cnch/debian_base_clang
ARG SCM_VERSION=2.0.0.67

ENV PATH="${PATH}:${APP_ROOT}/bin" \
    LD_LIBRARY_PATH="${APP_ROOT}/lib:${LD_LIBRARY_PATH}" \
    APP_ROOT="${APP_ROOT}"

ADD ./build.sh /build.sh
RUN /build.sh

VOLUME ["${APP_ROOT}/etc/clickhouse-server"]
