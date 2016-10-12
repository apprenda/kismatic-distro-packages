#!/bin/bash
set -e

docker run \
  -v $(pwd)/build/rpms/:/rpms/ \
  -v /Users/dkoshkin/credentials:/root/.aws/credentials \
  kismatic/rpm \
  /bin/bash -c "/root/publish_rpms.sh -s /rpms -t kismatic-repo-test"
