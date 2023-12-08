
.phony: alma9-container

alma9-container:
	podman build -t alma9-zfs-kmod-builder . --no-cache

alma9-rpm:
	podman run --rm -i -v ${PWD}:/work:Z alma9-zfs-kmod-builder
