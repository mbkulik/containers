
.phony: rebuild-all f39-rpm

rebuild-all: f39-container

f39-container:
	podman build -t f39-cros-guest-tools-builder .

f39-rpm:
	@mkdir -p f39/SRPMS
	@mkdir -p f39/RPMS
	podman run -i --rm -v ${PWD}/f39/SRPMS:/root/rpmbuild/SRPMS/:Z \
		-v ${PWD}/f39/RPMS:/root/rpmbuild/RPMS/:Z f39-cros-guest-tools-builder
