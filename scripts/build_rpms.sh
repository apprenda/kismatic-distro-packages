#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# build Kubernetes
# master
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir\
  -n 'kismatic-kubernetes-master' \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -d "kismatic-kubernetes-node = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-kubernetes-networking = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_VERSION" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/rpms/ \
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
  images/kube-dnsmasq.tar=/opt/images/kube-dnsmasq.tar \
  images/kubernetes-dashboard.tar=/opt/images/kubernetes-dashboard.tar \
  images/exechealthz.tar=/opt/images/exechealthz.tar

# worker
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n 'kismatic-kubernetes-node' \
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -d "kismatic-kubernetes-networking = $REQUIRED_RPM_KISMATIC_PACKAGE_VERSION" \
  -d "kismatic-docker-engine = $DOCKER_VERSION" \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -p /build/rpms/ \
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
  -v $KISMATIC_PACKAGE_VERSION \
  -t rpm --rpm-os linux \
  -a x86_64 \
  -p /build/rpms/ \
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
  -v $KISMATIC_PACKAGE_VERSION \
  -a x86_64 \
  -t rpm --rpm-os linux \
  -p /build/rpms/ \
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
  -s rpm \
  -n "kismatic-docker-engine" \
  -v $DOCKER_VERSION \
  -a x86_64 \
  -t rpm --rpm-os linux \
  -p /build/rpms/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Docker and its dependencies" \
  --url "https://apprenda.com/" \
  /source/docker/rpm/docker-engine-selinux-$DOCKER_SELINUX_RPM_VERSION.rpm \
  /source/docker/rpm/docker-engine-$DOCKER_RPM_VERSION.rpm
