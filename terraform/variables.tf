variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging, or prod."
  }
}

variable "namespace" {
  description = "Target Kubernetes namespace. Empty means derive from environment."
  type        = string
  default     = ""
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig"
  type        = string
  default     = "~/.kube/config"
}
