# Create HTTPS certificate
resource "google_compute_managed_ssl_certificate" "website" {
  provider = google
  name     = "website-cert"
  managed {
    domains = [google_dns_record_set.website.name]
  }
}
