# ApexVirtual - Terraform Infrastructure Platform

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-7c3aed?logo=terraform&logoColor=white)](https://terraform.io)
[![Azure](https://img.shields.io/badge/Azure-Cloud-0078d4?logo=microsoftazure&logoColor=white)](https://azure.microsoft.com)
[![Proxmox](https://img.shields.io/badge/Proxmox-VE-e57000?logo=proxmox&logoColor=white)](https://proxmox.com)
[![Vault](https://img.shields.io/badge/HashiCorp-Vault-000000?logo=vault&logoColor=white)](https://vaultproject.io)

<div align="center">
  <img src="https://github.com/fashomelab/apexvirtual-terraform/actions/workflows/terraform-apexvirtual.yaml/badge.svg" alt="On-Prem CI Status">
  <img src="https://github.com/fashomelab/apexvirtual-terraform/actions/workflows/terraform-av-azure-dev.yaml/badge.svg" alt="Azure Dev CI Status">
  <img src="https://github.com/fashomelab/apexvirtual-terraform/actions/workflows/terraform-av-azure-prod.yaml/badge.svg" alt="Azure Prod CI Status">
</div>

**Production-grade Terraform code for the ApexVirtual Platform - a hybrid-cloud environment showcasing enterprise Platform Engineering patterns.**

---

## 🏆 Key Results & Impact

This infrastructure codebase delivers measurable business value through automation and modern practices:

* **⚡️ 90% Faster Provisioning:** Reduced end-to-end environment creation time from over 90 minutes to under 10 minutes.
* **🛡️ 100% Secretless CI/CD:** Eliminated all static credentials from the pipeline using GitHub OIDC and HashiCorp Vault.
* **⚙️ Multi-Environment Consistency:** Manages 3 distinct environments (`on-prem-prod`, `azure-dev`, `azure-prod`) from a single, modular codebase, ensuring zero configuration drift.
* **☁️ Hybrid Cloud Ready:** Provisions and manages resources across both on-premise (Proxmox) and cloud (Azure) platforms.

---

## 🏗️ Repository Structure

A professional multi-environment layout separating configuration from reusable infrastructure components.

```
apexvirtual-terraform/
├── .github/workflows/                  # Environment-specific CI/CD pipelines
│   ├── terraform-av-onprem.yaml        # On-premises Proxmox infrastructure
│   ├── terraform-av-azure-dev.yaml     # Azure development environment  
│   └── terraform-av-azure-prod.yaml    # Azure production environment
├── bootstrap/                          # One-time Azure backend setup
├── live/                               # Environment configurations
│   ├── av-onprem/                      # On-premises Proxmox platform (20+ VMs)
│   └── av-azure/                       # Azure cloud environments
│       ├── dev/                        # Development: 3-tier web application
│       └── prod/                       # Production: HA configuration
└── modules/                            # Reusable infrastructure components
    ├── azure-rg/                       # Resource group management
    ├── azure-networking/               # VNet, subnets, private DNS
    ├── azure-vm-linux/                 # Linux virtual machines
    ├── azure-database/                 # PostgreSQL flexible servers
    └── azure-storage/                  # Storage accounts and containers
```

---

## ✨ Platform Engineering Capabilities

This repository showcases the implementation of key Platform Engineering principles for infrastructure management.

### Security Architecture
* **Zero-Trust Networking**: Implements private subnets, VLAN segmentation, and security groups.
* **Secrets Management**: Integrates seamlessly with HashiCorp Vault using path-based separation and dedicated policies for each environment.
* **OIDC Authentication**: The CI/CD pipeline leverages a secure, secretless authentication pattern with GitHub's OIDC provider.
* **Least-Privilege Access**: Uses separate, dedicated Vault roles for each CI/CD environment.

### CI/CD & State Management
* **Automated Validation**: Security scanning (`trufflehog`) runs locally via pre-commit hooks before code reaches the repository, while the CI pipeline performs linting (`tflint`) and format validation on all changes.
* **Gated Environments**: Leverages GitHub Environments (`av-onprem-prod`, `av-azure-dev`, etc.) to manage deployments and isolate secrets.
* **Remote State Management**: Utilizes Azure Blob Storage for a secure, remote backend with state locking to prevent conflicts.

<details>
  <summary>Click to view the detailed workflow logic and triggers</summary>

![High-Level Architecture Workflow](images/cicd-pipeline-flowchart.png)

  ### Deployment Flow
  
  **Developer Push → GitHub Event → Workflow Selection → Authentication → Validation → Planning**
  
  Code commit → Branch trigger → Environment-specific → Vault OIDC → TFLint → Terraform Plan
  
  *The pre-commit hook runs a TruffleHog scan locally before the push is ever made.*

  ### Workflow Triggers
  - **av-azure-dev:** Triggers on push to `develop` and pull requests targeting `develop`.
  - **av-azure-prod:** Triggers only on push to `main` for production safety.
  - **av-onprem:** Triggers on push to `develop` and `main`, and on pull requests targeting `develop`.

</details>

### Infrastructure Patterns
* **Modular Design**: All infrastructure is defined in reusable modules following DRY (Don't Repeat Yourself) principles.
* **Data-Driven Infrastructure**: Provisions on-premise VMs from a central YAML data file, separating logic from configuration.
* **Hybrid Cloud**: Manages resources and dependencies across both Proxmox (on-premise) and Azure (cloud) platforms.

---

### 🛠️ Technology Stack

* **Infrastructure as Code**: Terraform
* **Secrets Management**: HashiCorp Vault
* **Cloud Platforms**: Microsoft Azure, Proxmox VE
* **CI/CD**: GitHub Actions

---

## 🚀 Getting Started

This repository serves as a template and a live demonstration of a secure, multi-environment CI/CD workflow.

### Prerequisites
- Terraform 1.13+
- Azure CLI with appropriate permissions
- Access to a Proxmox cluster and HashiCorp Vault

### How to Use

**1. Bootstrap the Backend**
The `bootstrap/` directory contains a one-time setup to create the Azure Storage Account for the Terraform state.
```bash
cd bootstrap/
# Create and populate bootstrap.tfvars from the example
terraform init && terraform apply
```

**2. Explore and Validate Locally**
The primary validation for this repository is the automated CI pipeline. To explore the code locally or adapt it for your own use, you would:

1. Create a local `backend.hcl` file with your backend details.

2. Run `terraform init` to configure the backend.

3. Run `terraform plan` to see the execution plan.

From there, you could adapt the `.tfvars` and `vms.yml` files for your own environment before running an apply.

---

## Professional Context

This platform demonstrates key Platform Engineering competencies:

**Infrastructure as Code**: Advanced Terraform patterns with modules, remote state, and multi-environment management

**Security Engineering**: Zero-trust architecture, secrets management, and secure CI/CD implementation

**Cloud Architecture**: Hybrid cloud design with network segmentation and high-availability patterns

**DevOps Practices**: GitOps workflows, automated testing, and comprehensive monitoring

---

## Portfolio Links

**Main Platform Overview**: [ApexVirtual Platform](https://github.com/fashomelab/corneb) - Complete platform architecture and application deployment

**Configuration Management**: [Ansible Automation](https://github.com/fashomelab/homelab-ansible) - Server configuration and application setup

**Available for Platform Engineering roles** - Remote/Hybrid (Portsmouth UK area)

---

*Infrastructure code powering the ApexVirtual platform - designed to showcase production-ready Platform Engineering practices through practical implementation of enterprise architecture patterns.*