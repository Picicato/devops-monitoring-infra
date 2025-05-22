#!/bin/bash

IP=$(cd terraform-aws && terraform output -raw public_ip)

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-key
EOF

echo "Inventory file generated with IP: $IP"
