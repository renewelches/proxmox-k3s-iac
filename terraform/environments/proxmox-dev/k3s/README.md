# proxmox-dev / k3s

Terraform stack that provisions a dev k3s cluster (1 server + 2 agents) on Proxmox VE with reduced resource requirements.

## Resources

| VM               | Default vCPU | Default RAM | Default Disk |
|------------------|-------------|-------------|-------------|
| k3s-server-dev   | 2           | 2048 MiB    | 20 GB       |
| k3s-agent-1-dev  | 1           | 1024 MiB    | 20 GB       |
| k3s-agent-2-dev  | 1           | 1024 MiB    | 20 GB       |

## Backend

State is stored locally. Copy `backend.tf.example` to `backend.tf` before running `terraform init`.

```bash
cp backend.tf.example backend.tf
```

## Deploy

```bash
cp terraform.tfvars.example terraform.tfvars   # fill in values
cp backend.tf.example backend.tf
terraform init
terraform apply
```

This generates `ansible/inventory/dev/proxmox/k3s/inventory.ini` automatically.

## Variables

| Variable             | Description                                    | Default      |
|----------------------|------------------------------------------------|-------------|
| `proxmox_api_url`    | Proxmox API URL                                | —            |
| `proxmox_api_token`  | API token (`user@pve!token=uuid`)              | —            |
| `proxmox_nodes`      | Map of VM role → Proxmox node name             | —            |
| `static_ips`         | Map of VM role → CIDR IP                       | —            |
| `k3s_template_ids`   | Map of Proxmox node name → template VM ID      | —            |
| `k3s_server_vcpu`    | vCPU count for server                          | `2`          |
| `k3s_server_memory`  | RAM for server (MiB)                           | `2048`       |
| `k3s_agent_vcpu`     | vCPU count for agents                          | `1`          |
| `k3s_agent_memory`   | RAM for agents (MiB)                           | `1024`       |
| `k3s_disk_size`      | Disk size in GB                                | `20`         |
