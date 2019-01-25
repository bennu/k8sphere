server = "vcenter.domain.local"
user = "administrator@vsphere.local"
password = "superpassword"
domain = "domain.local"
vs_cluster_name = "Cluster1"
vs_dc_name = "Datacenter1"
vs_ds_name = "datastore1"
vs_vm_folder = "kubernetes"
vm_user = "root"
vm_password = "k8sphere"
vs_hosts = [
  "esxi.domain.local",
]
vs_rp_name = "MyResourcePool"
vs_network_name = "VM Network"
vm_template_name = "xenial_kubernetes"
masters = {
    master1 = "192.168.1.10"
}
workers = {
    worker1 = "192.168.1.20"
    worker2 = "192.168.1.21"
    worker3 = "192.168.1.22"
    worker4 = "192.168.1.23"
}