terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "privatenet"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "privatesubnet" {
  name          = "privatesubnet"
  ip_cidr_range = "10.130.0.0/20"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "rules" {
  project = var.project_id
  name    = "privatenet-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_instance" "default" {
  project      = var.project_id
  zone         = var.zone
  name         = "vm-internal"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.privatesubnet.name
  }
}

resource "google_storage_bucket" "static" {
  name          = "test-cloud-nat"
  location      = "asia-northeast1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

