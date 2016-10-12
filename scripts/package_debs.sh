#!/bin/bash
set -e

docker run \
  -v $(pwd)/build/debs/:/debs/ \
  -v $KEYS_PATH:/keys/ \
  -v $CREDENTIALS_PATH:/root/.aws/credentials \
  kismatic/deb \
  /bin/bash -c "gpg --import /keys/public.key; gpg --import /keys/private.key; /root/publish_debs.sh -s /debs -t $DEB_REPO"
