.PHONY: all

all: build test docker dockerbuild dockertest

build:
	swift build

test:
	swift test

docker:
	docker build . -t ppswift:latest

dockertest:
	docker run -v "`pwd`":/app ppswift:latest

dockerbuild:
	docker run -v "`pwd`":/app ppswift:latest swift build		
