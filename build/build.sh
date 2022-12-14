#!/bin/bash

set -ex

# install
apt update
apt install -y strip

mkdir -p "${APP_ROOT}"
curl --retry 3 "http://d.scm.byted.org/api/v2/download/ceph:$(echo "${SCM_REPO}" | sed "s/\//./g")_${SCM_VERSION}.tar.gz" | tar -xz -C "${APP_ROOT}"

# strip the binary
strip ${APP_ROOT}/bin/clickhouse*

# clean
rm -rf /build
rm -rf /var/lib/apt/lists/*
