# ByConity dev-env image

## Download the image
```
docker pull {image_name}
```

## How to use
```bash
git clone byconity-repo

docker run -it -p 2222:2222 \
  --privileged \
  --cap-add SYS_PTRACE \
  -v ~/.m2:/root/.m2 \
  -v ~/ck/ByConity:/root/ByConity \
  --name byconity-dev \
  -d byconity/debian-builder

docker exec -it byconity-dev /bin/bash
```

Build Debian builder
```bash
DOCKER_BUILDKIT=1 docker build -t byconity/debian-builder \
  --build-arg http_proxy="${http_proxy}" \
  --build-arg https_proxy="${https_proxy}" \
  --target builder .
```

Build Debian runner
```bash
DOCKER_BUILDKIT=1 docker build -t byconity/debian-runner \
  --build-arg http_proxy="${http_proxy}" \
  --build-arg https_proxy="${https_proxy}" \
  --target runner .
```

