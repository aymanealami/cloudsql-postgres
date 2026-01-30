terraform {
  required_version = "~> 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "postgresql" {
  host            = module.cloudsql_postgres.private_ip_address
  port            = 5432
  database        = "postgres"
  username        = "postgres"
  password        = module.cloudsql_postgres.root_password
  sslmode         = "require"
  connect_timeout = 15
}
