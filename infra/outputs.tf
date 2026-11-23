output "artifact_registry_url" {
  description = "Base Artifact Registry Docker path"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repo_id}"
}

output "cloud_run_url" {
  description = "Public URL of the deployed Cloud Run service"
  value       = google_cloud_run_service.app.status[0].url
}