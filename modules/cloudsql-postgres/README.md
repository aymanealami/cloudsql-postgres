## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | ~> 1 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.cloudsql_sa](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_kms_crypto_key.cloudsql](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.cloudsql_key_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.cloudsql](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_secret_manager_secret.default_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret.root](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.default_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_secret_manager_secret_version.root](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_sql_database.additional_databases](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_database_instance.read_replica](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [postgresql_grant.default_user_database](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.default_user_schema](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.default_user_tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [random_password.root_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_databases"></a> [additional\_databases](#input\_additional\_databases) | Additional databases to create beyond the default database. | <pre>list(object({<br>    name      = string<br>    charset   = optional(string, "UTF8")<br>    collation = optional(string, "en_US.UTF8")<br>  }))</pre> | `[]` | no |
| <a name="input_audit_log_types"></a> [audit\_log\_types](#input\_audit\_log\_types) | Types of statements to audit (READ, WRITE, FUNCTION, ROLE, DDL, MISC, ALL) | `string` | `"WRITE,DDL,ROLE"` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | CloudSQL instance availability type. Can be either REGIONAL or ZONAL. | `string` | `"REGIONAL"` | no |
| <a name="input_backup_start_time"></a> [backup\_start\_time](#input\_backup\_start\_time) | Daily backup start time in UTC (HH:MM), e.g. 03:00. | `string` | `"03:00"` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | Database flags to apply to the instance. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Initial database name to create. | `string` | `"app"` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | The charset for the default database | `string` | `""` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | The collation for the default database. Example: 'en\_US.UTF8' | `string` | `""` | no |
| <a name="input_disk_autoresize"></a> [disk\_autoresize](#input\_disk\_autoresize) | Whether disk autoresize is enabled. | `bool` | `true` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Initial disk size in GB. | `number` | `100` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | Disk type: PD\_SSD or PD\_HDD. | `string` | `"PD_SSD"` | no |
| <a name="input_enable_audit_logging"></a> [enable\_audit\_logging](#input\_enable\_audit\_logging) | Enable pgAudit extension for database activity logging | `bool` | `false` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Enable CMEK encryption for the Cloud SQL instance. If true and encryption\_key\_name is null, a new KMS key will be created. | `bool` | `true` | no |
| <a name="input_enable_query_insights"></a> [enable\_query\_insights](#input\_enable\_query\_insights) | Enable Query Insights for query performance monitoring | `bool` | `false` | no |
| <a name="input_encryption_key_name"></a> [encryption\_key\_name](#input\_encryption\_key\_name) | The full path to the encryption key used for the CMEK disk encryption. If null and enable\_encryption is true, a new key will be created. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., dev, staging, prod) used in secret paths. | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Cloud SQL instance name. | `string` | n/a | yes |
| <a name="input_instance_tier"></a> [instance\_tier](#input\_instance\_tier) | Instance tier, e.g. db-custom-2-7680. | `string` | n/a | yes |
| <a name="input_log_statement_level"></a> [log\_statement\_level](#input\_log\_statement\_level) | Log statement level (none, ddl, mod, all) | `string` | `"ddl"` | no |
| <a name="input_maintenance_day"></a> [maintenance\_day](#input\_maintenance\_day) | Maintenance window day (1=Mon .. 7=Sun). | `number` | `7` | no |
| <a name="input_maintenance_hour"></a> [maintenance\_hour](#input\_maintenance\_hour) | Maintenance window hour (0-23) in UTC. | `number` | `3` | no |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | Maintenance window update track. | `string` | `"stable"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Team or project owner of the database. | `string` | n/a | yes |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | Enable point-in-time recovery. | `bool` | `true` | no |
| <a name="input_postgres_major_version"></a> [postgres\_major\_version](#input\_postgres\_major\_version) | PostgreSQL major version (e.g., 14, 15, 16). | `number` | `16` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id. | `string` | n/a | yes |
| <a name="input_query_insights_query_string_length"></a> [query\_insights\_query\_string\_length](#input\_query\_insights\_query\_string\_length) | Maximum query string length for Query Insights | `number` | `1024` | no |
| <a name="input_query_insights_record_application_tags"></a> [query\_insights\_record\_application\_tags](#input\_query\_insights\_record\_application\_tags) | Record application tags in Query Insights | `bool` | `false` | no |
| <a name="input_read_replica"></a> [read\_replica](#input\_read\_replica) | Configuration for a single read replica in the same region. Set to null to disable. | <pre>object({<br>    name      = string<br>    zone      = string<br>    tier      = optional(string)<br>    disk_size = optional(number)<br>    disk_type = optional(string)<br>    database_flags = optional(list(object({<br>      name  = string<br>      value = string<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region for the Cloud SQL instance (regional HA). | `string` | n/a | yes |
| <a name="input_retained_backups"></a> [retained\_backups](#input\_retained\_backups) | Number of backups to retain. | `number` | `7` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Optional default application user to create. If null, no default user is created. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC self-link for private IP access (e.g., projects/my-project/global/networks/my-vpc). Required. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | Cloud SQL connection name (<project>:<region>:<instance>). |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Cloud SQL instance name. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | Private IP address. |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | Root (postgres) user password. |
