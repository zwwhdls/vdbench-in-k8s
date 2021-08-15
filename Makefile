
IMAGE=zwwhdlsdocker/vdbench
REGISTRY=docker.io

.PHONY: image
image:
	docker build -t $(IMAGE):latest -f Dockerfile .
	docker push $(REGISTRY)/$(IMAGE):latest
