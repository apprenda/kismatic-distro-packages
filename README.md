# KET Package Release Process

[![Build Status](https://snap-ci.com/UCrOoZjLpiJ9te5hUCgFhosqKnGoSycwMvONJhWQ9o4/build_image)](https://snap-ci.com/apprenda/kismatic-distro-packages/branch/master)

The goal of this document is to describe the process to build, release and consume new Kismatic packages that contain Kubernetes, Calico, Etcd and Docker components required for [Kismatic Enterprise Toolkit](https://github.com/apprenda/kismatic)

https://github.com/apprenda/kismatic-distro-packages

### Assumptions
* The package release process is fully dockerized and it automatically run via SnapCI
* RPM and Deb repositories are backed by AWS S3 buckets.
* RPM and Deb repositories already exist:
	* RPM: [kismatic-packages-rpm](https://console.aws.amazon.com/s3/home?region=us-east-1#&bucket=kismatic-packages-rpm&prefix=)
	* DEB: [kismatic-packages-deb](https://console.aws.amazon.com/s3/home?region=us-east-1#&bucket=kismatic-packages-deb&prefix=)

*If a new package repository needs to be created the existing S3 bucket can be cloned and KET modified to use new URLs*

### Definitions
* **Build**: Create RPM and Deb packages from the required binaries with a specific version
* **Release**: Add the newly built package into the repository, this process is done by tooling that will create configuration files, and update existing files in the repo.
* **Consume**: Modify KET to use newly released package version

## Build
1. Modify `scripts/VARIABLES.sh` with new component versions
  1. `KISMATIC_PACKAGE_VERSION` will have the same format as the `K8S_VERSION` with `-#` where **#** is a number that represents a unique Kismatic build with the provided Kuberntes version (**the first build will always be -1**)
  1. `REQUIRED_RPM_KISMATIC_PACKAGE_VERSION` and `REQUIRED_DEB_KISMATIC_PACKAGE_VERSION` are both required due to the different version formats for RPM and Debian packages
  1. Confirm there are no other version changes required
    1. [Cailco](http://docs.projectcalico.org/)
    1. [KubeDNS](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/dns)
    1. [Dashboard](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/dashboard)

If no other packaging changes are needed run `KEYS_PATH=~/gpgkey make build` to download the new binaries and build RPM and DEB packages locally

Note: RPM packages are signed at build time. DEB packages are not signed, instead the repository itself is

## Release
After packages are built, there will be 2 directories: `package/debs/**.deb` and `package/rpm/***.rpm`
### RPM
1. `s3 sync` is used to clone existing repository from S3 to a local dir
1. `createrepo` is used to add the new RPM packages from `package/rpm/***.rpm`
1. `s3 sync` is used again to sync local dir to S3 bucket with the new packages

### DEB
1. `aptly` is used to mirror existing repository from S3 to a local repository
1. `aptly` is used to add the new DEB packages from `package/debs/**.deb`
1. `aptly` is used to publish local repository to S3 bucket

In both cases, existing repositories are **updated**, meaning the old packages are always preserved

## Consume
1. Update [ansible/group_vars/all.yaml](https://github.com/apprenda/kismatic/blob/master/ansible/group_vars/all.yaml)
1. Update [pkg/inspector/rule/rule_set.go](https://github.com/apprenda/kismatic/blob/master/pkg/inspector/rule/rule_set.go)
1. Update any mentions in Docs

## Run via CI
SnapCI is already configured with the required ENV variables to build and publish packages to the S3 buckets on every commit
* For production: `master` branch - [SnapCI](https://snap-ci.com/apprenda/kismatic-distro-packages/branch/master) will clone the repo, but the **publish step needs to be triggered manually in Snap**
* For development: `dev` branch - [SnapCI](https://snap-ci.com/apprenda/kismatic-distro-packages/branch/dev) will clone the repo and build and publish packages automatically

## Run Locally
`RPM_REPO=kismatic-packages-rpm-test DEB_REPO=kismatic-packages-deb-test KEYS_PATH=~/gpgkeys CREDENTIALS_PATH=~/credentials make all`  
* `kismatic-$$$-test` is a staging repo and is not used in production
* `KEYS_PATH` contains `priate.key` and `public.key` used for signing the packages
* `CREDENTIALS_PATH` are the AWS credentials where S3 buckets with `RPM_REPO` and `DEB_REPO` already exist

## Recommended Release Workflow
* Checkout `dev` branch
* Make any version or packaging changes
* Commit to trigger a new SnapCI build for the staging repo
* Create a new KET pre-release PR with the new package versions, any Ansible changes, and repo URLs with the staging repo
* Run integration tests until succeeded
* Merge `dev` branch into `master` branch in this repo
* Trigger SnapCI build for the production repo (having new package versions in the repos will NOT affect existing KET packages since all versions are set)
* Modify repo URLs to point to production
* Run integration tests until succeeded
* Merge KET PR
* Release a new version of KET
