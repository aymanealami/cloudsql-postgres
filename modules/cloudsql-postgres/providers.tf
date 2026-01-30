terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
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

  required_version = "~> 1.3"
}