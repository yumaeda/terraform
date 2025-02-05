provider "google" {
  project = var.project
  region  = var.region
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
}
