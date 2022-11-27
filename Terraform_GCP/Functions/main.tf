# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = ">= 4.34.0"
#     }
#   }
# }

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

# 1. Create GCP Bucket to store app.
resource "google_storage_bucket" "createdbytf-bucket" {
  name                        = "${random_id.bucket_prefix.hex}-gcf-source" # Every bucket name must be globally unique
  location                    = "us-central1"
  uniform_bucket_level_access = true
}

# 2. Upload compressed app to GCP Bucket.
resource "google_storage_bucket_object" "cf_app" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.createdbytf-bucket.name
  source = "/home/sangtengkorak/Documents/Terraform/Terraform_GCP/Functions/function-source.zip" # Add path to the zipped function source code
}

# 3. Build GCP Cloud Function
resource "google_cloudfunctions2_function" "createdbytf-function" {
  name        = "function-from-tf"
  location    = "us-central1"
  description = "a new function"

  # Ensure that Artifact Registry API	is enabled.
  build_config {
    runtime     = "nodejs16"
    entry_point = "helloHttp" # Set the entry point
    source {
      storage_source {
        bucket = google_storage_bucket.createdbytf-bucket.name
        object = google_storage_bucket_object.cf_app.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "128Mi"
    timeout_seconds    = 300
  }
}

# Allow GCP cloud Function to access by public.
# Ensure to enable cloudfunctions.functions.setIamPolicy
resource "google_cloudfunctions2_function_iam_member" "member" {
  project        = google_cloudfunctions2_function.createdbytf-function.project
  location       = google_cloudfunctions2_function.createdbytf-function.location
  cloud_function = google_cloudfunctions2_function.createdbytf-function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}

output "function_uri" {
  value = google_cloudfunctions2_function.createdbytf-function.service_config[0].uri
}