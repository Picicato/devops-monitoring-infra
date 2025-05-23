#!/bin/bash
set -e

# Le script est lancé depuis la racine du repo

IP=$(terraform output -raw public_ip -chdir=terraform-aws)

mkdir -p ansible

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $IP"
