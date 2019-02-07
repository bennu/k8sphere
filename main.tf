terraform {
  required_version = ">= 0.11.0"
}

module "vsphere" {
  # interpolation in source not supported yet
  # see: https://github.com/hashicorp/terraform/issues/1439
  # source = "git::https://gitlab.com/ulm0/k8sphere.git//modules/vsphere?ref=${var.ref}"
  source = "./modules/vsphere"

  vm_template_name = "${var.vm_template_name}"
  vs_cluster_name  = "${var.vs_cluster_name}"
  vs_dc_name       = "${var.vs_dc_name}"
  vs_ds_name       = "${var.vs_ds_name}"
  vs_hosts         = "${var.vs_hosts}"
  vs_network_name  = "${var.vs_network_name}"
  vs_rp_name       = "${var.vs_rp_name}"
}

module "vms" {
  # interpolation in source not supported yet
  # see: https://github.com/hashicorp/terraform/issues/1439
  # source = "git::https://gitlab.com/ulm0/k8sphere.git//modules/vms?ref=${var.ref}"
  source = "./modules/vms"

  adapter_type       = "${module.vsphere.interface_type_ids[0]}"
  ds_id              = "${module.vsphere.ds_id}"
  guest_id           = "${module.vsphere.template_guest_id}"
  net_id             = "${module.vsphere.net_id}"
  rp_id              = "${module.vsphere.rp_id}"
  template_disk_es   = "${module.vsphere.template_disk_es}"
  template_disk_tp   = "${module.vsphere.template_disk_tp}"
  template_id        = "${module.vsphere.template_id}"
  template_scsi_type = "${module.vsphere.template_scsi_type}"

  dns_servers  = "${var.dns_servers}"
  domain       = "${var.domain}"
  hv_enabled   = "${var.hv_enabled}"
  ip_gateway   = "${var.ip_gateway}"
  ip_netmask   = "${var.ip_netmask}"
  vs_vm_folder = "${var.vs_vm_folder}"
  vm_user      = "${var.vm_user}"
  vm_password  = "${var.vm_password}"

  ##
  # kubernetes
  ##


  # nodes

  master_cpus      = "${var.master_cpus}"
  master_disk_size = "${local.master_disk_size}"
  master_mem       = "${var.master_mem}"
  masters          = "${var.masters}"
  worker_cpus      = "${var.worker_cpus}"
  worker_disk_size = "${local.worker_disk_size}"
  worker_mem       = "${var.worker_mem}"
  workers          = "${var.workers}"

  # settings

  kubernetes_version               = "${var.kubernetes_version}"
  control_plane_port               = "${var.control_plane_port}"
  api_server_certs_sans            = "${var.api_server_certs_sans}"
  api_server_feature_gates         = "${var.api_server_feature_gates}"
  controller_manager_feature_gates = "${var.controller_manager_feature_gates}"
  kubelet_feature_gates            = "${var.kubelet_feature_gates}"
  scheduler_feature_gates          = "${var.scheduler_feature_gates}"
  cri_runtime                      = "${var.cri_runtime}"
  network_plugin                   = "${var.network_plugin}"
  calico_etcd_ip                   = "${var.calico_etcd_ip}"
  provider_enabled                 = "${var.provider_enabled}"
  use_hyperkube                    = "${var.use_hyperkube}"
  image_repository                 = "${var.image_repository}"
  cluster_name                     = "${var.cluster_name}"
  cluster_cidr                     = "${var.cluster_cidr}"
  pod_subnet                       = "${var.pod_subnet}"
  service_subnet                   = "${var.service_subnet}"
  dns_domain                       = "${var.dns_domain}"
  cluster_domain                   = "${var.cluster_domain}"

  # addons

  metallb_enabled             = "${var.metallb_enabled}"
  metallb_ip_range            = "${var.metallb_ip_range}"
  ingress_enabled             = "${var.ingress_enabled}"
  ingress_controller          = "${var.ingress_controller}"
  ingress_controller_replicas = "${var.ingress_controller_replicas}"
  acme_enabled                = "${var.acme_enabled}"
  acme_email                  = "${var.acme_email}"
  acme_dns                    = "${var.acme_dns}"
  dashboard_enabled           = "${var.dashboard_enabled}"
  metrics_enabled             = "${var.metrics_enabled}"
  rook_enabled                = "${var.rook_enabled}"
}
