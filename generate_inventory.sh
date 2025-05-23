#!/bin/bash

IP=$(awk '/public_ip/ {gsub(/"/, "", $3); print $3}' terraform-aws/apply_output.txt)

# Vérification
if [[ -z "$IP" ]]; then
  echo "❌ Impossible de récupérer l'adresse IP depuis apply_output.txt"
  exit 1
fi

echo "✅ IP extraite : $IP"

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "✅ Inventory file generated with IP: $IP"
