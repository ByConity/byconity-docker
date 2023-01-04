#!/bin/bash

set -ex

# install
apt update
apt install -y binutils curl tar

mkdir -p "${APP_ROOT}"
curl --retry 3 "http://d.scm.byted.org/api/v2/download/ceph:$(echo "${SCM_REPO}" | sed "s/\//./g")_${SCM_VERSION}.tar.gz" | tar -xz -C "${APP_ROOT}"

# remove unnecessary files
rm -rf ${APP_ROOT}/bin/clickhouse-library-bridge
rm -rf ${APP_ROOT}/bin/clickhouse-odbc-bridge

# strip the binary - skip for debug symbols
strip --strip-all ${APP_ROOT}/bin/clickhouse
strip --strip-all ${APP_ROOT}/lib/libfdb_c.so

# clean
rm -rf /build
rm -rf /var/lib/apt/lists/*
