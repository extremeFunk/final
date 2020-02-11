//
//resource "google_compute_instance" "jenkins_instance" {
//  name         = "jenkins-instance"
//  machine_type = "f1-micro"
//
//  boot_disk {
//    initialize_params {
//      image = "debian-cloud/debian-9"
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network       = "${google_compute_network.vpc_network.self_link}"
//    access_config {
//    }
//  }
//}
//
//resource "google_compute_network" "vpc_network" {
//  name                    = "terraform-network"
//  auto_create_subnetworks = "true"
//}
//

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
