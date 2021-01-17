#!/bin/bash

sudo rm -rf ~/.config/convox
sudo rm -rf /root/.config/convox/


sudo apt-get purge -y terraform docker.io
sudo apt autoremove

sudo rm -rf ~/.terraform.d
sudo rm -rf /root/.terraform.d

sudo find / -type d -regex '^.*terraform.*$'


sudo snap remove microk8s --purge
sudo rm -rf ~/.kube
sudo rm -rf /root/.kube
sudo rm -rf /usr/libexec/kubernetes


sudo rm -rf /sys/fs/cgroup/hugetlb/kubepods
sudo rm -rf /sys/fs/cgroup/hugetlb/kube-proxy
sudo rm -rf /sys/fs/cgroup/perf_event/kubepods
sudo rm -rf /sys/fs/cgroup/perf_event/kube-proxy
sudo rm -rf /sys/fs/cgroup/devices/kubepods
sudo rm -rf /sys/fs/cgroup/devices/kube-proxy
sudo rm -rf /sys/fs/cgroup/cpuset/kubepods
sudo rm -rf /sys/fs/cgroup/cpuset/kube-proxy
sudo rm -rf /sys/fs/cgroup/pids/kubepods
sudo rm -rf /sys/fs/cgroup/pids/kube-proxy
sudo rm -rf /sys/fs/cgroup/freezer/kubepods
sudo rm -rf /sys/fs/cgroup/freezer/kube-proxy
sudo rm -rf /sys/fs/cgroup/blkio/kubepods
sudo rm -rf /sys/fs/cgroup/blkio/kube-proxy
sudo rm -rf /sys/fs/cgroup/cpu,cpuacct/kubepods
sudo rm -rf /sys/fs/cgroup/cpu,cpuacct/kube-proxy
sudo rm -rf /sys/fs/cgroup/net_cls,net_prio/kubepods
sudo rm -rf /sys/fs/cgroup/net_cls,net_prio/kube-proxy
sudo rm -rf /sys/fs/cgroup/memory/kubepods
sudo rm -rf /sys/fs/cgroup/memory/kube-proxy
sudo rm -rf /sys/fs/cgroup/systemd/kubepods
sudo rm -rf /sys/fs/cgroup/systemd/kube-proxy
sudo rm -rf /var/lib/kubelet

sudo rm -rf /usr/lib/systemd/resolved.conf.d


sudo find / -type d -regex '^.*kube.*$'