resource "google_secret_manager_secret" "cloudflare_atelier_de_lumiere_gcs_hmac_key_access_id" {
    secret_id = "cloudflare_atelier_de_lumiere_gcs_hmac_key_access_id"
    replication {
        auto {}
    }
}

resource "google_secret_manager_secret" "cloudflare_atelier_de_lumiere_gcs_hmac_key_secret" {
    secret_id = "cloudflare_atelier_de_lumiere_gcs_hmac_key_secret"
    replication {
        auto {}
    }
}
