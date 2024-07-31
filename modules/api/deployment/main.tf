terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

# resource "kubernetes_deployment_v1" "nginx_hello" {
#   metadata {
#     name      = "nginx-hello"
#     namespace = "default"
#   }
#
#   spec {
#     replicas = 3
#
#     selector {
#       match_labels = {
#         app = "nginx-hello"
#       }
#     }
#
#     template {
#       metadata {
#         labels = {
#           app = "nginx-hello"
#         }
#       }
#
#       spec {
#         container {
#           image = "nginx:latest"
#           name  = "nginx-hello"
#         }
#       }
#     }
#   }
# }