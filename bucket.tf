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
}
