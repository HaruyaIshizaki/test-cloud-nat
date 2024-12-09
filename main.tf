terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "privatenet"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "privatesubnet" {
    name = "privatesubnet"
    ip_cidr_range = "10.130.0.0/20"
    region = var.region
    network = google_compute_network.vpc_network.id
}