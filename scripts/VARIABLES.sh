#!/bin/bash

# versions
#TODO autoincrement?
KISMATIC_PACKAGE_VERSION=1.4.3-6
REQUIRED_RPM_KISMATIC_PACKAGE_VERSION=1.4.3_6-1
REQUIRED_DEB_KISMATIC_PACKAGE_VERSION=1.4.3_6-1 #TODO fix deb versions
K8S_VERSION=1.4.3
DOCKER_VERSION=1.11.2
CALICO_CTL_VERSION=v0.22.0
CALICO_CNI_VERSION=v1.4.2
CNI_VERSION=v0.3.0
DOCKER_RPM_VERSION=1.11.2-1.el7.centos.x86_64
DOCKER_SELINUX_RPM_VERSION=1.11.2-1.el7.centos.noarch
DOCKER_DEB_VERSION=1.11.2-0~xenial_amd64
DOCKER_DEB_VERSION_SHORT=1.11.2-0~xenial
ETCD_VERSION=v3.0.10
ETCD2_VERSION=v2.3.7

K8S_URL=https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64

CNI_CALICO_CTL_URL=https://github.com/projectcalico/calico-containers/releases/download/$CALICO_CTL_VERSION/calicoctl
CNI_CALICO_CNI_URL=https://github.com/projectcalico/calico-cni/releases/download/$CALICO_CNI_VERSION
CNI_URL=https://github.com/containernetworking/cni/releases/download/$CNI_VERSION/cni-$CNI_VERSION.tgz

DOCKER_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-$DOCKER_RPM_VERSION.rpm
DOCKER_SELINUX_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-$DOCKER_SELINUX_RPM_VERSION.rpm
DOCKER_DEB_URL=https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_$DOCKER_DEB_VERSION.deb

ETCD_K8S_URL=https://github.com/coreos/etcd/releases/download/$ETCD_VERSION/etcd-$ETCD_VERSION-linux-amd64.tar.gz
ETCD_NETWORKING_URL=https://github.com/coreos/etcd/releases/download/$ETCD2_VERSION/etcd-$ETCD2_VERSION-linux-amd64.tar.gz

# docker images
REGISTRY_IMG=registry:2.5.1
CALICO_IMG=calico/node:v0.22.0
CALICO_KUBE_POLICY_CONTROLLER_IMG=calico/kube-policy-controller:v0.3.0
KUBEDNS_IMG=gcr.io/google_containers/kubedns-amd64:1.7
DNSMAQ_IMG=gcr.io/google_containers/kube-dnsmasq-amd64:1.3
EXECHEALTHZ_IMG=gcr.io/google_containers/exechealthz-amd64:1.0
KUBERNETES_DASHBOARD_IMG=gcr.io/google_containers/kubernetes-dashboard-amd64:v1.4.0
# Used internally by k8s
PAUSE_IMG=gcr.io/google_containers/pause-amd64:3.0
# Used by kuberang
NGINX_IMG=nginx
BUSYBOX_IMG=busybox
