# Makefile

.PHONY: build test clean build-all

build:
	go build -o pdf-anhang-extraktor ./cmd/extract

build-all:
	@echo "Building for all platforms..."
	@chmod +x build.sh
	@./build.sh

test:
	go test ./internal/... -v

clean:
	go clean
	rm -f pdf-anhang-extraktor
	rm -rf builds/

install-deps:
	go mod tidy
	go mod download

# Quick build for current platform
quick:
	go build -ldflags="-s -w" -o pdf-extraktor ./cmd/extract

# Development build with race detection
dev:
	go build -race -o pdf-extraktor-dev ./cmd/extract