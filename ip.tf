resource "google_compute_project_default_network_tier" "default" {
  network_tier = "PREMIUM"
}

# Reserve an external IP
resource "google_compute_global_address" "website" {
  provider = google
  name     = "website-lb-ip"
}

resource "google_compute_address" "nat" {
  name   = "nat-ip"
  region = var.region
  network_tier = google_compute_project_default_network_tier.default.network_tier
}
