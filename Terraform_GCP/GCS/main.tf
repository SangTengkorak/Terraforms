# Create GCP Bucket
resource "google_storage_bucket" "GCS1" {
  name          = "sangtengkorak-bucket-tfcreated-st"
  storage_class = "nearline"
  location      = "us-central1"

  labels = {
    "env" = "tf_env"
    "dep" = "complience"
  }

  uniform_bucket_level_access = true

  # GCP Bucket Policies
  lifecycle_rule {
    condition {
      age = 5
    }
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }

  retention_policy {
    is_locked = false
    retention_period = 864000
  }

}

# Upload file/s to GCP Bucket
resource "google_storage_bucket_object" "picture" {
  name   = "skeleton_soldier.jpg"
  bucket = google_storage_bucket.GCS1.name
  source = "/home/matjangkrik/Pictures/skeleton_soldier.jpg"
}

# resource "google_compute_instance" "testvm1" {
#   name         = "tfinstance-01"
#   machine_type = "e2-micro"

#   boot_disk {
#     initialize_params {
#       image = "fedora/fedora-cloud-base-gcp-36-20220506-n-0-x86-64"
#     }
#   }

#   network_interface {
#     network = "default"
#   }

#   scheduling {
#     preemptible = true
#   }
# }