[k3s_server]
k3s-server ansible_host=${server_ip}

[k3s_agents]
k3s-agent-1 ansible_host=${agent1_ip}
k3s-agent-2 ansible_host=${agent2_ip}

[all:vars]
ansible_user=${ci_user}
ansible_python_interpreter=/usr/bin/python3
k3s_server_ip=${server_ip}
