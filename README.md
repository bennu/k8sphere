# <img src="docs/img/vke_transparent.png" alt="Logo" width="6%"/> k8sphere

> A nice way to deploy kubernetes clusters on vSphere

**Disclaimer:** This is a **work in progress**, being built in spare time.

## Roadmap

Can be found at the [GitLab's project](https://gitlab.com/bennuteam/k8sphere/milestones/1), any contribution is welcome.

## Getting started

Before deploying your first k8sphere cluster, some tools are needed:

* A VM template to deploy the cluster from. A repository with packer recipes was built for this purpose and can be found at [k8sphere-packer](https://github.com/bennu/k8sphere-packer)
* [Terraform](https://www.terraform.io/downloads.html) (v0.11 or later) and [provisioner ansible](https://github.com/radekg/terraform-provisioner-ansible). Follow the instructions on [how to install third-party plugins](https://www.terraform.io/docs/configuration/providers.html#third-party-plugins) to be able to use the provisioner.
    * In case you want to use this as part of a CI/CD workflow, an image containing these two tools was already built, simply run `docker pull registry.gitlab.com/bennuteam/k8sphere/terraform:0.11.10`. Dockerfile can be found at [tools/terraform.dockerfile](tools/terraform.dockerfile)

Once all is successfully installed, you can take a look at the example in [docs/examples/simple](docs/examples/simple)

## What's supported (and what is not)

| Feature | Version / Vendor | 
| :--- | :---: |
| Kubernetes | v1.13.0<br>*Only upstream kubernetes version is supported* |
| Container runtime | containerd v1.2.0<br>containerd + kata-containers v1.4.0<br>(*docker to be added*) |
| Network layer | Calico<br>(*others to be added*) |
| Ingress controller | Traefik<br>(*Nginx to be added*)|
| [Metallb](https://metallb.universe.tf/) | v0.7.3<br>*Deployed in layer 2 mode* |
| Dashboard | v1.10.0 |
| Metrics | [metrics-server](https://github.com/kubernetes-incubator/metrics-server) |
| Storage | None for now<br>(*Rook and vSphere Cloud Provider to be added*)|
| Package manager | None for now<br>(*Helm to be added*) |
| Install behind Proxy | Not yet supported |
| SSH key based authentication | Not yet supported|

## Deployment configs

Cluster can be adjusted according to your needs

| Variable | Description | Required | Default |
| :------: | :---------- | :------: | :-----: |
| `vs_dc_name` | vSphere datacenter to deploy VMs to | Y | - |
| `vs_cluster_name` | vSphere cluster to deploy VMs to | Y | - |
| `vs_ds_name` | vSphere datastore to deploy VMs to | Y | - |
| `vs_rp_name` | vSphere resource pool to deploy VMs to | Y | - |
| `vs_hosts` | vSphere hosts list to deploy VMs to | Y | - |
| `vs_network_name` | vSphere network to attach VMs to | Y | `VM Network` |
| `vs_vm_folder` | vSphere folder to place VMs in | Y | - |
| `vm_template_name` | Template to use for VMs | Y | - |
| `vm_user` | User to connect to VMs over ssh | Y | - |
| `vm_password` | Password to connect to VMs over ssh | Y | - |
| `dns_servers` | DNS servers for VMs | Y | `192.168.1.1` |
| `domain` | Search DNS domain VMs are going to be attached to | Y | `localdomain` |
| `hv_enabled` | Enable nested hardware virtualization.<br>*Required when using kata-containers* | Y<br>(*only when using<br>kata-containers*)| `false` |
| `ip_gateway` | Gateway IP for the given network | Y | `192.168.1.1`|
| `ip_netmask` | Mask for the given network | Y | `24` |
| `masters` | Key-value list containing master names and IPs | Y | - |
| `master_cpus` | CPUs for master VMs to be created | Y | `1` |
| `master_mem` | Memory in MBs for master VMs to be created | Y | `2048` |
| `master_disk_size` | Disk size in GBs for master VMs to be created.<br>*Cannot be less than VM template used* | Y | `10` |
| `workers` | Key-value list containing worker names and IPs | Y | - |
| `worker_cpus` | CPUs for worker VMs to be created | Y | `2` |
| `worker_mem` | Memory in MBs for worker VMs to be created | Y | `4096` |
| `worker_disk_size` | Disk size in GBs for worker VMs to be created.<br>*Cannot be less than VM template used* | Y | `10` |
| `kubernetes_version`| Kubernetes version to deploy on the cluster | Y | `v1.13.0` |
| `api_server_feature_gates` | API server feature gates to be enabled | N | - |
| `controller_manager_feature_gates` | Controller manager feature gates to be enabled | N | - |
| `kubelet_feature_gates` | Kubelet feature gates to be enabled | N | - |
| `scheduler_feature_gates` | Scheduler feature gates to be enabled | N | - |
| `cri_runtime` | Container runtime interface being used in kubernetes | Y | `containerd` |
| `network_plugin` | Network plugin to be used in kubernetes | Y | `calico` |
| `calico_etcd_ip` | Calico etcd IP to connect to | Y | `10.246.0.20` |
| `provider_enabled`| Enable vSphere cloud provider | N | `false` |
| `use_hyperkube` | Use hyperkube for kubernetes deployment | N | `false` |
| `image_repository` | Registry to pull control plane images from | N | `k8s.gcr.io` |
| `cluster_name` | Kubernetes cluster name | Y | `k8sphere-cluster` |
| `cluster_cidr` | CIDR for kubernetes cluster | Y | `10.244.0.0/16` |
| `pod_subnet` | Subnet for kubernetes pods | Y | `10.245.0.0/24` |
| `service_subnet` | Subnet for kubernetes services | Y | `10.246.0.0/24` |
| `dns_domain` | DNS domain to be used within kubernetes | Y | `cluster.local` |
| `cluster_domain` | Cluster domain to be used within kubernetes | Y | `cluster.local` |
| `metallb_enabled` | Enable Metallb addon | N | `false` |
| `metallb_ip_range` | IP range to be used by Metallb | Y<br>(*When using Metallb*) | - |
| `ingress_enabled` | Enable ingress controller | N | `false` |
| `ingress_controller` | Ingress controller to deploy | Y<br>(*if ingress enabled*) | `traefik` |
| `acme_enabled` | Enable acme<br>*In case traefik is deployed*| Y<br>(*If traefik is ingress*)| - |
| `acme_dns` | DNS vendor to be used for issuing certs<br>*In case traefik is deployed* | Y<br>(*If traefik is ingress*) | - |
| `dashboard_enabled` | Deploy kubernetes dashboard | N | `false` |
| `metrics_enabled` | Deploy metrics server | N | `false` |
