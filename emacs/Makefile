
.phony: rebuild-all f37-rpm f38-rpm f39-rpm

rebuild-all: f37-container f38-container f39-container

f37-container:
	podman build --from fedora:37 -t f37-emacs-builder . --no-cache

f38-container:
	podman build --from fedora:38 -t f38-emacs-builder . --no-cache

f39-container:
	podman build -t f39-emacs-builder . --no-cache

f37-rpm:
	@mkdir - p f37
	podman run -i --rm -v ${PWD}/f37:/root/rpmbuild/RPMS:Z f37-emacs-builder

f38-rpm:
	@mkdir -p f38
	podman run -i --rm -v ${PWD}/f38:/root/rpmbuild/RPMS:Z f38-emacs-builder

f39-rpm:
	@mkdir -p f39
	podman run -i --rm -v ${PWD}/f39:/root/rpmbuild/RPMS:Z f39-emacs-builder
