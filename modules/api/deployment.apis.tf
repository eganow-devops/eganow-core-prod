resource "kubernetes_deployment_v1" "payment_gateway" {
  metadata {
    name      = "payment-gateway"
    namespace = var.pay_core_namespace
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "payment-gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "payment-gateway"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.dockerconfigjson.metadata.0.name
        }
        container {
          image             = "eganowdevops/eganow-mobile-app-core-api:latest"
          name              = "payment-gateway"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "grpc"
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}