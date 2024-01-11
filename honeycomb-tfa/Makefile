.phony: container tfa

container:
	podman build -t honeycomb-tfa .

tfa:
	@mkdir -p tfa
	podman run -i --rm -v ${PWD}/tfa:/root/src/:Z honeycomb-tfa
