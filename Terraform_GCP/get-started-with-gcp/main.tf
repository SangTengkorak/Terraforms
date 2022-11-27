terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("/home/matjangkrik/Documents/Terraform/sangtengkorak_terraform_sak.json")
  project     = "sangtengkorak-terraform"
  region      = "us-central1"
  zone        = "us-central1-a"
}

# resource "google_storage_bucket" "GCS1" {
#     name = "sangtengkorak-bucket-tfcreated-up"
#     location = "Jakarta"
# }

resource "google_compute_instance" "testvm1" {
  name         = "tfinstance-01"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "fedora/fedora-cloud-base-gcp-36-20220506-n-0-x86-64"
    }
  }

  network_interface {
    network = "default"
  }

  scheduling {
    preemptible = true
  }
}