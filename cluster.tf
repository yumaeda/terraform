resource "google_container_cluster" "primary" {
  project            = var.project
  name               = "prod-us-central1-sakabas"
  location           = var.zone
  initial_node_count = 1

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.id

  remove_default_node_pool = true
  deletion_protection      = false

  private_cluster_config {
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_endpoint = true
    enable_private_nodes    = true
  }

  ip_allocation_policy {
  }

  master_authorized_networks_config {
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "sakabas-node-pool"
  location = var.zone
  cluster  = google_container_cluster.primary.name

  node_config {
    preemptible  = true
    disk_type    = "pd-standard"
    disk_size_gb = 10
    machine_type = "e2-micro"
  }

  autoscaling {
    max_node_count = 2
  }
}
