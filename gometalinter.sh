#!/bin/bash

BINDIR="bin"
GOMETALINTER_VERSION=${GOMETALINTER_VERSION:-"2.0.10"}
GOMETALINTER="bin/gometalinter"
GOMETALINTER_URL="https://github.com/alecthomas/gometalinter/releases/download/v${GOMETALINTER_VERSION}/gometalinter-${GOMETALINTER_VERSION}-linux-amd64.tar.gz"

function download_metalinter() {
  curl -L "$GOMETALINTER_URL" | tar -xz --strip-components 1 --exclude COPYING --exclude README.md -C "${BINDIR}/"
}

if [ ! -d "$BINDIR" ]; then
  mkdir "$BINDIR"
fi

if [ ! -f "$GOMETALINTER" ]; then
  echo "Gometalinter is missing. Downloading..."
  download_metalinter
fi

if "$GOMETALINTER" --version | grep -q "$GOMETALINTER_VERSION"; then
  echo "Gometalinter is outdated. Downloading..."
  download_metalinter
fi


