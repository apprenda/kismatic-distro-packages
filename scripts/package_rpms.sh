#!/bin/bash
set -e

docker run \
  -v $(pwd)/build/rpms/:/rpms/ \
  -v $CREDENTIALS_PATH:/root/.aws/credentials \
  kismatic/rpm \
  /bin/bash -c "/root/publish_rpms.sh -s /rpms -t $RPM_REPO"
