# Cloud SQL PostgreSQL HA Example

This example demonstrates how to use the `cloudsql-postgres` module to create a highly available PostgreSQL instance with:

- REGIONAL availability (HA)
- Private networking only
- Encryption at Rest
- Encryption in Transit
- Read replica in different zone
- Automated Backups
- Multiple databases
- Automated secret management
- PostgreSQL user grants
- Audit logging

## Directory Structure

This example uses a hierarchical organization for variable files:

```
example/cloudsql-postgres-ha/
├── main.tf                          # Module configuration
├── variables.tf                     # Variable declarations
├── outputs.tf                       # Output declarations
├── providers.tf                     # Provider configurations
└── vars/                            # Variable files organized by hierarchy
    └── {region}/                    # Region-specific configurations
        └── {instance-name}/         # Instance-specific configurations
            ├── prd.tfvars          # Production environment
            ├── stg.tfvars          # Staging environment
            └── dev.tfvars          # Development environment
```

### Variable File Organization

Variable files are organized in a three-level hierarchy:

1. **Region**: `vars/{region}/` - Region-specific settings
2. **Instance Name**: `vars/{region}/{instance-name}/` - Instance-specific settings
3. **Environment**: `{env}.tfvars` - Environment-specific overrides

**Example:**
```
vars/us-central1/mydb/prd.tfvars     # Production instance in us-central1
vars/us-east1/analytics/stg.tfvars   # Staging analytics DB in us-east1
vars/europe-west1/api/dev.tfvars     # Dev API database in europe-west1
```

This structure allows you to:
- Separate configurations by region and instance
- Maintain different environments (dev/stg/prd) for the same instance
- Version control all configurations
- Easily compare settings across environments

## Prerequisites

1. **VPC**
2. **Enable required APIs**
3. **Create variable file for your environment**

## Usage

### 1. Create Variable File

Create variable file following the hierarchy:

```bash
mkdir -p vars/us-central1/mydb
```

Edit with your values following the structure in `vars/us-central1/mydb/prd.tfvars`.

### 2. Deploy

```bash
terraform init
terraform plan -var-file=vars/us-central1/mydb/prd.tfvars
terraform apply -var-file=vars/us-central1/mydb/prd.tfvars
```

## Environment-Specific Deployments

Deploy to different environments using different tfvars files:

```bash
# Development
terraform apply -var-file=vars/us-central1/mydb/dev.tfvars

# Staging
terraform apply -var-file=vars/us-central1/mydb/stg.tfvars

# Production
terraform apply -var-file=vars/us-central1/mydb/prd.tfvars
```

## Managing Multiple Instances

Manage multiple instances by creating separate variable files:

```bash
# Deploy production database
terraform apply -var-file=vars/us-central1/mydb/prd.tfvars

# Deploy analytics database
terraform apply -var-file=vars/us-central1/analytics/prd.tfvars
```

