FROM golang:1.19-alpine AS builder

ENV GOPATH=/root/go

RUN mkdir /workdir
COPY . /workdir
WORKDIR /workdir

RUN go build -ldflags="-X 'main.Version=1.0'" -o postgresql-prometheus-adapter

FROM alpine:3

COPY --from=builder /workdir/postgresql-prometheus-adapter /

EXPOSE 9201

ENTRYPOINT ["/postgresql-prometheus-adapter"]
