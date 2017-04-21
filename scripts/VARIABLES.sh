#!/bin/bash

# versions
KISMATIC_PACKAGE_VERSION=1.6.2-1
K8S_VERSION=1.6.2
ETCD_VERSION=3.1.4
TRANSITION_ETCD_VERSION=3.0.17
DOCKER_VERSION=1.11.2
DOCKER_RPM_VERSION=1.11.2-1.el7.centos.x86_64
DOCKER_SELINUX_RPM_VERSION=1.11.2-1.el7.centos.noarch
DOCKER_DEB_VERSION=1.11.2-0~xenial_amd64

# urls
K8S_URL=https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64
ETCD_URL=https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz
TRANSITION_ETCD_URL=https://github.com/coreos/etcd/releases/download/v$TRANSITION_ETCD_VERSION/etcd-v$TRANSITION_ETCD_VERSION-linux-amd64.tar.gz

# docker images
DOCKER_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-$DOCKER_RPM_VERSION.rpm
DOCKER_SELINUX_RPM_URL=https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-$DOCKER_SELINUX_RPM_VERSION.rpm
DOCKER_DEB_URL=https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docker-engine_$DOCKER_DEB_VERSION.deb

# k8s control plance
KUBE_PROXY_IMG=gcr.io/google-containers/kube-proxy-amd64:v$K8S_VERSION
KUBE_CONTROLLER_MANAGER_IMG=gcr.io/google-containers/kube-controller-manager-amd64:v$K8S_VERSION
KUBE_SCHEDULER_IMG=gcr.io/google-containers/kube-scheduler-amd64:v$K8S_VERSION
KUBE_APISERVER_IMG=gcr.io/google-containers/kube-apiserver-amd64:v$K8S_VERSION
# networking
CALICO_IMG=calico/node:v1.1.0
CALICO_CTL_IMG=calico/ctl:v1.1.0
CALICO_CNI_IMG=calico/cni:v1.6.1
CALICO_KUBE_POLICY_CONTROLLER_IMG=calico/kube-policy-controller:v0.6.0
# install support
REGISTRY_IMG=registry:2.5.1
KUBEDNS_IMG=gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.1
DNSMAQ_IMG=gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.1
KUBEDNS_SIDECAR_IMG=gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.1
KUBERNETES_DASHBOARD_IMG=gcr.io/google_containers/kubernetes-dashboard-amd64:v1.6.0
DEFAULT_BACKEND=gcr.io/google_containers/defaultbackend:1.0
NGINX_INGRESS_CONTROLLER=gcr.io/google_containers/nginx-ingress-controller:0.8.3
APPRENDA_TCP_HEALTHZ=apprenda/tcp-healthz-amd64:v1.0.0
# used internally by k8s
PAUSE_IMG=gcr.io/google_containers/pause-amd64:3.0
# used by kuberang
NGINX_IMG=nginx:stable-alpine
BUSYBOX_IMG=busybox:latest
