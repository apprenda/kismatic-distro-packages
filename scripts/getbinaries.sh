#!/bin/bash
set -e

# download k8s
K8S_URL=https://storage.googleapis.com/kubernetes-release/release/v1.4.0/bin/linux/amd64
rm -rf source/kubernetes
wget -P source/kubernetes/kubelet/bin/ $K8S_URL/kubelet
wget -P source/kubernetes/proxy/bin/ $K8S_URL/kube-proxy
wget -P source/kubernetes/scheduler/bin/ $K8S_URL/kube-scheduler
wget -P source/kubernetes/apiserver/bin/ $K8S_URL/kube-apiserver
wget -P source/kubernetes/controller-manager/bin/ $K8S_URL/kube-controller-manager
wget -P source/kubernetes/kubectl/bin/ $K8S_URL/kubectl
chmod 750 source/kubernetes/*/bin/*

# cni
CNI_CALICO_CTL_URL=https://github.com/projectcalico/calico-containers/releases/download/v0.22.0/calicoctl
CNI_CALICO_CNI_URL=https://github.com/projectcalico/calico-cni/releases/download/v1.4.2
CNI_URL=https://github.com/containernetworking/cni/releases/download/v0.3.0/cni-v0.3.0.tgz
rm -rf source/networking/
wget -P source/networking/ctl/bin/ $CNI_CALICO_CTL_URL
chmod 770 source/networking/ctl/bin/*
wget -P source/networking/cni/bin/ $CNI_CALICO_CNI_URL/calico
wget -P source/networking/cni/bin/ $CNI_CALICO_CNI_URL/calico-ipam
wget -P source/networking/cni/ $CNI_URL && tar xvzf source/networking/cni/cni-* -C source/networking/cni/bin/ && rm source/networking/cni/cni-*.tgz
chmod 750 source/networking/cni/bin/*

# docker
DOCKER_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.11.2-1.el7.centos.x86_64.rpm
DOCKER_SELINUX_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.11.2-1.el7.centos.noarch.rpm
DOCKER_DEB_URL=https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_1.11.2-0~xenial_amd64.deb
rm -rf source/docker/
wget -P source/docker/rpm/ $DOCKER_RPM_URL
wget -P source/docker/rpm/ $DOCKER_SELINUX_RPM_URL
wget -P source/docker/deb/ $DOCKER_DEB_URL

# etcd
ETCD_K8S_URL=https://github.com/coreos/etcd/releases/download/v3.0.10/etcd-v3.0.10-linux-amd64.tar.gz
ETCD_NETWORKING_URL=https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz
rm -rf source/etcd/
mkdir -p source/etcd/k8s/bin/
mkdir -p source/etcd/networking/bin/
wget -P source/etcd/k8s/ $ETCD_K8S_URL && tar xvzf source/etcd/k8s/etcd-v3* -C source/etcd/k8s/ && rm source/etcd/k8s/etcd-v3*.tar.gz
mv source/etcd/k8s/etcd-v3*/etcd source/etcd/k8s/bin/etcd
mv source/etcd/k8s/etcd-v3*/etcdctl source/etcd/k8s/bin/etcdctl
rm -rf source/etcd/k8s/etcd-v3*
wget -P source/etcd/networking/ $ETCD_NETWORKING_URL && tar xvzf source/etcd/networking/etcd-v2* -C source/etcd/networking && rm source/etcd/networking/etcd-v2*.tar.gz
mv source/etcd/networking/etcd-v2*/etcd source/etcd/networking/bin/etcd2
mv source/etcd/networking/etcd-v2*/etcdctl source/etcd/networking/bin/etcdctl2
rm -rf source/etcd/networking/etcd-v2*
chmod 750 source/etcd/*/bin/*
