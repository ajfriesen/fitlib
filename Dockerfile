FROM alpine
ENTRYPOINT ["/usr/bin/fitlib"]
COPY fitlib /usr/bin/fitlib
