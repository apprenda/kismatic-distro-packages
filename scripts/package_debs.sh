#!/bin/bash
set -e

docker run \
  -v $(pwd)/build/debs/:/debs/ \
  -v /Users/dkoshkin/gpgkeys:/keys/ \
  -v /Users/dkoshkin/credentials:/root/.aws/credentials \
  kismatic/deb \
  /bin/bash -c "gpg --import /keys/public.key; gpg --import /keys/private.key; /root/publish_debs.sh -s /debs -t kismatic-repo-test"
