
.phony: build

build:
	rm -rf zfs*
	docker build --no-cache -t zfs-kmod-builder .
	docker run --rm -i -u $(id -u):$(id -g) -v ${PWD}:/work:Z zfs-kmod-builder
