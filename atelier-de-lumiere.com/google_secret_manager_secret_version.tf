resource "google_secret_manager_secret_version" "cloudflare_atelier_de_lumiere_gcs_hmac_key_access_id" {
    secret = google_secret_manager_secret.cloudflare_atelier_de_lumiere_gcs_hmac_key_access_id.id
    secret_data = google_storage_hmac_key.cloudflare_atelier_de_lumiere.access_id
}

resource "google_secret_manager_secret_version" "cloudflare_atelier_de_lumiere_gcs_hmac_key_secret" {
    secret = google_secret_manager_secret.cloudflare_atelier_de_lumiere_gcs_hmac_key_secret.id
    secret_data = google_storage_hmac_key.cloudflare_atelier_de_lumiere.secret
}
