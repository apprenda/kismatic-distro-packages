#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

rm -rf source/images
mkdir -p source/images
docker pull $REGISTRY_IMG && docker save $REGISTRY_IMG > source/images/registry.tar
docker pull $CALICO_IMG && docker save $CALICO_IMG > source/images/calico.tar
docker pull $CALICO_KUBE_POLICY_CONTROLLER_IMG && docker save $CALICO_KUBE_POLICY_CONTROLLER_IMG > source/images/kube-policy-controller.tar
docker pull $KUBEDNS_IMG && docker save $KUBEDNS_IMG > source/images/kubedns.tar
docker pull $DNSMAQ_IMG && docker save $DNSMAQ_IMG > source/images/kube-dnsmasq.tar
docker pull $EXECHEALTHZ_IMG && docker save $EXECHEALTHZ_IMG > source/images/exechealthz.tar
docker pull $KUBERNETES_DASHBOARD_IMG && docker save $KUBERNETES_DASHBOARD_IMG > source/images/kubernetes-dashboard.tar
docker pull $PAUSE_IMG && docker save $PAUSE_IMG > source/images/pause.tar
docker pull $NGINX_IMG && docker save $NGINX_IMG > source/images/nginx.tar
docker pull $BUSYBOX_IMG && docker save $BUSYBOX_IMG > source/images/busybox.tar
docker pull $DEFAULT_BACKEND && docker save $DEFAULT_BACKEND > source/images/defaultbackend.tar
docker pull $NGINX_INGRESS_CONTROLLER && docker save $NGINX_INGRESS_CONTROLLER > source/images/nginx-ingress-controller.tar
