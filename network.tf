# Reserve an external IP
resource "google_compute_global_address" "website" {
  provider = google
  name     = "website-lb-ip"
}

# Get the managed DNS zone
data "google_dns_managed_zone" "gcp_ramen_mania_zone" {
  provider = google
  name     = "ramen-mania-net"
}
