# 🚀 Usama’s DevOps Platform Portfolio

A complete, reproducible DevOps showcase that provisions cloud infrastructure, deploys a real containerised Python app, sets up monitoring with Prometheus & Grafana, and even auto-loads dashboards and data sources—**all automated and managed via a simple Makefile.**

---

## ⭐️ Features

- **Infrastructure as Code** with Terraform (AWS VPC, EC2, Security Groups)
- **Containerised Python Flask App** with Docker
- **Monitoring** with Prometheus (live metrics)
- **Dashboards** in Grafana—auto-provisioned, no manual setup needed
- **All automation via a single Makefile**—no hidden steps
- **Fully cloud-native, ready for interview or production demos**

---

## 📝 Requirements / Prerequisites

- **AWS Account** (with permission to create EC2, VPC, etc.)
- **AWS CLI** installed & configured (`aws configure`)
- **Terraform** installed ([install guide](https://developer.hashicorp.com/terraform/downloads))
- **Docker** installed (locally, for building images and using Compose—optional for local-only setup)
- **SSH key** for AWS EC2 (you’ll use this to connect to your cloud instance)
- **[Optional]** Mac, Linux, or WSL recommended for easy scripting

---

## 📦 Setup Instructions (Just Copy These Commands)

### 1. Clone the Repo

```bash
git clone https://github.com/usama-elojali/platform-infra-showcase.git
cd platform-infra-showcase
```

### 2. Configure AWS Credentials

If you haven’t already:

```bash
aws configure
```

### 3. Provision Infrastructure

```bash
make apply
```
This will use Terraform to spin up all required AWS resources.

### 4. Deploy App and Monitoring Stack
Copy your app and monitoring folders, then deploy containers:

```bash
make sync-app
make sync-monitoring
make deploy-app
make deploy-monitoring
```
Wait 2–3 minutes after infra is provisioned to let the EC2 instance install Docker & Compose via user_data.

### 5. Health Check & Find Your URLs
Check that your app is up and get all important URLs:

```bash
make healthcheck
make show-urls
```

### 6. View Your Platform
Flask App UI: ```http://<your-ec2-ip>/```

Prometheus: ```http://<your-ec2-ip>:9090```

Grafana: ```http://<your-ec2-ip>:3000```
(Login: ```admin```/```admin``` by default)

Dashboards and Prometheus datasource are auto-loaded on Grafana’s first start!

### 7. Cleanup
When done (to save cloud costs):

```bash
make destroy
```

## 🛠️ What’s Inside
```
terraform/           # All infra code (VPC, EC2, SG, outputs)
app/                 # Python Flask app (with Prometheus metrics)
monitoring/
  ├─ docker-compose.yml      # Orchestrates the app, Prometheus, and Grafana
  ├─ prometheus.yml          # Prometheus config (auto-scrapes Flask app)
  └─ grafana/
       ├─ provisioning/
       │    ├─ dashboards/   # Dashboard provisioning YAML
       │    └─ datasources/  # Data source provisioning YAML
       └─ dashboards/        # Dashboard JSONs (auto-loaded)
Makefile              # All automation shortcuts (infra, deploy, URLs, health check, destroy, help)
```

## ❓ FAQ / Troubleshooting
- **Docker not found on EC2?**
Wait 2–3 min after instance launch—Docker & Compose install via Terraform ```user_data```.

- **Metrics not showing in Grafana?**
Make sure you hit the app (```curl http://<ec2-ip>/```), refresh dashboard, and that Prometheus is the data source.

- **YAML errors?**
Double-check spacing—YAML is space-sensitive!

- **AWS costs?**
Don’t forget to ```make destroy``` when you’re done!

## 🏆 Why This Project?
Most CVs list “DevOps” skills—this repo proves it:

- *Infrastructure as code*

- *Automated build, deploy, monitoring, and dashboards*

- *All reproducible by anyone in a few commands*

## 📬 Contact
Want to know more? Feedback? DM me on [LinkedIn!](https://www.linkedin.com/in/usama-elojali/)

Happy automating!
