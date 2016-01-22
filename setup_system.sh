#!/bin/bash

echo "Loading kernel modules ..."
sudo modprobe ip_tables
sudo modprobe ip6_tables
sudo modprobe xt_set

echo "Configuring IP forwarding ..."
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv4.conf.all.forwarding=1

echo "Installing latest docker version ..."
sudo curl -sSL https://get.docker.com/ | sh

echo "Installing weave ..."
sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod a+x /usr/local/bin/weave

echo "Installing etcd ..."
sudo curl -L  https://github.com/coreos/etcd/releases/download/v2.2.4/etcd-v2.2.4-linux-amd64.tar.gz -o etcd-v2.2.4-linux-amd64.tar.gz
sudo tar xzvf etcd-v2.2.4-linux-amd64.tar.gz
sudo cp etcd-v2.2.4-linux-amd64/etcd /usr/local/bin/etcd

echo "Installing flannel ..."
sudo apt-get update
sudo apt-get install -y linux-libc-dev golang gcc
sudo git clone https://github.com/coreos/flannel.git
cd flannel
sudo ./build
cd ..

echo "Installing calico ..."
sudo curl -L http://www.projectcalico.org/latest/calicoctl -o /usr/local/bin/calicoctl
sudo chmod a+x /usr/local/bin/calicoctl
