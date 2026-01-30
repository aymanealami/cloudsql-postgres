resource "random_password" "root_password" {
  length  = 24
  special = true
}

resource "random_password" "user_password" {
  count = var.user_name != null ? 1 : 0

  length  = 24
  special = true
}

resource "google_sql_database_instance" "default" {
  project             = var.project_id
  name                = var.instance_name
  database_version    = "POSTGRES_${var.postgres_major_version}"
  region              = var.region
  deletion_protection = true
  root_password       = random_password.root_password.result
  encryption_key_name = local.encryption_key

  settings {
    tier              = var.instance_tier
    availability_type = var.availability_type

    disk_autoresize = var.disk_autoresize
    disk_size       = var.disk_size
    disk_type       = var.disk_type

    backup_configuration {
      enabled                        = true
      start_time                     = var.backup_start_time
      point_in_time_recovery_enabled = var.point_in_time_recovery

      backup_retention_settings {
        retained_backups = var.retained_backups
        retention_unit   = "COUNT"
      }
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
      ssl_mode        = "ENCRYPTED_ONLY"
    }

    maintenance_window {
      day          = var.maintenance_day
      hour         = var.maintenance_hour
      update_track = var.maintenance_window_update_track
    }

    insights_config {
      query_insights_enabled  = var.enable_query_insights
      query_string_length     = var.query_insights_query_string_length
      record_application_tags = var.query_insights_record_application_tags
    }

    dynamic "database_flags" {
      for_each = concat(
        var.database_flags,
        var.enable_audit_logging ? [
          {
            name  = "cloudsql.enable_pgaudit"
            value = "on"
          },
          {
            name  = "pgaudit.log"
            value = var.audit_log_types
          },
          {
            name  = "log_connections"
            value = "on"
          },
          {
            name  = "log_disconnections"
            value = "on"
          },
          {
            name  = "log_statement"
            value = var.log_statement_level
          }
        ] : []
      )
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    user_labels = {
      environment = var.environment
      owner       = var.owner
      managed_by  = "terraform"
    }
  }

  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }
}
