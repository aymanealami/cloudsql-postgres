variable "project_id" {
  type        = string
  description = "GCP project id."
}

variable "region" {
  type        = string
  description = "GCP region for the Cloud SQL instance (regional HA)."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod) used in secret paths."
}

variable "owner" {
  type        = string
  description = "Team or project owner of the database."
}

variable "instance_name" {
  type        = string
  description = "Cloud SQL instance name."
}

variable "postgres_major_version" {
  type        = number
  description = "PostgreSQL major version (e.g., 14, 15, 16)."
  default     = 16
}

variable "instance_tier" {
  type        = string
  description = "Instance tier, e.g. db-custom-2-7680."
}

variable "disk_type" {
  type        = string
  description = "Disk type: PD_SSD or PD_HDD."
  default     = "PD_SSD"
}

variable "disk_size" {
  type        = number
  description = "Initial disk size in GB."
  default     = 100
}

variable "disk_autoresize" {
  type        = bool
  description = "Whether disk autoresize is enabled."
  default     = true
}

variable "database_name" {
  type        = string
  description = "Initial database name to create."
  default     = "app"
}

variable "database_charset" {
  description = "The charset for the default database"
  type        = string
  default     = ""
}

variable "database_collation" {
  description = "The collation for the default database. Example: 'en_US.UTF8'"
  type        = string
  default     = ""
}

variable "availability_type" {
  description = "CloudSQL instance availability type. Can be either REGIONAL or ZONAL."
  type        = string
  validation {
    condition     = var.availability_type == "REGIONAL" || var.availability_type == "ZONAL"
    error_message = "availability_type can be be either REGIONAL or ZONAL."
  }
  default = "REGIONAL"
}

variable "user_name" {
  type        = string
  description = "Optional default application user to create. If null, no default user is created."
  default     = null
}

variable "backup_start_time" {
  type        = string
  description = "Daily backup start time in UTC (HH:MM), e.g. 03:00."
  default     = "03:00"

  validation {
    condition     = can(regex("^([01]\\d|2[0-3]):[0-5]\\d$", var.backup_start_time))
    error_message = "backup_start_time must be in HH:MM 24h format (UTC), e.g. 03:00."
  }
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Enable point-in-time recovery."
  default     = true
}

variable "retained_backups" {
  type        = number
  description = "Number of backups to retain."
  default     = 7
}

variable "vpc_id" {
  type        = string
  description = "VPC self-link for private IP access (e.g., projects/my-project/global/networks/my-vpc). Required."
}

variable "maintenance_day" {
  type        = number
  description = "Maintenance window day (1=Mon .. 7=Sun)."
  default     = 7
}

variable "maintenance_hour" {
  type        = number
  description = "Maintenance window hour (0-23) in UTC."
  default     = 3
}

variable "maintenance_window_update_track" {
  type        = string
  description = "Maintenance window update track."
  default     = "stable"
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Database flags to apply to the instance."
  default     = []
}

variable "enable_encryption" {
  type        = bool
  description = "Enable CMEK encryption for the Cloud SQL instance. If true and encryption_key_name is null, a new KMS key will be created."
  default     = true
}

variable "encryption_key_name" {
  type        = string
  description = "The full path to the encryption key used for the CMEK disk encryption. If null and enable_encryption is true, a new key will be created."
  default     = null
}

variable "additional_databases" {
  type = list(object({
    name      = string
    charset   = optional(string, "UTF8")
    collation = optional(string, "en_US.UTF8")
  }))
  description = "Additional databases to create beyond the default database."
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
  description = "Configuration for a single read replica in the same region. Set to null to disable."
  default     = null
}

variable "enable_query_insights" {
  description = "Enable Query Insights for query performance monitoring"
  type        = bool
  default     = false
}

variable "query_insights_query_string_length" {
  description = "Maximum query string length for Query Insights"
  type        = number
  default     = 1024
}

variable "query_insights_record_application_tags" {
  description = "Record application tags in Query Insights"
  type        = bool
  default     = false
}

variable "enable_audit_logging" {
  description = "Enable pgAudit extension for database activity logging"
  type        = bool
  default     = false
}

variable "audit_log_types" {
  description = "Types of statements to audit (READ, WRITE, FUNCTION, ROLE, DDL, MISC, ALL)"
  type        = string
  default     = "WRITE,DDL,ROLE"
}

variable "log_statement_level" {
  description = "Log statement level (none, ddl, mod, all)"
  type        = string
  default     = "ddl"
}

locals {
  create_default_db = var.database_name != null && var.database_name != ""
}