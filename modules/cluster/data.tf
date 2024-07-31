data "digitalocean_kubernetes_versions" "k8s_version" {
  version_prefix = var.cluster_k8s_version_prefix
}