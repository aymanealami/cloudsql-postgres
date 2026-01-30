
resource "google_sql_database" "default" {
  count      = local.create_default_db ? 1 : 0
  name       = var.database_name
  project    = var.project_id
  charset    = var.database_charset
  collation  = var.database_charset
  instance   = google_sql_database_instance.default.name
  depends_on = [google_sql_database_instance.default]
}

resource "google_sql_database" "additional_databases" {
  for_each = { for db in var.additional_databases : db.name => db }

  project    = var.project_id
  name       = each.value.name
  charset    = each.value.charset
  collation  = each.value.collation
  instance   = google_sql_database_instance.default.name
  depends_on = [google_sql_database_instance.default]
}
