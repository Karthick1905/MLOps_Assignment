locals {
  namespace = var.namespace != "" ? var.namespace : "ml-api-${var.environment}"
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kubeconfig_path)
  }
}

resource "helm_release" "ml_api" {
  name             = "ml-api"
  chart            = "${path.module}/../helm/ml-api"
  namespace        = local.namespace
  create_namespace = true

  values = [
    file("${path.module}/../helm/ml-api/values-${var.environment}.yaml")
  ]

  atomic  = true
  wait    = true
  timeout = 300
}
