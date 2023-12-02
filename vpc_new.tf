resource "google_compute_network" "sakabas_tokyo_vpc" {
  name                    = "sakabas-tokyo-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "sakabas_tokyo_subnet" {
  name          = "subnet-asia-northeast-172"
  ip_cidr_range = "172.16.1.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.sakabas_tokyo_vpc.id
}
