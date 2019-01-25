output "cluster_id" {
  value = "${data.vsphere_compute_cluster.cluster.id}"
}

output "dc_id" {
  value = "${data.vsphere_datacenter.dc.id}"
}

output "ds_id" {
  value = "${data.vsphere_datastore.ds.id}"
}

output "interface_type_ids" {
  value = ["${data.vsphere_virtual_machine.template.network_interface_types}"]
}

output "net_id" {
  value = "${data.vsphere_network.net.id}"
}

output "rp_id" {
  value = "${data.vsphere_resource_pool.pool.id}"
}

output "template_disk_es" {
  value = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
}

output "template_disk_size" {
  value = "${data.vsphere_virtual_machine.template.disks.0.size}"
}

output "template_disk_tp" {
  value = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
}

output "template_guest_id" {
  value = "${data.vsphere_virtual_machine.template.guest_id}"
}

output "template_id" {
  value = "${data.vsphere_virtual_machine.template.id}"
}

output "template_scsi_type" {
  value = "${data.vsphere_virtual_machine.template.scsi_type}"
}
