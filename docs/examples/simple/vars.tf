# Provider vars from env TF_user, TF_password. TF_server
# or comment out user, password and server
# and pass values from env vars VSPHERE_SERVER, VSPHERE_USER, VSPHERE_PASSWORD

variable "server" {}
variable "user" {}
variable "password" {}
variable "domain" {}

variable "masters" {
  type = "map"
}

variable "vm_template_name" {}
variable "vs_cluster_name" {}
variable "vs_dc_name" {}
variable "vs_ds_name" {}

variable "vs_hosts" {
  type = "list"
}

variable "vs_rp_name" {}
variable "vs_vm_folder" {}
variable "vm_user" {}
variable "vm_password" {}

variable "workers" {
  type = "map"
}
