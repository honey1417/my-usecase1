resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  deletion_protection = false
  remove_default_node_pool = true  # initial_node_count is ignored when the default node pool is removed.
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  initial_node_count = var.NODE_COUNT
  node_config {
    machine_type = var.MACHINE_TYPE
    disk_size_gb = 70
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}
