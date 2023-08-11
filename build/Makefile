image_push:
	docker push byconity/byconity:latest
image_release:
	docker tag byconity/byconity:latest byconity/byconity:stable
	docker push byconity/byconity:stable
image_check:
	docker run --rm -it byconity/byconity /bin/bash
