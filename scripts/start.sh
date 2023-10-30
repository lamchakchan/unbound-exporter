#!/usr/bin/env sh

if [ ! -z "$LISTEN_PORT" ]; then
  if [ ! -z "$LISTEN_HOST" ]; then
    LISTEN_ADDRESS_ARG="-web.listen-address $LISTEN_HOST:$LISTEN_PORT"
  else
    LISTEN_ADDRESS_ARG="-web.listen-address :$LISTEN_PORT"
  fi
fi

if [ ! -z "$UNBOUND_HOST" ]; then
  UNBOUND_HOST_ARG="-unbound.host $UNBOUND_HOST"
fi

if [ ! -z "$KEY" ]; then
  KEY_ARG="-unbound.ca $KEY"
fi

if [ ! -z "$CA" ]; then
  CA_ARG="-unbound.ca $CA"
fi

if [ ! -z "$CERT" ]; then
  CERT_ARG="-unbound.cert $CERT"
fi

if [ ! -z "$TELEMETRY_PATH" ]; then
  TELEMETRY_PATH_ARG="-web.telemetry-path $TELEMETRY_PATH"
fi

# echo "$WORK_DIR/unbound_exporter" "$LISTEN_ADDRESS_ARG" "$UNBOUND_HOST_ARG" "$TELEMETRY_PATH_ARG" "$CA_ARG" "$CERT_ARG" "$KEY_ARG"
exec "$WORK_DIR/unbound_exporter" "$LISTEN_ADDRESS_ARG" "$UNBOUND_HOST_ARG" "$TELEMETRY_PATH_ARG" "$CA_ARG" "$CERT_ARG" "$KEY_ARG"