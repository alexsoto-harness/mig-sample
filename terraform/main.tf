terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Health Check for the Backend Service
resource "google_compute_health_check" "mig_demo" {
  name                = "mig-demo-health-check"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  tcp_health_check {
    port = 80
  }
}

# Backend Service that references our MIG
resource "google_compute_backend_service" "mig_demo" {
  name                  = "mig-demo-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  health_checks = [google_compute_health_check.mig_demo.id]

  backend {
    group           = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/zones/${var.zone}/instanceGroups/mig-demo-group"
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# Cloud Service Mesh HTTPRoute for traffic management
resource "google_network_services_http_route" "mig_demo" {
  provider = google-beta
  name     = "mig-demo-http-route"

  hostnames = ["mig-demo-service"]

  rules {
    action {
      destinations {
        service_name = google_compute_backend_service.mig_demo.id
        weight       = 100
      }
    }
  }
}
