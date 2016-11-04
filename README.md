# Kismatic Distro Packages

[![Build Status](https://snap-ci.com/UCrOoZjLpiJ9te5hUCgFhosqKnGoSycwMvONJhWQ9o4/build_image)](https://snap-ci.com/apprenda/kismatic-distro-packages/branch/master)

This repo is used to build DEB and RPM packages required for [Kismatic Enterprise Toolkit](https://github.com/apprenda/kismatic)

## Versioning
The version number of the distributed packages will correspond the the upstream [Kubernetes](https://github.com/kubernetes/kubernetes) version + the revision number of this repo's build.

## Run Locally
`RPM_REPO=kismatic-rpm-test DEB_REPO=kismatic-deb-test KEYS_PATH=~/gpgkeys CREDENTIALS_PATH=~/credentials make all`
