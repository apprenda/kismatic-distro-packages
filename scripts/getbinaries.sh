#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# k8s
rm -rf source/kubernetes
wget -P source/kubernetes/kubelet/bin/ $K8S_URL/kubelet
wget -P source/kubernetes/proxy/bin/ $K8S_URL/kube-proxy
wget -P source/kubernetes/scheduler/bin/ $K8S_URL/kube-scheduler
wget -P source/kubernetes/apiserver/bin/ $K8S_URL/kube-apiserver
wget -P source/kubernetes/controller-manager/bin/ $K8S_URL/kube-controller-manager
wget -P source/kubernetes/kubectl/bin/ $K8S_URL/kubectl
chmod 750 source/kubernetes/*/bin/*

# cni
rm -rf source/networking/
wget -P source/networking/ctl/bin/ $CNI_CALICO_CTL_URL
chmod 770 source/networking/ctl/bin/*
wget -P source/networking/cni/bin/ $CNI_CALICO_CNI_URL/calico
wget -P source/networking/cni/bin/ $CNI_CALICO_CNI_URL/calico-ipam
wget -P source/networking/cni/ $CNI_URL && tar xvzf source/networking/cni/cni-* -C source/networking/cni/bin/ && rm source/networking/cni/cni-*.tgz
chmod 750 source/networking/cni/bin/*

# docker
rm -rf source/docker/
wget -P source/docker/rpm/ $DOCKER_RPM_URL
wget -P source/docker/rpm/ $DOCKER_SELINUX_RPM_URL
wget -P source/docker/deb/ $DOCKER_DEB_URL

# etcd
rm -rf source/etcd/
mkdir -p source/etcd/k8s/bin/
mkdir -p source/etcd/networking/bin/
wget -P source/etcd/ $ETCD_K8S_URL && tar xvzf source/etcd/etcd-v3* -C source/etcd/ && rm source/etcd/etcd-v3*.tar.gz
cp source/etcd/etcd-v3*/etcd source/etcd/k8s/bin/etcd_k8s
cp source/etcd/etcd-v3*/etcdctl source/etcd/k8s/bin/etcdctl
cp source/etcd/etcd-v3*/etcd source/etcd/networking/bin/etcd_networking
chmod 750 source/etcd/*/bin/*
