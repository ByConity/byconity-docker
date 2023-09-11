BYCONITY_SOURCE=${HOME}/ck/ByConity
BUILD_TYPE="Release"
CMAKE_FLAGS=""

pull:
	docker pull byconity/debian-builder
	docker pull byconity/debian-runner

compile: pull
	docker run --rm \
	--privileged --cap-add SYS_PTRACE \
	-v ~/.m2:/root/.m2 \
	-v ${BYCONITY_SOURCE}:/root/ByConity \
	-e BUILD_TYPE=${BUILD_TYPE} -e CMAKE_FLAGS=${CMAKE_FLAGS} \
	-it byconity/debian-builder bash /build.sh

build:
	DOCKER_BUILDKIT=1 docker build -t byconity/byconity -f Dockerfile ${BYCONITY_SOURCE}

release:
	docker tag byconity/byconity byconity/byconity:$(tag)
	docker push byconity/byconity:$(tag)
