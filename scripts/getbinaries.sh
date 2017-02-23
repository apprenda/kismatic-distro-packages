#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# k8s
rm -rf source/kubernetes
wget -P source/kubernetes/kubelet/bin/ $K8S_URL/kubelet
wget -P source/kubernetes/kubectl/bin/ $K8S_URL/kubectl
chmod 750 source/kubernetes/*/bin/*

# docker
rm -rf source/docker/
wget -P source/docker/rpm/ $DOCKER_RPM_URL
wget -P source/docker/rpm/ $DOCKER_SELINUX_RPM_URL
wget -P source/docker/deb/ $DOCKER_DEB_URL

# etcd
rm -rf source/etcd/
mkdir -p source/etcd/k8s/bin/
mkdir -p source/etcd/networking/bin/
wget -P source/etcd/ $ETCD_URL && tar xvzf source/etcd/etcd-v3* -C source/etcd/ && rm source/etcd/etcd-v3*.tar.gz
cp source/etcd/etcd-v3*/etcd source/etcd/networking/bin/etcd_networking
mv source/etcd/etcd-v3*/etcd source/etcd/k8s/bin/etcd_k8s
mv source/etcd/etcd-v3*/etcdctl source/etcd/k8s/bin/etcdctl
rm -rf source/etcd/etcd-v3*
chmod 750 source/etcd/*/bin/*

# transition etcd
# to support upgrades a v3.0.x is required to go from 2.3.x to 3.1.x
rm -rf source/transitionetcd/
mkdir -p source/transitionetcd/bin/
wget -P source/transitionetcd/ $TRANSITION_ETCD_URL && tar xvzf source/transitionetcd/etcd-v3* -C source/transitionetcd/ && rm source/transitionetcd/etcd-v3*.tar.gz
cp source/transitionetcd/etcd-v3*/etcd source/transitionetcd/bin/etcd_transition
rm -rf source/transitionetcd/etcd-v3*
chmod 750 source/transitionetcd/bin/*
