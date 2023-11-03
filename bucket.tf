locals {
  website_domain_name_dashed = replace(var.website_domain_name, ".", "-")
}

# Specify the GCP Provider
provider "google" {
    project = var.project
    region  = var.region
}

# Create a GCS Bucket
resource "google_storage_bucket" "website" {
    name     = var.website_domain_name
    location = var.region
    website {
      main_page_suffix = "index.html"
      not_found_page   = "index.html"
  }
}

# Make new objects public
resource "google_storage_default_object_access_control" "website_read" {
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"
}
