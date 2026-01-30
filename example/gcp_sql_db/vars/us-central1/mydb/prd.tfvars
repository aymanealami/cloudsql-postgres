project_id    = "my-gcp-project"
region        = "us-central1"
environment   = "production"
owner         = "platform"
instance_name = "mydb"
vpc_id        = "projects/my-gcp-project/global/networks/my-vpc"

# Instance configuration
instance_tier          = "db-custom-2-7680"
postgres_major_version = 16
availability_type      = "REGIONAL"

# Database and user
database_name = "myapp"
user_name     = "myuser"

# Additional databases
additional_databases = [
  {
    name      = "analytics"
    charset   = "UTF8"
    collation = "en_US.UTF8"
  },
  {
    name      = "reporting"
    charset   = "UTF8"
    collation = "en_US.UTF8"
  }
]

# PostgreSQL flags
database_flags = [
  {
    name  = "max_connections"
    value = "100"
  }
]

# Read replica
read_replica = {
  name = "replica1"
  zone = "us-central1-b"
  tier = "db-custom-2-7680"
}

# Monitoring and Audit Logging
enable_query_insights                  = true
enable_audit_logging                   = true
query_insights_record_application_tags = true
log_statement_level                    = "all"
