# Create GCP CloudRun service
resource "google_cloud_run_service" "run-app-from-tf" {
  name     = "run-from-tf"
  location = "asia-southeast1"

  # Divide traffic accordingly between old and new version
  traffic {
    revision_name = "run-from-tf-rdsx7"
    percent = "50"
  }

    traffic {
    revision_name = "run-from-tf-6hhp6"
    percent = "50"
  }

  template {
    spec {
      containers {
        # To update newer revision, just need to deactivate older version line
        # image = "gcr.io/google-samples/hello-app:1.0"
        image = "gcr.io/google-samples/hello-app:2.0"
      }
    }

  }
}

# Allow CloudRun service accessed publicly
resource "google_cloud_run_service_iam_binding" "pub-acc-01" {
  location = google_cloud_run_service.run-app-from-tf.location
  service  = google_cloud_run_service.run-app-from-tf.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}