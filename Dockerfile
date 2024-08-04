FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod go.sum /app/

RUN go mod download
RUN go mod verify

COPY . .

RUN go build -v -o /fitlib ./cmd

FROM scratch
COPY --from=build /fitlib /fitlib
CMD ["/fitlib"]
