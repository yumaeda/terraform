# Reserve an external IP
resource "google_compute_global_address" "website" {
  provider = google
  name     = "website-lb-ip"
}
