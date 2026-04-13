variable "proxmox_api_url" {
  description = "Proxmox API URL (e.g., https://proxmox.example.com:8006/api2/json)"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token (e.g., terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Skip TLS verification (set to true for self-signed certificates)"
  type        = bool
  default     = false
}

variable "proxmox_nodes" {
  description = "Target Proxmox node names per VM (keys: k3s_server, k3s_agent1, k3s_agent2)"
  type        = map(string)
}

variable "static_ips" {
  description = "Map of static IP addresses in CIDR notation (keys: k3s_server, k3s_agent1, k3s_agent2)"
  type        = map(string)
}

variable "file-system" {
  description = "Datastore ID for VM disks and EFI"
  type        = string
  default     = "local-zfs"
}

variable "k3s_server_vm_id" {
  description = "VM ID for the k3s server node"
  type        = number
  default     = 2000
}

variable "k3s_agent1_vm_id" {
  description = "VM ID for k3s agent-1"
  type        = number
  default     = 2001
}

variable "k3s_agent2_vm_id" {
  description = "VM ID for k3s agent-2"
  type        = number
  default     = 2002
}

variable "k3s_template_ids" {
  description = "Map of Proxmox node name to template VM ID (e.g., { pve1 = 110, pve2 = 111 })"
  type        = map(number)
}

variable "k3s_server_vcpu" {
  description = "Number of CPU cores for the k3s server node"
  type        = number
  default     = 2
}

variable "k3s_server_memory" {
  description = "Memory in MiB for the k3s server node"
  type        = number
  default     = 2048
}

variable "k3s_agent_vcpu" {
  description = "Number of CPU cores for k3s agent nodes"
  type        = number
  default     = 1
}

variable "k3s_agent_memory" {
  description = "Memory in MiB for k3s agent nodes"
  type        = number
  default     = 1024
}

variable "k3s_disk_interface" {
  description = "Disk interface for k3s nodes (e.g., scsi0, virtio0)"
  type        = string
  default     = "scsi0"
}

variable "k3s_disk_size" {
  description = "Disk size in GB for k3s nodes"
  type        = number
  default     = 20
}

variable "gateway" {
  description = "Default gateway IP for all k3s VMs"
  type        = string
  default     = "192.168.86.1"
}

variable "ci_user" {
  description = "Cloud-init username for the VMs"
  type        = string
  default     = "rene"
}

variable "ci_ssh_key" {
  description = "Path to SSH public key file to authorize on the debian user (e.g. ~/.ssh/id_ed25519.pub)"
  type        = string
}
