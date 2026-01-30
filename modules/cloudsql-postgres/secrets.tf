locals {
  secret_base_path = "${var.environment}-${var.region}-cloudsql_instances-${var.instance_name}"
}

# Root user secret
resource "google_secret_manager_secret" "root" {
  project   = var.project_id
  secret_id = "${local.secret_base_path}-root"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "root" {
  secret = google_secret_manager_secret.root.id
  secret_data = jsonencode({
    username = "postgres"
    password = random_password.root_password.result
    address  = google_sql_database_instance.default.private_ip_address
    port     = 5432
    engine   = "postgresql"
  })
}


# Default user secret (if created)
resource "google_secret_manager_secret" "default_user" {
  count = var.user_name != null ? 1 : 0

  project   = var.project_id
  secret_id = "${local.secret_base_path}-user-${var.user_name}"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "default_user" {
  count = var.user_name != null ? 1 : 0

  secret = google_secret_manager_secret.default_user[0].id
  secret_data = jsonencode({
    username = var.user_name
    password = random_password.user_password[0].result
  })
}
