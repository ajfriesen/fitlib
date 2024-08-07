FROM golang:1.22-alpine AS build

ENV GOCACHE=/go/cache

RUN apk add \
    # Important: required for go-sqlite3
    gcc \
    # Required for Alpine
    musl-dev 

ENV CGO_ENABLED=1
WORKDIR /app

COPY go.mod go.sum /app/
RUN go mod download
RUN go mod verify
COPY . .
RUN go build -v -o /fitlib ./cmd

FROM alpine:3.20.2
COPY --from=build /fitlib /fitlib
CMD ["/fitlib"]
