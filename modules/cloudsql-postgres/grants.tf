
# Grant privileges on default database and additional databases
locals {
  databases = concat(
    local.create_default_db ? [var.database_name] : [],
    [for db in var.additional_databases : db.name]
  )
}

resource "postgresql_grant" "default_user_database" {
  for_each = var.user_name != null ? local.databases : toset([])

  role        = var.user_name
  database    = each.value
  object_type = "database"
  privileges  = ["CONNECT", "CREATE", "TEMPORARY"]

  depends_on = [
    google_sql_database_instance.default,
    google_sql_user.default
  ]
}

resource "postgresql_grant" "default_user_schema" {
  for_each = var.user_name != null ? local.databases : toset([])

  role        = var.user_name
  database    = each.value
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE", "CREATE"]

  depends_on = [postgresql_grant.default_user_database]
}

resource "postgresql_grant" "default_user_tables" {
  for_each = var.user_name != null ? local.databases : toset([])

  role        = var.user_name
  database    = each.value
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]

  depends_on = [postgresql_grant.default_user_schema]
}
