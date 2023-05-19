FROM byconity/byconity-base

ARG APP_ROOT=/opt/byconity/

ENV PATH="${PATH}:${APP_ROOT}/bin" \
    LD_LIBRARY_PATH="${APP_ROOT}/lib:${LD_LIBRARY_PATH}" \
    APP_ROOT="${APP_ROOT}"

ADD ./assets /build/
ADD ./clickhouse ${APP_ROOT}/bin/clickhouse

# create symlink
RUN ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/clickhouse-server \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/clickhouse-worker \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/clickhouse-client \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/tso-server \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/tso_server \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/daemon-manager \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/daemon_manager \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/resource-manager \
    && ln -s ${APP_ROOT}/bin/clickhouse ${APP_ROOT}/bin/resource_manager

# install service
RUN mv /build/services/byconity /etc/service

# clean
RUN rm -rf /build && rm -rf /var/lib/apt/lists/*

VOLUME ["${APP_ROOT}/etc/clickhouse-server"]
