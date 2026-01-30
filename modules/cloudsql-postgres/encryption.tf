# Create KMS keyring if encryption is enabled and no key is provided
resource "google_kms_key_ring" "cloudsql" {
  count = var.enable_encryption && var.encryption_key_name == null ? 1 : 0

  project  = var.project_id
  name     = "${var.instance_name}-keyring"
  location = var.region
}

# Create KMS crypto key if encryption is enabled and no key is provided
resource "google_kms_crypto_key" "cloudsql" {
  count = var.enable_encryption && var.encryption_key_name == null ? 1 : 0

  name            = "${var.instance_name}-key"
  key_ring        = google_kms_key_ring.cloudsql[0].id
  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = true
  }
}

# Create Cloud SQL service identity
resource "google_project_service_identity" "cloudsql_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "sqladmin.googleapis.com"
}

# Grant Cloud SQL service identity permission to use the KMS key
resource "google_kms_crypto_key_iam_member" "cloudsql_key_user" {
  count = var.enable_encryption && var.encryption_key_name == null ? 1 : 0

  crypto_key_id = google_kms_crypto_key.cloudsql[0].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_project_service_identity.cloudsql_sa.email}"
}

locals {
  encryption_key = var.enable_encryption ? (
    var.encryption_key_name != null ? var.encryption_key_name : google_kms_crypto_key.cloudsql[0].id
  ) : null
}
