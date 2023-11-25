resource "google_compute_project_default_network_tier" "default" {
  project = var.project
  network_tier = "STANDARD"
}

resource "google_compute_router" "router" {
  project = var.project
  name    = "gke-router"
  network = google_compute_network.vpc.id
  region  = var.region
}

resource "google_compute_address" "nat" {
  name   = "nat-ip"
  region = google_compute_router.router.region
  network_tier = google_compute_project_default_network_tier.default.network_tier
}

resource "google_compute_router_nat" "nat" {
  name   = "gke-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = google_compute_address.nat.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
