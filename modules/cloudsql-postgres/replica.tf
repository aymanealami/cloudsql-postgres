# Read replica
resource "google_sql_database_instance" "read_replica" {
  count = var.read_replica != null ? 1 : 0

  project              = var.project_id
  name                 = "${var.instance_name}-${var.read_replica.name}"
  database_version     = "POSTGRES_${var.postgres_major_version}"
  region               = var.region
  master_instance_name = google_sql_database_instance.default.name
  deletion_protection  = true
  encryption_key_name  = local.encryption_key

  settings {
    tier              = lookup(var.read_replica, "tier", var.instance_tier)
    availability_type = "ZONAL"

    disk_autoresize = var.disk_autoresize
    disk_size       = lookup(var.read_replica, "disk_size", var.disk_size)
    disk_type       = lookup(var.read_replica, "disk_type", var.disk_type)

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
      ssl_mode        = "ENCRYPTED_ONLY"
    }

    location_preference {
      zone = var.read_replica.zone
    }

    dynamic "database_flags" {
      for_each = lookup(var.read_replica, "database_flags", var.database_flags)
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    user_labels = {
      environment = var.environment
      owner       = var.owner
      managed_by  = "terraform"
      replica     = "true"
    }
  }

  lifecycle {
    ignore_changes = [
      settings[0].disk_size,
      encryption_key_name
    ]
  }

  depends_on = [google_sql_database_instance.default]
}
