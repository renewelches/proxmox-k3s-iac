# proxmox-prod / k3s

Terraform stack that provisions the production k3s cluster (1 server + 2 agents) on Proxmox VE.

## Resources

| VM             | Default vCPU | Default RAM | Default Disk |
|----------------|-------------|-------------|-------------|
| k3s-server     | 4           | 8192 MiB    | 50 GB       |
| k3s-agent-1    | 4           | 8192 MiB    | 50 GB       |
| k3s-agent-2    | 4           | 8192 MiB    | 50 GB       |

## Backend

State is stored in MinIO. Copy `backend.tf.example` to `backend.tf` and fill in your MinIO credentials before running `terraform init`.

```bash
cp backend.tf.example backend.tf
# edit backend.tf: set access_key and secret_key
```

`backend.tf` is git-ignored and must be created locally on each machine.

## Deploy

```bash
cp terraform.tfvars.example terraform.tfvars   # fill in values
cp backend.tf.example backend.tf               # fill in MinIO credentials
terraform init
terraform apply
```

This generates `ansible/inventory/prod/k3s/inventory.ini` automatically.

## Variables

| Variable             | Description                                    | Default      |
|----------------------|------------------------------------------------|-------------|
| `proxmox_api_url`    | Proxmox API URL                                | —            |
| `proxmox_api_token`  | API token (`user@pve!token=uuid`)              | —            |
| `proxmox_nodes`      | Map of VM role → Proxmox node name             | —            |
| `static_ips`         | Map of VM role → CIDR IP                       | —            |
| `k3s_template_ids`   | Map of Proxmox node name → template VM ID      | —            |
| `k3s_server_vcpu`    | vCPU count for server                          | `4`          |
| `k3s_server_memory`  | RAM for server (MiB)                           | `8192`       |
| `k3s_agent_vcpu`     | vCPU count for agents                          | `4`          |
| `k3s_agent_memory`   | RAM for agents (MiB)                           | `8192`       |
| `k3s_disk_size`      | Disk size in GB                                | `50`         |
