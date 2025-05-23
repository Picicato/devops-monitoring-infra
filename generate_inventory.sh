#!/bin/bash

# Récupérer l'IP depuis Terraform
IP=$(terraform output -raw public_ip -chdir=terraform-aws 2>/dev/null)

# Vérifier que l'IP n'est pas vide
if [[ -z "$IP" ]]; then
  echo "Error: Terraform output public_ip is empty or command failed"
  exit 1
fi

# Créer le fichier d'inventaire Ansible
cat > terraform-aws/ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $IP"
