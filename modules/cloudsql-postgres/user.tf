resource "google_sql_user" "default" {
  count    = var.user_name != null ? 1 : 0
  name     = var.user_name
  project  = var.project_id
  instance = google_sql_database_instance.default.name
  password = random_password.user_password[0].result
}