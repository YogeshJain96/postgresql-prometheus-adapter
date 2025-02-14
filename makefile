VERSION=1.1

SOURCES:=$(shell find . -name '*.go'  | grep -v './vendor')

TARGET:=postgresql-prometheus-adapter

.PHONY: all clean build docker-image docker-push test prepare-for-docker-build

all: $(TARGET) 

build: $(TARGET)

$(TARGET): main.go $(SOURCES)
	go build -ldflags="-X 'main.Version=${VERSION}'" -o $(TARGET)

image: 
	 docker build . -t pg-prom-adapter:${VERSION} -f Dockerfile

clean:
	rm -f *~ $(TARGET)

