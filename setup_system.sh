#!/bin/bash

sudo modprobe ip_tables
sudo modprobe ip6_tables
sudo modprobe xt_set
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv4.conf.all.forwarding=1

# install docker 1.9.1
sudo curl -sSL https://get.docker.com/ | sh
