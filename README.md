# Scripts for setup of network overlays

Steps necessary for setting up simple examples to test the following network overlays:
* Docker Networking
* Weave
* Flannel (UDP mode)
* Calico

The test were conducted with three virtual boxes on a local machine (ubuntu 15.10, 1 CPU, 2 GB RAM, bridged network interface) and docker version 1.9.1, build a34a1d5. I'm going to refer to the three VMs as vm0, vm1, and vm2. Properties, as for example the IP address of the VMs will be referred to as vm0.ip, vm1.ip, and vm2.ip respectively. I'm going to refer to containers with the name of the image they are running surrounded by [ ], e.g. [mysql], [wordpress]. Again, properties will be referred to as [imageName].property, e.g. [mysql].ip, [mysql].overlayIp.
I'm considering providing vagrant/packer boxes for an even easier setup in the near future.

## Setup your system
The `setup_system.sh` script loads the needed kernel modules, makes sure that ipv4 and ipv6 forwarding is turned on, and installs docker 1.9.1.

## Docker Networking
1. Start consul container on vm0: `vm0:$ docker run -itd -p 8500:8500 progrium/consul`
2. Stop docker daemon on vm1 and vm2.
3. Start docker daemon on vm1 and vm2 with information about consul: `vm[1,2]:$ sudo docker daemon --cluster-store=consul://<vm0.ip>:8500 --cluster-advertise=<vm[1,2].nic>:2376`
4. Create docker network on vm2: `vm2:$ docker network create --driver overlay my-net`
5. Start mysql container on vm2: `vm2:$ docker run -itd --net my-net -e MYSQL_ROOT_PASSWORD=<password> mysql`
  1. Make sure the container is running: `vm2:$ docker ps`
  2. Get overlay IP address from container: `vm2:$ docker exec <[mysql].name> ip a`
6. Start wordpress container on vm1: `vm1:$ docker run -itd --net my-net -e WORDPRESS_DB_HOST=<[mysql].overlayIp>:3306 -e WORDPRESS_DB_PASSWORD=<password> -p 8080:80 wordpress`
  1. Make sure the container is running: `vm1:$ docker ps`
  2. Make sure [wordpress] can ping [mysql]: `vm1:$ docker exec <[wordpress].name> ping -c1 <[mysql].overlayIp>`
7. Open wordpress homepage on `http://<vm1.ip>:8080`
