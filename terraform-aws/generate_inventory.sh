#!/bin/bash

# Sortie dès qu'une commande échoue
set -e

# Aller dans le bon dossier terraform
cd terraform-aws || { echo "❌ Le dossier terraform-aws est introuvable."; exit 1; }

# Extraire l'IP publique de l'instance EC2
IP=$(terraform output -raw public_ip)

# Vérifier si on a bien une IP
if [ -z "$IP" ]; then
  echo "❌ Échec : IP publique non récupérée depuis Terraform."
  exit 1
fi

# Remonter au dossier racine et créer le dossier ansible s'il n'existe pas
cd ..
mkdir -p ansible

# Générer le fichier d'inventaire Ansible
cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-key
EOF

echo "✅ Inventory file generated with IP: $IP"
