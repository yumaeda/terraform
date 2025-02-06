resource "google_storage_hmac_key" "cloudflare_atelier_de_lumiere" {
  service_account_email = google_service_account.cloudflare_atelier_de_lumiere.email
}
