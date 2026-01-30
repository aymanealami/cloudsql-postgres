terraform {
  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "gcp_sql_db"
  }
}
