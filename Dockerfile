FROM golang:1.22 AS build

ENV CGO_ENABLED=0
WORKDIR /app

COPY go.mod go.sum /app/
RUN go mod download
RUN go mod verify
COPY . .
RUN go build -v -o /fitlib ./cmd

FROM scratch
COPY --from=build /fitlib /fitlib
CMD ["/fitlib"]
