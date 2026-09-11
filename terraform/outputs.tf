output "release_name" {
  value = helm_release.ml_api.name
}

output "namespace" {
  value = helm_release.ml_api.namespace
}
