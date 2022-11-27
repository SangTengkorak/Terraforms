# Create VM instance in GCP with several option
resource "google_compute_instance" "vm-from-tf" {
  name                      = "vm-from-tf"
  machine_type              = "e2-medium"
  allow_stopping_for_update = true

  # Bootable disk option
  boot_disk {
    initialize_params {
      image = "fedora-cloud/fedora-cloud-base-gcp-34-1-2-x86-64"
      size  = 35
    }

    auto_delete = false
  }

  network_interface {
    network = "default"
  }

  # Preemptible option to save cost
  scheduling {
    automatic_restart = false
    preemptible       = true
  }

  labels = {
    "env" = "tflearning"
    "dep" = "engineering"
  }

  # Attach service account to vm instance
  service_account {
    email  = "sangtengkorak-sak@sangtengkorak-terraform.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  # Ignore changes
  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }
}

# Create additional disk to be mounted
resource "google_compute_disk" "disk-01" {
  name = "disk-01"
  size = 10
  zone = "us-central1-a"
  type = "pd-ssd"
}

# Mount additional disk to running VM instance
resource "google_compute_attached_disk" "attach-01" {
  disk     = google_compute_disk.disk-01.id
  instance = google_compute_instance.vm-from-tf.id
}