FROM byconity/byconity-base

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
