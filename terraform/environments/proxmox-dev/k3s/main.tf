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
  content = templatefile("${path.module}/../../../../ansible/inventory/dev/proxmox/k3s/inventory.tpl", {
    server_ip = local.server_ip
    agent1_ip = local.agent1_ip
    agent2_ip = local.agent2_ip
  })
  filename        = "${path.module}/../../../../ansible/inventory/dev/proxmox/k3s/inventory.ini"
  file_permission = "0600"
}

module "vm_k3s-server" {
  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_server
  vm_id            = var.k3s_server_vm_id
  vm_name          = "k3s-server-dev"
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_server]
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
  }]
  vcpu   = var.k3s_server_vcpu
  memory = var.k3s_server_memory

  ci_datastore_id  = var.file-system
  ci_ipv4_cidr     = var.static_ips.k3s_server
  ci_ipv4_gateway  = var.gateway
  ci_user          = var.ci_user
  ci_ssh_key       = var.ci_ssh_key
}

module "vm_k3s-agent-1" {
  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_agent1
  vm_id            = var.k3s_agent1_vm_id
  vm_name          = "k3s-agent-1-dev"
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_agent1]
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
  }]
  vcpu   = var.k3s_agent_vcpu
  memory = var.k3s_agent_memory

  ci_datastore_id  = var.file-system
  ci_ipv4_cidr     = var.static_ips.k3s_agent1
  ci_ipv4_gateway  = var.gateway
  ci_user          = var.ci_user
  ci_ssh_key       = var.ci_ssh_key
}

module "vm_k3s-agent-2" {
  source           = "github.com/trfore/terraform-bpg-proxmox//modules/vm-clone"
  node             = var.proxmox_nodes.k3s_agent2
  vm_id            = var.k3s_agent2_vm_id
  vm_name          = "k3s-agent-2-dev"
  template_id      = var.k3s_template_ids[var.proxmox_nodes.k3s_agent2]
  efi_disk_storage = var.file-system
  disks = [{
    disk_interface = var.k3s_disk_interface,
    disk_storage   = var.file-system,
    disk_size      = var.k3s_disk_size
  }]
  vcpu   = var.k3s_agent_vcpu
  memory = var.k3s_agent_memory

  ci_datastore_id  = var.file-system
  ci_ipv4_cidr     = var.static_ips.k3s_agent2
  ci_ipv4_gateway  = var.gateway
  ci_user          = var.ci_user
  ci_ssh_key       = var.ci_ssh_key
}
