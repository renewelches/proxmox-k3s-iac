output "k3s_server_id" {
  description = "VM ID of the k3s server"
  value       = module.vm_k3s-server.id
}

output "k3s_server_ipv4" {
  description = "Public IPv4 address of the k3s server"
  value       = module.vm_k3s-server.public_ipv4
}

output "k3s_agent1_id" {
  description = "VM ID of k3s agent-1"
  value       = module.vm_k3s-agent-1.id
}

output "k3s_agent1_ipv4" {
  description = "Public IPv4 address of k3s agent-1"
  value       = module.vm_k3s-agent-1.public_ipv4
}

output "k3s_agent2_id" {
  description = "VM ID of k3s agent-2"
  value       = module.vm_k3s-agent-2.id
}

output "k3s_agent2_ipv4" {
  description = "Public IPv4 address of k3s agent-2"
  value       = module.vm_k3s-agent-2.public_ipv4
}
