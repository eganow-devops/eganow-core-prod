resource "kubernetes_deployment_v1" "eganow_eu_card" {
  metadata {
    name      = "eganow-eu-card-api"
    namespace = var.pay_core_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-eu-card-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-eu-card-api"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/eganow-eu-core-card-api:latest"
          name              = "eganow-eu-card-api"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "grpc"
            protocol       = "TCP"
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

resource "kubernetes_deployment_v1" "eganow_eu_card_gateway" {
  metadata {
    name      = "eganow-eu-card-gateway-api"
    namespace = var.pay_core_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-eu-card-gateway-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-eu-card-gateway-api"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/eganow-eu-card-gateway-api:latest"
          name              = "eganow-eu-card-gateway-api"
          image_pull_policy = "Always"

          port {
            container_port = 8080
            name           = "http"
            protocol       = "TCP"
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

resource "kubernetes_deployment_v1" "eganow_eu_card_for_developers" {
  metadata {
    name      = "eganow-eu-card-developer-api"
    namespace = var.pay_core_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-eu-card-developer-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-eu-card-developer-api"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/eganow-eu-developer-api:latest"
          name              = "eganow-eu-card-gateway-api"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "http"
            protocol       = "TCP"
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

resource "kubernetes_deployment_v1" "eganow_eu_card_ws" {
  metadata {
    name      = "eganow-eu-card-worker-service"
    namespace = var.pay_core_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-eu-card-worker-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-eu-card-worker-service"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/eganow-eu-gateway-worker-service-api:latest"
          name              = "eganow-eu-card-worker-service"
          image_pull_policy = "Always"
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
