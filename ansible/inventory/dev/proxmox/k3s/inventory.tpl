[k3s_server]
k3s-server-dev ansible_host=${server_ip}

[k3s_agents]
k3s-agent-1-dev ansible_host=${agent1_ip}
k3s-agent-2-dev ansible_host=${agent2_ip}

[all:vars]
ansible_user=debian
ansible_python_interpreter=/usr/bin/python3
k3s_server_ip=${server_ip}
