output "instance_name" {
  value       = google_sql_database_instance.default.name
  description = "Cloud SQL instance name."
}

output "instance_connection_name" {
  value       = google_sql_database_instance.default.connection_name
  description = "Cloud SQL connection name (<project>:<region>:<instance>)."
}

output "private_ip_address" {
  value       = google_sql_database_instance.default.private_ip_address
  description = "Private IP address."
}

output "root_password" {
  value       = random_password.root_password.result
  description = "Root (postgres) user password."
  sensitive   = true
}
