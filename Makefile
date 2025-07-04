.PHONY: plan apply destroy sync-app sync-monitoring deploy-app deploy-monitoring healthcheck help

# Get EC2 public IP from Terraform output
EC2_IP := $(shell cd terraform && terraform output -raw ec2_public_ip)

# -------- Terraform Infra Management --------

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy

# -------- File Sync to EC2 --------

sync-app:
	scp -i ~/.ssh/devops-key.pem -r ./app ec2-user@$(EC2_IP):~/

sync-monitoring:
	scp -i ~/.ssh/devops-key.pem -r ./monitoring ec2-user@$(EC2_IP):~/

# -------- Remote Deployment --------

deploy-app:
	ssh -i ~/.ssh/devops-key.pem ec2-user@$(EC2_IP) 'cd ~/app && docker build -t usama-flask-app . && docker stop $$(docker ps -q --filter ancestor=usama-flask-app) 2>/dev/null || true && docker rm $$(docker ps -q --filter ancestor=usama-flask-app) 2>/dev/null || true && docker run -d -p 80:5000 usama-flask-app'

deploy-monitoring:
	ssh -i ~/.ssh/devops-key.pem ec2-user@$(EC2_IP) 'cd ~/monitoring && docker-compose down && docker-compose build && docker-compose up -d'

# -------- Healthcheck (App) --------

healthcheck:
	curl -I http://$(EC2_IP)

# -------- Help --------

help:
	@echo ""
	@echo "DevOps Automation Shortcuts:"
	@echo ""
	@echo "plan               - Terraform plan"
	@echo "apply              - Terraform apply (provision infra)"
	@echo "destroy            - Terraform destroy (teardown infra)"
	@echo "sync-app           - Copy app/ to EC2"
	@echo "sync-monitoring    - Copy monitoring/ to EC2"
	@echo "deploy-app         - Build and run Flask app on EC2"
	@echo "deploy-monitoring  - Build and run monitoring stack (Prometheus & Grafana) on EC2"
	@echo "healthcheck        - Quick HTTP check if app is running"
	@echo "help               - Show this help"
	@echo ""
	@echo "All commands automatically fetch the EC2 public IP from Terraform output."
	@echo "Make sure to run 'make apply' first to provision the infrastructure."
	@echo ""