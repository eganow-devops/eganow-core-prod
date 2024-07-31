terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

resource "kubernetes_namespace_v1" "project_namespace" {
  metadata {
    name = var.project_namespace
  }
}