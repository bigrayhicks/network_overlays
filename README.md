# Scripts for setup of network overlays

Steps necessary for setting up simple examples to test the following network overlays:
* [Docker Networking]
* Weave
* Flannel (UDP mode)
* Calico

The test were conducted with three virtual boxes on a local machine (ubuntu 15.10, 1 CPU, 2 GB RAM, bridged network interface) and docker version 1.9.1, build a34a1d5. I'm going to refer to the three VMs as vm0, vm1, and vm2. Properties, as for example the IP address of the VMs will be referred to as vm0.ip, vm1.ip, and vm2.ip respectively.
I'm considering providing vagrant/packer boxes for an even easier setup in the near future.

## Setup your system
The `setup_system.sh` script loads the needed kernel modules, makes sure that ipv4 and ipv6 forwarding is turned on, and installs docker 1.9.1.

## (Docker Networking)
1. Start consul container on vm0: 
