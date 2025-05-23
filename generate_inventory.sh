#!/bin/bash

IP=$(terraform output -raw public_ip -chdir=terraform-aws)

echo "DEBUG: IP raw value: '$IP'" >&2

# Nettoyer les caractères de contrôle (ex: séquences ANSI)
CLEAN_IP=$(echo "$IP" | sed 's/[^[:print:]\t]//g')

echo "DEBUG: IP cleaned value: '$CLEAN_IP'" >&2

if [[ -z "$CLEAN_IP" ]]; then
  echo "Error: IP is empty after cleaning" >&2
  exit 1
fi

cat > terraform-aws/ansible/inventory <<EOF
[devops-instance]
$CLEAN_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $CLEAN_IP"
