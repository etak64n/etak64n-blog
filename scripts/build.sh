#!/usr/bin/env bash
set -euxo pipefail

ZOLA_VERSION="0.19.2"
ZOLA_ARCHIVE="zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"

curl -L -o "${ZOLA_ARCHIVE}" "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/${ZOLA_ARCHIVE}"
tar -xzf "${ZOLA_ARCHIVE}"
./zola build
