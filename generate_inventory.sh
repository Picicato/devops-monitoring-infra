#!/bin/bash

IP=$(terraform output -raw public_ip)

echo "Inventory file generated with IP: $IP"

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF
