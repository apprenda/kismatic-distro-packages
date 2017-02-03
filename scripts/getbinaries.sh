#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

# k8s
rm -rf source/kubernetes
wget -P source/kubernetes/kubelet/bin/ $K8S_URL/kubelet
wget -P source/kubernetes/kubectl/bin/ $K8S_URL/kubectl
chmod 750 source/kubernetes/*/bin/*

# etcd
rm -rf source/etcd/
mkdir -p source/etcd/k8s/bin/
mkdir -p source/etcd/networking/bin/
wget -P source/etcd/k8s/ $ETCD_URL && tar xvzf source/etcd/k8s/etcd-v3* -C source/etcd/k8s/ && rm source/etcd/k8s/etcd-v3*.tar.gz
mv source/etcd/k8s/etcd-v3*/etcd source/etcd/k8s/bin/etcd_k8s
mv source/etcd/k8s/etcd-v3*/etcdctl source/etcd/k8s/bin/etcdctl
rm -rf source/etcd/k8s/etcd-v3*
wget -P source/etcd/networking/ $ETCD_URL && tar xvzf source/etcd/networking/etcd-v3* -C source/etcd/networking && rm source/etcd/networking/etcd-v3*.tar.gz
mv source/etcd/networking/etcd-v3*/etcd source/etcd/networking/bin/etcd_networking
rm -rf source/etcd/networking/etcd-v3*
chmod 750 source/etcd/*/bin/*
