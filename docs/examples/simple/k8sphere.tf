module "k8sphere" {
  source = "git::https://gitlab.com/bennuteam/k8sphere.git"

  vm_template_name = "${var.vm_template_name}"
  vs_cluster_name  = "${var.vs_cluster_name}"
  vs_dc_name       = "${var.vs_dc_name}"
  vs_ds_name       = "${var.vs_ds_name}"
  vs_hosts         = "${var.vs_hosts}"
  vs_rp_name       = "${var.vs_rp_name}"
  vs_vm_folder     = "${var.vs_vm_folder}"
  vm_user          = "${var.vm_user}"
  vm_password      = "${var.vm_password}"
  domain           = "${var.domain}"

  masters = "${var.masters}"
  workers = "${var.workers}"
}
