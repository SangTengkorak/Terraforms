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
  credentials = file("/home/sangtengkorak/Documents/Terraform/sangtengkorak_terraform_sak.json")
  project     = "sangtengkorak-terraform"
  region      = "us-central1"
  zone        = "us-central1-a"
}