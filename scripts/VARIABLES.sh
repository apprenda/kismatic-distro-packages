#!/bin/bash

# versions
KISMATIC_PACKAGE_VERSION=1.5.2-4
K8S_VERSION=1.5.2
ETCD_VERSION=v3.1.0

K8S_URL=https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64
ETCD_URL=https://github.com/coreos/etcd/releases/download/$ETCD_VERSION/etcd-$ETCD_VERSION-linux-amd64.tar.gz


# docker images
# k8s control plance
KUBE_PROXY_IMG=gcr.io/google-containers/kube-proxy-amd64:v$K8S_VERSION
KUBE_CONTROLLER_MANAGER_IMG=gcr.io/google-containers/kube-controller-manager-amd64:v$K8S_VERSION
KUBE_SCHEDULER_IMG=gcr.io/google-containers/kube-scheduler-amd64:v$K8S_VERSION
KUBE_APISERVER_IMG=gcr.io/google-containers/kube-apiserver-amd64:v$K8S_VERSION
# networking
CALICO_IMG=calico/node:v1.0.2
CALICO_CTL_IMG=calico/ctl:v1.0.2
CALICO_CNI_IMG=calico/cni:v1.5.6
CALICO_KUBE_POLICY_CONTROLLER_IMG=calico/kube-policy-controller:v0.5.2
# install support
REGISTRY_IMG=registry:2.5.1
KUBEDNS_IMG=gcr.io/google_containers/kubedns-amd64:1.9
DNSMAQ_IMG=gcr.io/google_containers/kube-dnsmasq-amd64:1.4
EXECHEALTHZ_IMG=gcr.io/google_containers/exechealthz-amd64:1.2
KUBERNETES_DASHBOARD_IMG=gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.1
DEFAULT_BACKEND=gcr.io/google_containers/defaultbackend:1.0
NGINX_INGRESS_CONTROLLER=gcr.io/google_containers/nginx-ingress-controller:0.8.3
APPRENDA_TCP_HEALTHZ=apprenda/tcp-healthz-amd64:v1.0.0
# Used internally by k8s
PAUSE_IMG=gcr.io/google_containers/pause-amd64:3.0
# Used by kuberang
NGINX_IMG=nginx:stable-alpine
BUSYBOX_IMG=busybox:latest
