FROM golang:1.22 AS BuildStage

WORKDIR /app

COPY . .

RUN go mod download
RUN go build -o /fitlib ./cmd

FROM scratch
COPY --from=0 /fitlib /bin/fitlib
CMD ["/bin/fitlib"]
