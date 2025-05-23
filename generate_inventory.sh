#!/bin/bash
set -euxo pipefail  # active mode debug + exit on erreur

IP=$(terraform output -raw public_ip -chdir=terraform-aws)

mkdir -p ansible

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $IP"
