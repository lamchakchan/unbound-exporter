# Build container
FROM golang:latest

ENV WORK_DIR=/opt/app
WORKDIR $WORK_DIR

RUN git clone https://github.com/letsencrypt/unbound_exporter.git $WORK_DIR
RUN go get -d ./...
RUN CGO_ENABLED=0 GOOS=linux go build --ldflags '-extldflags "-static"' -o unbound_exporter
RUN strip unbound_exporter

# Release container
FROM alpine:latest

ENV WORK_DIR=/opt/app
WORKDIR $WORK_DIR
COPY --from=0 $WORK_DIR/unbound_exporter .

EXPOSE 9167
ENTRYPOINT [ "./unbound_exporter" ]
