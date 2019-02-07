variable "adapter_type" {}

variable "dns_servers" {
  type = "list"
}

variable "domain" {}
variable "ds_id" {}
variable "guest_id" {}

variable "hv_enabled" {
  description = "Enable nested hardware virtualization, required when using kata-containers"
}

variable "ip_gateway" {}
variable "ip_netmask" {}
variable "master_cpus" {}
variable "master_mem" {}
variable "master_disk_size" {}

variable "masters" {
  type = "map"
}

variable "net_id" {}
variable "rp_id" {}
variable "template_disk_es" {}
variable "template_disk_tp" {}
variable "template_id" {}
variable "template_scsi_type" {}
variable "vm_user" {}
variable "vm_password" {}
variable "vs_vm_folder" {}
variable "worker_cpus" {}
variable "worker_mem" {}
variable "worker_disk_size" {}

variable "workers" {
  type = "map"
}

# Kubernetes ansible vars

variable "kubernetes_version" {}

variable "control_plane_port" {}

# variable "api_server_certs_sans" {
#   type = "list"
# }

variable "api_server_feature_gates" {}
variable "controller_manager_feature_gates" {}
variable "kubelet_feature_gates" {}
variable "scheduler_feature_gates" {}
variable "cri_runtime" {}
variable "network_plugin" {}
variable "calico_etcd_ip" {}
variable "provider_enabled" {}
variable "use_hyperkube" {}
variable "image_repository" {}
variable "cluster_name" {}
variable "cluster_cidr" {}
variable "pod_subnet" {}
variable "service_subnet" {}
variable "dns_domain" {}
variable "cluster_domain" {}

# addons

variable "metallb_enabled" {}
variable "metallb_ip_range" {}
variable "ingress_enabled" {}
variable "ingress_controller" {}
variable "ingress_controller_replicas" {}
variable "acme_enabled" {}
variable "acme_email" {}
variable "acme_dns" {}
variable "dashboard_enabled" {}
variable "metrics_enabled" {}
variable "rook_enabled" {}
