terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.12.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.repo_id
  description   = "Docker images for fullstack app"
  format        = "DOCKER"
}

resource "google_cloud_run_service" "app" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url

        ports {
          container_port = 8080
        }

        env {
          name  = "APP_ENV"
          value = "gcp-cloud-run"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_artifact_registry_repository.docker_repo]
}

resource "google_cloud_run_service_iam_member" "public_invoker" {
  service  = google_cloud_run_service.app.name
  location = google_cloud_run_service.app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}