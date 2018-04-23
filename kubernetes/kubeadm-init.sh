#!/bin/bash

set -e

systemctl stop kubelet \
&& kubeadm init --ignore-preflight-errors=CRI,Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables \
&& mkdir -p /root/.kube \
&& cp -i /etc/kubernetes/admin.conf /root/.kube/config \
&& kubever=$(kubectl version | base64 | tr -d '\n'); kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever" \
&& kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

exit $?
