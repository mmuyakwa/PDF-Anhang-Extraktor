# Makefile

.PHONY: build test clean

build:
	go build -o pdf-anhang-extraktor ./cmd/extract

test:
	go test ./internal/... -v

clean:
	go clean
	rm -f pdf-anhang-extraktor