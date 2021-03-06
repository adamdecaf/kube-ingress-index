VERSION := $(shell grep -Eo '(\d\.\d\.\d)(-dev)?' main.go | head -n1)

.PHONY: build deps docker

build:
	go fmt ./...
	go vet ./...
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o bin/kube-ingress-ingex-darwin .
	CGO_ENABLED=0 GOOS=linux  GOARCH=amd64 go build -o bin/kube-ingress-ingex-linux .

deps:
	dep ensure -update

docker: build
	docker build -t banno/kube-ingress-index:$(VERSION) -f Dockerfile .
