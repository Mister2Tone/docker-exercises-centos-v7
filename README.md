# docker-exercises-centos-v7
## My Environment
- Windows Linux Subsystem (Ubuntu 18.04 LTS)
- Vagrant 2.2.6 (both WSL & Windows side)
- VirtualBox Version 6.0.14 r133895 (Qt5.6.2)

## Prerequisite
- SSH RSA public key store at `~/.ssh/id_rsa.pub` (you need to generate RSA Key in WSL Environment)
  - remark: Need to forward key manually because of WSL Environment conflict with automatically forward key by Vagrant
- Virtual Box have already installed
- Host-only Interface provide IP Pool= 192.168.56.0/24

## Boxes
- docker-machine
  - OS CentOS-7
  - IP 192.168.56.99
  - CPU 2 cores
  - RAM 4096 MBs

## Table of Contents
1. Installation
2. Working with Docker Containers
3. Working with Docker Images 
4. Network and Data Management for Containers
5. Docker Use Cases
6. Docker APIs and SDKs
7. Docker Performance
8. Docker Orchestration and Hosting a Platform
9. Docker Security *
10. Getting Help and Tips and Tricks
11. Docker on the Cloud

## Reference
1. [Docker Cookbook - 2nd Edition](https://subscription.packtpub.com/book/virtualization_and_cloud/9781788626866)