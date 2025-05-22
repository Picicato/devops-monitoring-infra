# DevOps Infrastructure Automation (Terraform + Ansible + Docker Monitoring)

Projet personnel DevOps pour automatiser l'infrastructure cloud et déployer une stack de monitoring avec **Prometheus** et **Grafana**.

## ⚙️ Stack technique

- **Terraform** pour provisionner une instance AWS EC2
- **Ansible** pour configurer Docker, Prometheus, Grafana
- **Docker Compose** pour la stack monitoring
- **Grafana** pour visualiser les métriques de node_exporter
- **GitHub Actions** pour CI/CD

## 🚀 Déploiement

```bash
cd terraform-aws
terraform init
terraform apply -auto-approve

./generate_inventory.sh

cd ../ansible
ansible-playbook -i inventory setup-docker.yml

`screenshots/grafana-dashboard.png`
