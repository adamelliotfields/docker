# Kubernetes
> _Docker-in-Docker with `systemd`, `kubeadm`, `kubectl`, `kubelet`, and `crictl`._

I can get `kubeadm init` to work on the master, and deploy Weave Net and the Kubernetes Dashboard.
Unfortunately, I cannot get worker nodes to join the cluster. `kubeadm join` works, but running
`kubectl get nodes` on the master shows no new nodes joining the cluster.

The issue may be with `modprobe br_netfilter`, which doesn't seem to work in containers.
