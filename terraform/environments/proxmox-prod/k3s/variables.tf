variable "proxmox_api_url" {
  description = "Proxmox API URL (e.g., https://proxmox.example.com:8006/api2/json)"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API Token, use environment variable or secure vault (e.g. terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Skip TLS verification (set to true for self-signed certificates)"
  type        = bool
  default     = false
}

variable "proxmox_nodes" {
  description = "Target Proxmox node names per container (keys: openwebui, searxng, n8n)"
  type        = map(string)
}

variable "proxmox_host_default_pwd" {
  description = "The root user password for the host"
  type        = string
  sensitive   = true
}

variable "static_ips" {
  description = "Map of static IP addresses in CIDR for resources"
  type        = map(string)
}

variable "file-system" {
  description = "The default file system to be used for the container or VM"
  type        = string
  default     = "local-zfs"
}

variable "template_file_id" {
  description = "The Proxmox template file ID for LXC containers (e.g., pve-cluster:vztmpl/debian13-docker-template.tar.gz)"
  type        = string
}

variable "k3s_server_vm_id" {
  description = "VM ID for the k3s server node"
  type        = number
  default     = 1000
}

variable "k3s_agent1_vm_id" {
  description = "VM ID for the k3s agent-1 node"
  type        = number
  default     = 1001
}

variable "k3s_agent2_vm_id" {
  description = "VM ID for the k3s agent-2 node"
  type        = number
  default     = 1002
}

variable "k3s_template_ids" {
  description = "Map of Proxmox node name to template VM ID (e.g., { pve1 = 110, pve2 = 110, pve3 = 115 })"
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
  default     = 2
}

variable "k3s_agent_memory" {
  description = "Memory in MiB for k3s agent nodes"
  type        = number
  default     = 2048
}

variable "k3s_disk_interface" {
  description = "Disk interface for k3s nodes (e.g., scsi0, virtio0)"
  type        = string
  default     = "scsi0"
}

variable "k3s_disk_size" {
  description = "Disk size in GB for k3s nodes"
  type        = number
  default     = 50
}

variable "ci_user" {
  description = "Cloud-init username for the VMs"
  type        = string
  default     = "rene"
}

variable "gateway" {
  description = "Default gateway IP for all k3s VMs"
  type        = string
  default     = "192.168.86.1"
}

variable "ci_ssh_key" {
  description = "Path to SSH public key file to authorize on the debian user (e.g. ~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "os_type" {
  description = "The operating system type for LXC containers (e.g., debian, ubuntu, centos)"
  type        = string
  default     = "debian"
}
