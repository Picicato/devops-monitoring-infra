#!/bin/bash

IP=$(awk '/^Outputs:/ {found=1; next} found && /public_ip/ {match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/, ip); print ip[0]; exit}' terraform-aws/apply_output.txt)

cat > ansible/inventory <<EOF
[devops-instance]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated with IP: $IP"

# Pour le debug : afficher le contenu final
echo -e "\n📂 Contenu final de ansible/inventory :"
cat ansible/inventory
