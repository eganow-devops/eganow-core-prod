output "eganow_core_namespace" {
  value = kubernetes_namespace_v1.project_namespace.metadata.0.name
}