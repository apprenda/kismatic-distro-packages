#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

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
  --url "https://apprenda.com/kismatic" \
  etcd/k8s/bin/etcd_k8s=/usr/bin/etcd_k8s \
  etcd/k8s/bin/etcdctl=/usr/bin/etcdctl \
  etcd/networking/bin/etcd_networking=/usr/bin/etcd_networking

# kubelet
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubelet" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -d 'bridge-utils' \
  -d 'iptables >= 1.4.21' \
  -d 'socat' \
  -d 'util-linux' \
  -d 'ethtool' \
  -d 'nfs-common' \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes kubelet binary" \
  --url "https://apprenda.com/kismatic" \
  kubernetes/kubelet/bin/kubelet=/usr/bin/kubelet

# kubectl
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-kubectl" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes kubelet binary" \
  --url "https://apprenda.com/kismatic" \
  kubernetes/kubectl/bin/kubectl=/usr/bin/kubectl

# offline
docker run \
  -v $(pwd)/source/:/source/ \
  -v $(pwd)/build/:/build/ \
  kismatic/fpm fpm \
  -s dir \
  -n "kismatic-offline" \
  -v $KISMATIC_PACKAGE_VERSION  \
  -a amd64 \
  -t deb \
  -p /build/debs \
  -C /source/ \
  --license "Apache Software License 2.0" \
  --maintainer "Apprenda <info@apprenda.com>" \
  --vendor "Apprenda" \
  --description "Kubernetes node binaries" \
  --url "https://apprenda.com/kismatic" \
  images/registry.tar=/opt/images/registry.tar \
  images/kubedns.tar=/opt/images/kubedns.tar \
  images/kube-dnsmasq.tar=/opt/images/kube-dnsmasq.tar \
  images/kubernetes-dashboard.tar=/opt/images/kubernetes-dashboard.tar \
  images/exechealthz.tar=/opt/images/exechealthz.tar \
  images/pause.tar=/opt/images/pause.tar \
  images/nginx.tar=/opt/images/nginx.tar \
  images/busybox.tar=/opt/images/busybox.tar \
  images/defaultbackend.tar=/opt/images/defaultbackend.tar \
  images/nginx-ingress-controller.tar=/opt/images/nginx-ingress-controller.tar \
  images/tcp-healthz-amd64.tar=/opt/images/tcp-healthz-amd64.tar \
  images/kube-proxy.tar=/opt/images/kube-proxy.tar \
  images/kube-controller-manager.tar=/opt/images/kube-controller-manager.tar \
  images/kube-scheduler.tar=/opt/images/kube-scheduler.tar \
  images/kube-apiserver.tar=/opt/images/kube-apiserver.tar \
  images/calico.tar=/opt/images/calico.tar \
  images/calico-ctl.tar=/opt/images/calico-ctl.tar \
  images/calico-cni.tar=/opt/images/calico-cni.tar \
  images/kube-policy-controller.tar=/opt/images/kube-policy-controller.tar
