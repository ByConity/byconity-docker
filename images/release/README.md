# Release

## 1. Prepare binary
```bash
export BUILD_TYPE="Release" VERSION_SCM="0.2.0" CMAKE_FLAGS=""

docker run --rm \
  --privileged --cap-add SYS_PTRACE \
  -v ~/.m2:/root/.m2 \
  -v ~/ck/ByConity:/root/ByConity \
  -e BUILD_TYPE=${BUILD_TYPE} -e VERSION_SCM=${VERSION_SCM} -e CMAKE_FLAGS=${CMAKE_FLAGS} \
  -it byconity/debian-builder bash /build.sh
```

```bash
DOCKER_BUILDKIT=1 docker build -t byconity/byconity -f Dockerfile ${path/to/byconity}
```