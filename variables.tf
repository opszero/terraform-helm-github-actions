variable "k8s_namespace" {
  type        = string
  default     = "github-actions"
  description = "Kubernetes namespace to deploy the release in"
}

variable "config_url" {
  type        = string
  description = "Example: https://github.com/opszero"
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token with repo permissions"
  sensitive   = true
}
