variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)"
}

variable "owner" {
  type        = string
  description = "Team or project owner"
}

variable "instance_name" {
  type        = string
  description = "Cloud SQL instance name"
}

variable "vpc_id" {
  type        = string
  description = "VPC self-link for private IP"
}

variable "instance_tier" {
  type        = string
  description = "Instance tier"
  default     = "db-custom-2-7680"
}

variable "postgres_major_version" {
  type        = number
  description = "PostgreSQL major version"
  default     = 16
}

variable "availability_type" {
  type        = string
  description = "Availability type (REGIONAL or ZONAL)"
  default     = "REGIONAL"
}

variable "disk_type" {
  type        = string
  description = "Disk type"
  default     = "PD_SSD"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 100
}

variable "disk_autoresize" {
  type        = bool
  description = "Enable disk autoresize"
  default     = true
}

variable "database_name" {
  type        = string
  description = "Initial database name"
  default     = "myapp"
}

variable "database_charset" {
  type        = string
  description = "Character set for the database"
  default     = "UTF8"
}

variable "database_collation" {
  type        = string
  description = "Collation for the database"
  default     = "en_US.UTF8"
}

variable "user_name" {
  type        = string
  description = "Initial user name"
  default     = "myapp"
}

variable "backup_start_time" {
  type        = string
  description = "Backup start time"
  default     = "03:00"
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Enable point-in-time recovery"
  default     = true
}

variable "retained_backups" {
  type        = number
  description = "Number of backups to retain"
  default     = 7
}

variable "maintenance_day" {
  type        = number
  description = "Maintenance window day"
  default     = 7
}

variable "maintenance_hour" {
  type        = number
  description = "Maintenance window hour"
  default     = 3
}

variable "maintenance_window_update_track" {
  type        = string
  description = "Maintenance window update track"
  default     = "stable"
}

variable "enable_encryption" {
  type        = bool
  description = "Enable CMEK encryption"
  default     = true
}

variable "encryption_key_name" {
  type        = string
  description = "KMS encryption key name"
  default     = null
}

variable "additional_databases" {
  type = list(object({
    name      = string
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.UTF8")
  }))
  description = "Additional databases to create"
  default     = []
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Database flags"
  default     = []
}

variable "read_replica" {
  type = object({
    name      = string
    zone      = string
    tier      = optional(string)
    disk_size = optional(number)
    disk_type = optional(string)
    database_flags = optional(list(object({
      name  = string
      value = string
    })))
  })
  description = "Read replica configuration"
  default     = null
}

variable "enable_query_insights" {
  type        = bool
  description = "Enable Query Insights for query performance monitoring"
  default     = false
}

variable "query_insights_query_string_length" {
  type        = number
  description = "Maximum query string length for Query Insights"
  default     = 1024
}

variable "query_insights_record_application_tags" {
  type        = bool
  description = "Record application tags in Query Insights"
  default     = false
}

variable "enable_audit_logging" {
  type        = bool
  description = "Enable pgAudit extension for database activity logging"
  default     = false
}

variable "audit_log_types" {
  type        = string
  description = "Types of statements to audit (READ, WRITE, FUNCTION, ROLE, DDL, MISC, ALL)"
  default     = "WRITE,DDL,ROLE"
}

variable "log_statement_level" {
  type        = string
  description = "Log statement level (none, ddl, mod, all)"
  default     = "ddl"
}
