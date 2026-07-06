
.phony: build clean

build: clean
	docker build --no-cache -t zfs-kmod-builder .
	docker run --rm -i -u $(id -u):$(id -g) -v ${PWD}:/work:Z zfs-kmod-builder

clean:
	sudo rm -rf zfs*
