resource "vsphere_virtual_machine" "masters" {
  count               = "${length(keys(var.masters))}"
  name                = "${element(keys(var.masters),count.index)}"
  datastore_id        = "${var.ds_id}"
  resource_pool_id    = "${var.rp_id}"
  num_cpus            = "${var.master_cpus}"
  memory              = "${var.master_mem}"
  guest_id            = "${var.guest_id}"
  folder              = "${var.vs_vm_folder}"
  latency_sensitivity = "normal"
  scsi_type           = "${var.template_scsi_type}"
  nested_hv_enabled   = "${var.hv_enabled}"

  disk {
    label            = "disk0"
    size             = "${var.master_disk_size}"
    eagerly_scrub    = "${var.template_disk_es}"
    thin_provisioned = "${var.template_disk_tp}"
  }

  network_interface {
    network_id   = "${var.net_id}"
    adapter_type = "${var.adapter_type}"
  }

  clone {
    template_uuid = "${var.template_id}"

    customize {
      timeout = 20

      linux_options {
        host_name = "${element(keys(var.masters),count.index)}"
        domain    = "${var.domain}"
      }

      network_interface {
        ipv4_address = "${element(values(var.masters),count.index)}"
        ipv4_netmask = "${var.ip_netmask}"
      }

      dns_server_list = "${var.dns_servers}"
      dns_suffix_list = ["${var.domain}"]
      ipv4_gateway    = "${var.ip_gateway}"
    }
  }

  connection {
    type     = "ssh"
    user     = "${var.vm_user}"
    password = "${var.vm_password}"

    # private_key = "${file("~/.ssh/server.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'SERVICE=kubernetes' >> /etc/environment",
      "echo 'TYPE=master' >> /etc/environment",
    ]
  }

  provisioner "ansible" {
    plays {
      playbook = {
        file_path = "${path.module}/provision/playbooks/kubernetes.yml"

        roles_path = [
          "${path.module}/provision/roles/",
        ]
      }

      extra_vars {
        kubernetes_version = "${var.kubernetes_version}"

        control_plane_port = "${var.control_plane_port}"

        # api_server_certs_sans            = "${var.api_server_certs_sans}"
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

        cluster_name   = "${var.cluster_name}"
        cluster_cidr   = "${var.cluster_cidr}"
        pod_subnet     = "${var.pod_subnet}"
        service_subnet = "${var.service_subnet}"

        dns_domain     = "${var.dns_domain}"
        cluster_domain = "${var.cluster_domain}"

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

      diff    = true
      verbose = true
    }

    remote {
      skip_install = true
      use_sudo     = false
    }
  }
}

resource "vsphere_virtual_machine" "workers" {
  depends_on          = ["vsphere_virtual_machine.masters"]
  count               = "${length(keys(var.workers))}"
  name                = "${element(keys(var.workers),count.index)}"
  datastore_id        = "${var.ds_id}"
  resource_pool_id    = "${var.rp_id}"
  num_cpus            = "${var.worker_cpus}"
  memory              = "${var.worker_mem}"
  guest_id            = "${var.guest_id}"
  folder              = "${var.vs_vm_folder}"
  latency_sensitivity = "normal"
  scsi_type           = "${var.template_scsi_type}"
  nested_hv_enabled   = "${var.hv_enabled}"

  disk {
    label            = "disk0"
    size             = "${var.worker_disk_size}"
    eagerly_scrub    = "${var.template_disk_es}"
    thin_provisioned = "${var.template_disk_tp}"
  }

  network_interface {
    network_id   = "${var.net_id}"
    adapter_type = "${var.adapter_type}"
  }

  clone {
    template_uuid = "${var.template_id}"

    customize {
      timeout = 20

      linux_options {
        host_name = "${element(keys(var.workers),count.index)}"
        domain    = "${var.domain}"
      }

      network_interface {
        ipv4_address = "${element(values(var.workers),count.index)}"
        ipv4_netmask = "${var.ip_netmask}"
      }

      dns_server_list = "${var.dns_servers}"
      dns_suffix_list = ["${var.domain}"]
      ipv4_gateway    = "${var.ip_gateway}"
    }
  }

  connection {
    type     = "ssh"
    user     = "${var.vm_user}"
    password = "${var.vm_password}"

    # private_key = "${file("~/.ssh/server.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'SERVICE=kubernetes' >> /etc/environment",
      "echo 'TYPE=worker' >> /etc/environment",
    ]
  }

  provisioner "ansible" {
    plays {
      playbook = {
        file_path = "${path.module}/provision/playbooks/kubernetes.yml"

        roles_path = [
          "${path.module}/provision/roles/",
        ]
      }

      extra_vars {
        control_plane_port     = "${var.control_plane_port}"
        kubelet_feature_gates  = "${var.kubelet_feature_gates}"
        cri_runtime            = "${var.cri_runtime}"
        cluster_name           = "${var.cluster_name}"
        first_cp_node_ip       = "${vsphere_virtual_machine.masters.0.default_ip_address}"
        first_cp_node_password = "${var.vm_password}"
      }

      diff    = true
      verbose = true
    }

    remote {
      skip_install = true
      use_sudo     = false
    }
  }
}

data "external" "kubeconfig" {
  depends_on = ["vsphere_virtual_machine.masters"]
  program    = ["bash", "${path.module}/utils/kubeconfig"]

  query = {
    control_plane_node = "${element(values(var.masters),0)}"
    user               = "${var.vm_user}"
    password           = "${var.vm_password}"
  }
}
