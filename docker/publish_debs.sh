#!/bin/bash
# Publishes built DEBs to an s3-backed DEB repo.
if [ ! -z "${DEBUG}" ]; then
  set -x
fi

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SRC_BASE="${SCRIPT_DIR}/../.."

DEPENDENCIES=("aws" "aptly")
REGION="us-east-1"
SOURCE_DIR=""
TARGET_BUCKET=""

for dep in "${DEPENDENCIES[@]}"
do
  if [ ! $(which ${dep}) ]; then
      echo "${dep} must be available."
      exit 1
  fi
done

while getopts "s:t:" opt; do
  case $opt in
    s) SOURCE_DIR=$OPTARG ;;
    t) TARGET_BUCKET=$OPTARG ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "${SOURCE_DIR}" ]; then
  echo "Source directory must be specified."
  exit 1
fi

if [ -z "${TARGET_BUCKET}" ]; then
  echo "Target bucket must be specified."
  exit 1
fi

# modify ~/.aptly.conf
touch ~/.aptly.conf
cat <<EOT >> ~/.aptly.conf
{
   "architectures":[],
   "S3PublishEndpoints":{
      "${TARGET_BUCKET}":{
         "region":"us-east-1",
         "bucket":"${TARGET_BUCKET}",
         "acl":"public-read"
      }
   }
}
EOT

# check if repo alredy exists in S3
GPG_KEY="4C708F2F"
wget https://s3.amazonaws.com/${TARGET_BUCKET}/dists/kismatic-xenial/InRelease
if [ $? -eq 0 ]; then
  set -e
  # mirror and append
  # existing repo
  # mirror repot from S3

  wget -O - https://s3.amazonaws.com/${TARGET_BUCKET}/public.key | gpg --no-default-keyring --keyring trustedkeys.gpg --import
  aptly mirror create ${TARGET_BUCKET} https://s3.amazonaws.com/${TARGET_BUCKET}/ kismatic-xenial
  aptly mirror update ${TARGET_BUCKET}
  # create local repo
  aptly repo create -distribution=kismatic-xenial ${TARGET_BUCKET}
  # import existing packages
  aptly repo import ${TARGET_BUCKET} ${TARGET_BUCKET} etcd transition-etcd kubelet kubectl docker-engine kismatic-docker-engine kismatic-etcd kismatic-kubernetes-master kismatic-kubernetes-networking kismatic-kubernetes-node kismatic-offline
  # add new packages
  # -force-replace could cause errors in yum or apt-get
  aptly repo add -force-replace ${TARGET_BUCKET} $SOURCE_DIR
  # push to S3
  aptly publish repo -gpg-key=${GPG_KEY} -force-overwrite ${TARGET_BUCKET} s3:${TARGET_BUCKET}:
else
  set -e
  # new repo
  # create local repo
  aptly repo create -distribution=kismatic-xenial ${TARGET_BUCKET}
  aptly repo add ${TARGET_BUCKET} $SOURCE_DIR
  # push to S3
  aptly publish repo -gpg-key=${GPG_KEY} ${TARGET_BUCKET} s3:${TARGET_BUCKET}:
fi
