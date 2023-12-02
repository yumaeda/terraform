provider "google" {
    project = var.project
    region  = "asia-northeast1"
    zone    = "asia-northeast1-b"
}

resource "google_storage_bucket" "sakabas_website" {
    name     = "sakabas.com"
    location = "asia-northeast1"
    website {
      main_page_suffix = "index.html"
      not_found_page   = "index.html"
  }
}

# Make new objects public
resource "google_storage_default_object_access_control" "sakabas_read" {
  bucket = google_storage_bucket.sakabas_website.name
  role   = "READER"
  entity = "allUsers"
}
