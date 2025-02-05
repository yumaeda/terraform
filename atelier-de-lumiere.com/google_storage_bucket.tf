resource "google_storage_bucket" "atelier_de_lumiere_com" {
  name          = "atelier-de-lumiere-com"
  location      = var.region
  storage_class = "REGIONAL"

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}
