#!/bin/bash
set -e

# docker images
DOCKER_IMG=registry:2.5.1
CALICO_IMG=calico/node:v0.22.0
CALICO_KUBE_POLICY_CONTROLLER_IMG=calico/kube-policy-controller
KUBEDNS_IMG=gcr.io/google_containers/kubedns-amd64:1.7
DNSMAQ_IMG=gcr.io/google_containers/kube-dnsmasq-amd64:1.3
EXECHEALTHZ_IMG=gcr.io/google_containers/exechealthz-amd64:1.0
KUBERNETES_DASHBOARD_IMG=gcr.io/google_containers/kubernetes-dashboard-amd64:v1.4.0
# Used internally by k8s
PAUSE_IMG=gcr.io/google_containers/pause-amd64:3.0

rm -rf source/images
mkdir -p source/images
docker pull $DOCKER_IMG && docker save $DOCKER_IMG > source/images/registry.tar
docker pull $CALICO_IMG && docker save $CALICO_IMG > source/images/calico.tar
docker pull $CALICO_KUBE_POLICY_CONTROLLER_IMG && docker save $CALICO_KUBE_POLICY_CONTROLLER_IMG > source/images/kube-policy-controller.tar
docker pull $KUBEDNS_IMG && docker save $KUBEDNS_IMG > source/images/kubedns.tar
docker pull $DNSMAQ_IMG && docker save $DNSMAQ_IMG > source/images/kube-dnsmasq.tar
docker pull $EXECHEALTHZ_IMG && docker save $EXECHEALTHZ_IMG > source/images/exechealthz.tar
docker pull $KUBERNETES_DASHBOARD_IMG && docker save $KUBERNETES_DASHBOARD_IMG > source/images/kubernetes-dashboard.tar
docker pull $PAUSE_IMG && docker save $PAUSE_IMG > source/images/pause.tar
