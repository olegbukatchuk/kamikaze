#!/usr/bin/env sh
set -euo pipefail
REPO="olegbukatchuk/kamikaze"
INSTALL="install -m 755 -o root kamikaze-download kamikaze && chmod u+s kamikaze"

curl -s "https://api.github.com/repos/${REPO}/releases/latest" \
   | grep "browser_download_url" \
   | cut -d '"' -f 4 \
   | xargs -n1 curl -s -L --output kamikaze-download

trap 'rm kamikaze-download' EXIT

if [[ $(id -u) -ne 0 ]]; then
  sudo sh -c "${INSTALL}"
else
  eval "${INSTALL}"
fi
