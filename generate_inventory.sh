#!/bin/bash

echo -e "\n📄 Contenu de apply_output.txt :"
echo "--------------------------------"
cat terraform-aws/apply_output.txt
echo "--------------------------------"

IP=$(tail -n 2 terraform-aws/apply_output.txt | cut -d '"' -f2)

# Vérification
if [[ -z "$IP" ]]; then
  echo "Impossible de récupérer l'adresse IP depuis apply_output.txt"
  exit 1
fi

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $IP"
