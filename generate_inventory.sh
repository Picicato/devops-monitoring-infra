#!/bin/bash

if [[ -s apply_output.txt ]]; then
  echo -e "\n📄 Contenu de apply_output.txt :"
  echo "--------------------------------"
  cat apply_output.txt
  echo "--------------------------------"
else
  echo "⚠️ Fichier apply_output.txt vide ou inexistant."
fi

IP=$(tail -n 1 terraform-aws/apply_output.txt | cut -d '"' -f2)

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
