resource "google_container_cluster" "primary" {
  project            = var.project
  name               = "prod-us-central1-sakabas"
  location           = var.zone
  initial_node_count = 1

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.id

  remove_default_node_pool = true
  deletion_protection      = false

  node_config {
    machine_type = "e2-micro"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "sakabas-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

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
