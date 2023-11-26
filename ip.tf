resource "google_compute_project_default_network_tier" "default" {
  network_tier = "PREMIUM"
}

# Reserve an external IP
resource "google_compute_global_address" "website" {
  provider = google
  name     = "website-lb-ip"
}

resource "google_compute_global_address" "api" {
  provider = google
  name     = "api-lb-ip"
}

