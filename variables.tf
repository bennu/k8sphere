# VM instances
# vSphere cluster
variable "dns_servers" {
  description = "DNS servers for VMs"
  default     = ["192.168.1.1"]
}

variable "domain" {
  description = "Search DNS domain VMs are going to be attached to"
  default     = "localdomain"
}

variable "hv_enabled" {
  description = "Enable nested hardware virtualization, required when using kata-containers"
  default     = false
}

variable "ip_gateway" {
  description = "Gateway IP for the given network"
  default     = "192.168.1.1"
}

variable "ip_netmask" {
  description = "Mask for the given network"
  default     = "24"
}

variable "master_cpus" {
  description = "CPUs for master VMs to be created"
  default     = 1
}

variable "master_mem" {
  description = "Memory in MBs for master VMs to be created"
  default     = 2048
}

variable "master_disk_size" {
  # Defaults cannot contain interpolations ATM
  # https://github.com/hashicorp/terraform/issues/14343
  # default = "${module.vsphere.template_disk_size}"
  description = "Disk size in GBs for master VMs to be created. Cannot be less than VM template used"

  default = 10
}

variable "masters" {
  description = "Key-value list containing master names and IPs"
  type        = "map"
}

# interpolation in source not supported yet
# see: https://github.com/hashicorp/terraform/issues/1439
# variable "ref" {default = "master"}
variable "vm_user" {
  description = "User to connect to VMs over ssh"
}

variable "vm_password" {
  description = "Password to connect to VMs over ssh"
}

variable "vm_template_name" {
  description = "Template to use for VMs"
}

variable "vs_cluster_name" {
  description = "vSphere cluster to deploy VMs to"
}

variable "vs_dc_name" {
  description = "vSphere datacenter to deploy VMs to"
}

variable "vs_ds_name" {
  description = "vSphere datastore to deploy VMs to"
}

variable "vs_hosts" {
  description = "vSphere hosts list to deploy VMs to"
  default     = []
}

variable "vs_network_name" {
  description = "vSphere network to attach VMs to"
  default     = "VM Network"
}

variable "vs_rp_name" {
  description = "vSphere resource pool to deploy VMs to"
}

variable "vs_vm_folder" {
  description = "vSphere folder to place VMs in"
}

variable "worker_cpus" {
  description = "CPUs for worker VMs to be created"
  default     = 2
}

variable "worker_mem" {
  description = "Memory in MBs for worker VMs to be created"
  default     = 4096
}

variable "worker_disk_size" {
  # Defaults cannot contain interpolations ATM
  # https://github.com/hashicorp/terraform/issues/14343
  # default = "${module.vsphere.template_disk_size}"
  description = "Disk size in GBs for worker VMs to be created. Cannot be less than VM template used"

  default = 10
}

variable "workers" {
  description = "Key-value list containing worker names and IPs"
  type        = "map"
}

# Kubernetes ansible vars

variable "kubernetes_version" {
  description = "Kubernetes version to deploy on the cluster"
  default     = "stable"
}

# variable "api_server_certs_sans" {
#   type = "list"

#   default = [
#     "- cluster.local",
#   ]
# }

variable "api_server_feature_gates" {
  description = "API server feature gates to be enabled"
  default = ""
}

variable "controller_manager_feature_gates" {
  description = "Controller manager feature gates to be enabled"
  default = ""
}

variable "kubelet_feature_gates" {
  description = "Kubelet feature gates to be enabled"
  default = ""
}

variable "scheduler_feature_gates" {
  description = "Scheduler feature gates to be enabled"
  default = ""
}

variable "cri_runtime" {
  description = "Container runtime interface being used in kubernetes"
  default     = "containerd"
}

variable "network_plugin" {
  description = "Network plugin to be used in kubernetes"
  default     = "calico"
}

variable "calico_etcd_ip" {
  description = "Calico etcd IP to connect to"
  default     = "10.246.0.20"
}

variable "provider_enabled" {
  description = "Enable vSphere cloud provider"
  default     = false
}

variable "use_hyperkube" {
  description = "Use hyperkube for kubernetes deployment"
  default     = "false"
}

variable "image_repository" {
  description = "Registry to pull control plane images from"
  default     = "k8s.gcr.io"
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  default     = "k8sphere-cluster"
}

variable "cluster_cidr" {
  description = "CIDR for kubernetes cluster"
  default     = "10.244.0.0/16"
}

variable "pod_subnet" {
  description = "Subnet for kubernetes pods"
  default     = "10.245.0.0/24"
}

variable "service_subnet" {
  description = "Subnet for kubernetes services"
  default     = "10.246.0.0/24"
}

variable "dns_domain" {
  description = "DNS domain to be used within kubernetes"
  default     = "cluster.local"
}

variable "cluster_domain" {
  description = "Cluster domain to be used within kubernetes"
  default     = "cluster.local"
}

# addons

variable "metallb_enabled" {
  description = "Enable Metallb addon"
  default     = false
}

variable "metallb_ip_range" {
  description = "IP range to be used by Metallb"
  default     = ""
}

variable "ingress_enabled" {
  description = "Enable ingress controller"
  default     = false
}

variable "ingress_controller" {
  default = "Ingress controller to deploy"
  default = "traefik"
}

variable "acme_enabled" {
  description = "Enable acme, in case traefik is deployed"
  default     = false
}

variable "acme_email" {
  description = "Email to be used for issuing certs, in case traefik is deployed"
  default     = ""
}

variable "acme_dns" {
  description = "DNS vendor to be used for issuing certs, in case traefik is deployed"
  default     = ""
}

variable "dashboard_enabled" {
  description = "Deploy kubernetes dashboard"
  default     = false
}

variable "metrics_enabled" {
  description = "Deploy metrics server"
  default     = false
}
