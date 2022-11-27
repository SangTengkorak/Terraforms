# Create auto GCP VPC network
resource "google_compute_network" "auto-vpc-tf" {
  name                    = "auto-vpc-tf"
  auto_create_subnetworks = true

}

# Create custom GCP VPC network
resource "google_compute_network" "custom-vpc-tf" {
  name                    = "custom-vpc-tf"
  auto_create_subnetworks = false

}

# Create subnet for custom GCP VPC network
resource "google_compute_subnetwork" "sub-sg" {
  name                     = "sub-sg"
  network                  = google_compute_network.custom-vpc-tf.id
  ip_cidr_range            = "10.1.2.0/24"
  region                   = "asia-southeast1"
  private_ip_google_access = true

}

# Create firewall rule that allow icmp in custom GCP VPC network
resource "google_compute_firewall" "fw-allow-icmp" {
  name    = "fw-allow-icmp"
  network = google_compute_network.custom-vpc-tf.id
  allow {
    protocol = "icmp"
  }
  source_ranges = ["180.244.167.0/24"]
  priority      = 555
}

# Create firewall rule that deny custom http in custom GCP VPC network
resource "google_compute_firewall" "fw-block-cp" {
  name    = "fw-block-icmp"
  network = google_compute_network.custom-vpc-tf.id
  deny {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
  priority      = 444
}

output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

output "custom" {
  value = google_compute_network.custom-vpc-tf.id
}