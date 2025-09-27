[webserver]
web-server-01 ansible_host=${server_ip} ansible_user=akiva ansible_ssh_private_key_file=~/.ssh/id_ed25519

[all:vars]
ansible_python_interpreter=/usr/bin/python3

