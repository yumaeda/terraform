resource "google_storage_bucket_iam_member" "cloudflare_atelier_de_lumiere" {
  bucket = google_storage_bucket.atelier_de_lumiere_com.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.cloudflare_atelier_de_lumiere.email}"
}
