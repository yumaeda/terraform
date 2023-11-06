resource "google_compute_global_address" "private_ip_address" {
    provider      = google-beta
    name          = "private-ip"
    purpose       = "VPC_PEERING"
    address_type  = "INTERNAL"
    prefix_length = 16
    network       = var.vpc_name
    project       = var.project
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.vpc_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "sakabas" {
  provider            = google-beta
  name                = "sakabas"
  project             = var.project
  region              = var.region
  database_version    = "POSTGRES_15"
  deletion_protection = false

  settings {
    disk_type = "PD_HDD"
    disk_size = 10
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = "projects/${var.project}/global/networks/${var.vpc_name}"
      enable_private_path_for_google_cloud_services = true
      require_ssl                                   = true
    }
  }
}

resource "random_string" "root_password" {
  length           = 16
  override_special = "%*()-_=+[]{}?"
}

resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.sakabas.name
  password = random_string.root_password.result
}
