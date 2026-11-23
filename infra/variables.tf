variable "project_id" {
  description = "Your Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "asia-south1"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "fullstack-demo"
}

variable "repo_id" {
  description = "Artifact Registry Docker repository ID"
  type        = string
  default     = "fullstack-repo"
}

variable "image_url" {
  description = "Container image URI in Artifact Registry"
  type        = string
}