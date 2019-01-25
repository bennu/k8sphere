data "vsphere_datacenter" "dc" {
  name = "${var.vs_dc_name}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vs_cluster_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vs_rp_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "ds" {
  name          = "${var.vs_ds_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "net" {
  name          = "${var.vs_network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "hosts" {
  count         = "${length(var.vs_hosts)}"
  name          = "${var.vs_hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vm_template_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
