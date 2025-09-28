# ApexVirtual - Terraform Infrastructure Platform

[![Terraform](https://img.shields.io/badge/Terraform-1.13+-7c3aed?logo=terraform&logoColor=white)](https://terraform.io)
[![Azure](https://img.shields.io/badge/Azure-Cloud-0078d4?logo=microsoftazure&logoColor=white)](https://azure.microsoft.com)
[![Proxmox](https://img.shields.io/badge/Proxmox-VE-e57000?logo=proxmox&logoColor=white)](https://proxmox.com)
[![Vault](https://img.shields.io/badge/HashiCorp-Vault-000000?logo=vault&logoColor=white)](https://vaultproject.io)

**Production-grade Terraform code for the ApexVirtual Platform - a hybrid cloud environment showcasing enterprise Platform Engineering patterns.**

---

## Key Results & Impact

This infrastructure codebase delivers measurable business value through automation and modern practices:

- **90% Faster Provisioning** - Reduced environment deployment from 90+ minutes to under 10 minutes
- **100% Secretless CI/CD** - Eliminated static credentials using GitHub OIDC and HashiCorp Vault
- **Multi-Environment Consistency** - Manages 20+ VMs across hybrid cloud with zero configuration drift
- **Enterprise Security** - Implements network segmentation, secrets management, and least-privilege access

---

## Repository Structure

Professional multi-environment layout separating configuration from reusable infrastructure components:

```
apexvirtual-terraform/
├── .github/workflows/           # Environment-specific CI/CD pipelines
│   ├── terraform-av-onprem.yaml    # On-premises Proxmox infrastructure
│   ├── terraform-av-azure-dev.yaml # Azure development environment  
│   └── terraform-av-azure-prod.yaml# Azure production environment
├── bootstrap/                   # One-time Azure backend setup
├── live/                       # Environment configurations
│   ├── av-onprem/              # On-premises Proxmox platform (20+ VMs)
│   └── av-azure/               # Azure cloud environments
│       ├── dev/                # Development: 3-tier web application
│       └── prod/               # Production: HA configuration
└── modules/                    # Reusable infrastructure components
    ├── azure-rg/               # Resource group management
    ├── azure-networking/       # VNet, subnets, private DNS
    ├── azure-vm-linux/         # Linux virtual machines
    ├── azure-database/         # PostgreSQL flexible servers
    └── azure-storage/          # Storage accounts and containers
```

---

## Platform Engineering Capabilities

### Security Architecture
- **Zero-Trust Networking**: Private subnets, VLAN segmentation, and security groups
- **Secrets Management**: HashiCorp Vault with environment-specific policies and OIDC integration
- **Least-Privilege Access**: Separate Vault roles for each environment (dev/prod/onprem)
- **Network Segmentation**: VLANs 283/284/285 for proper traffic isolation

### CI/CD & GitOps
- **Branch-based Workflows**: Environment-specific deployment pipelines
- **Automated Validation**: Security scanning, linting, and infrastructure testing
- **Remote State Management**: Azure backend with state locking and encryption
- **Multi-Environment Support**: Isolated pipelines for dev, prod, and on-premises

### Infrastructure Patterns
- **Modular Design**: Reusable modules following DRY principles
- **Environment Isolation**: Separate configurations with consistent patterns
- **Hybrid Cloud**: Seamless management across Proxmox and Azure platforms
- **High Availability**: Multi-node clusters and redundant configurations

---

## Infrastructure Provisioned

### On-Premises Platform (av-onprem)
- **20+ Virtual Machines**: Configured for Kubernetes masters, workers, and infrastructure services
- **Network Infrastructure**: Multi-VLAN setup (283/284/285) with proper security segmentation
- **Storage Systems**: VM disk allocation across multiple Proxmox datastores
- **Compute Resources**: CPU and memory allocation optimized per workload type

### Azure Cloud Environments
- **Development (av-azure-dev)**: Virtual machines, VNet, subnets, and PostgreSQL database
- **Production (av-azure-prod)**: HA virtual machines with load balancer and managed database
- **Shared Infrastructure**: Resource groups, storage accounts, private DNS zones, and networking

---

## Technology Stack

**Infrastructure as Code**: Terraform with modular design patterns  
**Secrets Management**: HashiCorp Vault with OIDC authentication  
**Cloud Platforms**: Microsoft Azure + Proxmox VE hybrid architecture  
**CI/CD**: GitHub Actions with environment-specific workflows  
**Security**: Pre-commit hooks, TruffleHog scanning, and network segmentation

---

## Getting Started

### Prerequisites
- Terraform 1.13+
- Azure CLI with appropriate permissions
- Access to Proxmox cluster and HashiCorp Vault

### Quick Start

**1. Bootstrap Azure Backend**
```bash
cd bootstrap/
terraform init && terraform apply
```

**2. Deploy Environment**
```bash
cd live/av-azure/dev/
terraform init && terraform plan && terraform apply
```

**3. Verify Deployment**
```bash
terraform output  # Check infrastructure status
az vm list --resource-group apexvirtual-resources-dev
```

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