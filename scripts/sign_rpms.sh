#!/bin/bash
set -e

docker run \
  -v $(pwd)/build/rpms:/rpms/ \
  -v /Users/dkoshkin/gpgkeys:/keys/ \
  kismatic/fpm \
  /bin/bash -c "gpg --import /keys/public.key gpg --import /keys/private.key; cd /root/ && ./rpm-sign.exp /rpms/*.rpm"
