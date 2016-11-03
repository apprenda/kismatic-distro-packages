#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# build Kubernetes
# master
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-master" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -d "kismatic-kubernetes-node = $REQUIRED_DEB_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-kubernetes-networking = $REQUIRED_DEB_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_DEB_VERSION_SHORT" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes master binaries" \
  --url "https://apprenda.com/" \
  kubernetes/apiserver/bin/kube-apiserver=/usr/bin/kube-apiserver \
  kubernetes/scheduler/bin/kube-scheduler=/usr/bin/kube-scheduler \
  kubernetes/controller-manager/bin/kube-controller-manager=/usr/bin/kube-controller-manager \
  kubernetes/kubectl/bin/kubectl=/usr/bin/kubectl \
  images/registry.tar=/opt/images/registry.tar \
  images/kubedns.tar=/opt/images/kubedns.tar \
  images/kube-dnsmasq.tar=/images/opt/kube-dnsmasq.tar \
  images/kubernetes-dashboard.tar=/opt/images/kubernetes-dashboard.tar \
  images/exechealthz.tar=/opt/images/exechealthz.tar

# worker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-node" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -d "kismatic-kubernetes-networking = $REQUIRED_DEB_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_DEB_VERSION_SHORT" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes node binaries" \
  --url "https://apprenda.com/" \
  kubernetes/kubelet/bin/kubelet=/usr/bin/kubelet \
  kubernetes/proxy/bin/kube-proxy=/usr/bin/kube-proxy \
  images/pause.tar=/opt/images/pause.tar \
  images/nginx.tar=/opt/images/nginx.tar \
  images/busybox.tar=/opt/images/busybox.tar

# networking
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubernetes-networking" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes networking binaries" \
  --url "https://apprenda.com/" \
  networking/ctl/bin/calicoctl=/usr/bin/calicoctl \
  networking/cni/bin/=/opt/cni/ \
  images/calico.tar=/opt/images/calico.tar \
  images/kube-policy-controller.tar=/opt/images/kube-policy-controller.tar

# build etcd
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-etcd" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Etcd kubernetes and networking binaries" \
  --url "https://apprenda.com/" \
  etcd/k8s/bin/etcd=/usr/bin/etcd \
  etcd/k8s/bin/etcdctl=/usr/bin/etcdctl \
  etcd/networking/bin/etcd2=/usr/bin/etcd2 \
  etcd/networking/bin/etcdctl2=/usr/bin/etcdctl2

# build docker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s deb \
  -n "kismatic-docker-engine" \
  -a amd64 \
  -t deb \
  -v $DOCKER_VERSION \
  -p /build/debs/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Docker and its dependencies" \
  --url "https://apprenda.com/" \
  /source/docker/deb/docker-engine_$DOCKER_DEB_VERSION.deb
