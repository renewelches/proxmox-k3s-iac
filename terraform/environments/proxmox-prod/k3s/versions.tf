# terraform {
#   required_version = ">= 1.0"

#   required_providers {
#     proxmox = {
#       source  = "telmate/proxmox"
#       version = "~> 3.0"
#     }
#   }
# }

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.89.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}
