

module "cloudsql_postgres" {
  source = "../../modules/cloudsql-postgres"

  project_id    = var.project_id
  region        = var.region
  environment   = var.environment
  owner         = var.owner
  instance_name = var.instance_name

  # Instance configuration
  instance_tier          = var.instance_tier
  postgres_major_version = var.postgres_major_version
  availability_type      = var.availability_type

  # Storage configuration
  disk_type       = var.disk_type
  disk_size       = var.disk_size
  disk_autoresize = var.disk_autoresize

  # Network configuration
  vpc_id = var.vpc_id

  # Database and user
  database_name      = var.database_name
  database_charset   = var.database_charset
  database_collation = var.database_collation
  user_name          = var.user_name

  # Backup configuration
  backup_start_time      = var.backup_start_time
  point_in_time_recovery = var.point_in_time_recovery
  retained_backups       = var.retained_backups

  # Maintenance window
  maintenance_day                 = var.maintenance_day
  maintenance_hour                = var.maintenance_hour
  maintenance_window_update_track = var.maintenance_window_update_track

  # Encryption
  enable_encryption   = var.enable_encryption
  encryption_key_name = var.encryption_key_name

  # Additional databases
  additional_databases = var.additional_databases

  # PostgreSQL flags
  database_flags = var.database_flags

  # Read replica (optional)
  read_replica = var.read_replica

  # Query Insights
  enable_query_insights                  = var.enable_query_insights
  query_insights_query_string_length     = var.query_insights_query_string_length
  query_insights_record_application_tags = var.query_insights_record_application_tags

  # Audit Logging
  enable_audit_logging = var.enable_audit_logging
  audit_log_types      = var.audit_log_types
  log_statement_level  = var.log_statement_level
}
