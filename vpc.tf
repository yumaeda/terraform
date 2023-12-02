resource "google_compute_network" "vpc" {
  name                    = "sakabas-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-us-central-192"
  ip_cidr_range = "192.168.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "rules" {
  project = var.project
  name    = "allow-ssh"
  network = google_compute_network.vpc.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}
