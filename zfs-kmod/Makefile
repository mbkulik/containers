
.phony: container

container:
	podman build -t zfs-kmod-builder -f Containerfile --no-cache

rpm:

	podman run --rm -i -v ${PWD}:/work:Z zfs-kmod-builder
