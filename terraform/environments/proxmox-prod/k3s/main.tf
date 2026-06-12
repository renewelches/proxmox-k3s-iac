provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_tls_insecure
}

locals {
  server_ip = split("/", var.static_ips.k3s_server)[0]
  agent1_ip = split("/", var.static_ips.k3s_agent1)[0]
  agent2_ip = split("/", var.static_ips.k3s_agent2)[0]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../../../../ansible/inventory/prod/k3s/inventory.tpl", {
    server_ip = local.server_ip
    agent1_ip = local.agent1_ip
    agent2_ip = local.agent2_ip
    ci_user   = var.ci_user
  })
  filename        = "${path.module}/../../../../ansible/inventory/prod/k3s/inventory.ini"
  file_permission = "0600"
}

module "vm_k3s-server" {
  #source = "/Users/rene/Documents/Workspace/terraform-bpg-proxmox/modules/vm-clone"
  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_server                       # required
  vm_id            = var.k3s_server_vm_id                               # required
  vm_name          = "k3s-server"                                       # optional
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_server] # required
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
    }
  ]
  vcpu   = var.k3s_server_vcpu
  memory = var.k3s_server_memory

  # Network bridge + optional VLAN tag (per node, falls back to a flat vmbr0). See variables.tf.
  vnic_bridge = lookup(var.k3s_bridges, "k3s_server", var.default_bridge)
  vlan_tag    = lookup(var.k3s_vlan_tags, "k3s_server", null)

  ci_datastore_id = var.file-system
  ci_ipv4_cidr    = var.static_ips.k3s_server
  ci_ipv4_gateway = var.gateway
  ci_user         = var.ci_user
  ci_ssh_key      = var.ci_ssh_key

  # wait_for_ip_ipv4 = false
  # wait_for_ip_ipv6 = false

  # timeout_clone       = 1800
  # timeout_create      = 1800
  # timeout_migrate     = 1800
  # timeout_reboot      = 1800
  # timeout_shutdown_vm = 1800
  # timeout_start_vm    = 1800
  # timeout_stop_vm     = 300

}

module "vm_k3s-agent-1" {
  #source = "/Users/rene/Documents/Workspace/terraform-bpg-proxmox/modules/vm-clone"
  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_agent1                       # required
  vm_id            = var.k3s_agent1_vm_id                               # required
  vm_name          = "k3s-agent-1"                                      # optional
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_agent1] # required
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
    }
  ]
  vcpu   = var.k3s_agent_vcpu
  memory = var.k3s_agent_memory

  # Network bridge + optional VLAN tag (per node, falls back to a flat vmbr0). See variables.tf.
  vnic_bridge = lookup(var.k3s_bridges, "k3s_agent1", var.default_bridge)
  vlan_tag    = lookup(var.k3s_vlan_tags, "k3s_agent1", null)

  ci_datastore_id = var.file-system
  ci_ipv4_cidr    = var.static_ips.k3s_agent1
  ci_ipv4_gateway = var.gateway
  ci_user         = var.ci_user
  ci_ssh_key      = var.ci_ssh_key
}

module "vm_k3s-agent-2" {

  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_agent2                       # required
  vm_id            = var.k3s_agent2_vm_id                               # required
  vm_name          = "k3s-agent-2"                                      # optional
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_agent2] # required
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
    }
  ]
  vcpu   = var.k3s_agent_vcpu
  memory = var.k3s_agent_memory

  # Network bridge + optional VLAN tag (per node, falls back to a flat vmbr0). See variables.tf.
  vnic_bridge = lookup(var.k3s_bridges, "k3s_agent2", var.default_bridge)
  vlan_tag    = lookup(var.k3s_vlan_tags, "k3s_agent2", null)

  ci_datastore_id = var.file-system
  ci_ipv4_cidr    = var.static_ips.k3s_agent2
  ci_ipv4_gateway = var.gateway
  ci_user         = var.ci_user
  ci_ssh_key      = var.ci_ssh_key
}
