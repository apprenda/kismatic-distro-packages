#!/bin/bash
set -e

source ./scripts/VARIABLES.sh

rm -rf source/images
mkdir -p source/images
docker pull $KUBE_PROXY_IMG && docker save $KUBE_PROXY_IMG > source/images/kube-proxy.tar
docker pull $KUBE_CONTROLLER_MANAGER_IMG && docker save $KUBE_CONTROLLER_MANAGER_IMG > source/images/kube-controller-manager.tar
docker pull $KUBE_SCHEDULER_IMG && docker save $KUBE_SCHEDULER_IMG > source/images/kube-scheduler.tar
docker pull $KUBE_APISERVER_IMG && docker save $KUBE_APISERVER_IMG > source/images/kube-apiserver.tar

docker pull $CALICO_IMG && docker save $CALICO_IMG > source/images/calico.tar
docker pull $CALICO_CTL_IMG && docker save $CALICO_CTL_IMG > source/images/calico-ctl.tar
docker pull $CALICO_CNI_IMG && docker save $CALICO_CNI_IMG > source/images/calico-cni.tar
docker pull $CALICO_KUBE_POLICY_CONTROLLER_IMG && docker save $CALICO_KUBE_POLICY_CONTROLLER_IMG > source/images/kube-policy-controller.tar

docker pull $REGISTRY_IMG && docker save $REGISTRY_IMG > source/images/registry.tar
docker pull $KUBEDNS_IMG && docker save $KUBEDNS_IMG > source/images/kubedns.tar
docker pull $DNSMAQ_IMG && docker save $DNSMAQ_IMG > source/images/kube-dnsmasq.tar
docker pull $KUBEDNS_SIDECAR_IMG && docker save $KUBEDNS_SIDECAR_IMG > source/images/kubedns-sidecar.tar
docker pull $KUBERNETES_DASHBOARD_IMG && docker save $KUBERNETES_DASHBOARD_IMG > source/images/kubernetes-dashboard.tar
docker pull $DEFAULT_BACKEND && docker save $DEFAULT_BACKEND > source/images/defaultbackend.tar
docker pull $NGINX_INGRESS_CONTROLLER && docker save $NGINX_INGRESS_CONTROLLER > source/images/nginx-ingress-controller.tar
docker pull $APPRENDA_TCP_HEALTHZ && docker save $APPRENDA_TCP_HEALTHZ > source/images/tcp-healthz-amd64.tar
docker pull $PAUSE_IMG && docker save $PAUSE_IMG > source/images/pause.tar
docker pull $NGINX_IMG && docker save $NGINX_IMG > source/images/nginx.tar
docker pull $BUSYBOX_IMG && docker save $BUSYBOX_IMG > source/images/busybox.tar
docker pull $HEAPSTER && docker save $HEAPSTER > source/images/heapster.tar
docker pull $INFLUXDB && docker save $INFLUXDB > source/images/influxdb.tar
docker pull $TILLER && docker save $TILLER > source/images/tiller.tar
