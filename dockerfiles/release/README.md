# Release

Modify the Makefile, set `BYCONITY_SOURCE` to the path of the ByConity project.

Build the release binary with
```bash
make compile
```

Build the docker image with
```bash
make build
```

Push the docker image to dockerhub with
```bash
make release tag='latest'
```