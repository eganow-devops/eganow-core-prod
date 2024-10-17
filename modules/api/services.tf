resource "kubernetes_service_v1" "eganow_eu_card" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_eu_card.metadata.0.name}-svc"
    namespace = var.pay_core_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_eu_card.spec.0.selector.0.match_labels.app
    }
    port {
      port        = kubernetes_deployment_v1.eganow_eu_card.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.eganow_eu_card.spec.0.template.0.spec.0.container.0.port.0.container_port
      name        = "grpc"
    }
  }
}

resource "kubernetes_service_v1" "eganow_eu_card_gateway" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_eu_card_gateway.metadata.0.name}-svc"
    namespace = var.pay_core_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_eu_card_gateway.spec.0.selector.0.match_labels.app
    }
    port {
      port        = kubernetes_deployment_v1.eganow_eu_card_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.eganow_eu_card_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
      name        = "http"
    }
  }
}

resource "kubernetes_service_v1" "eganow_eu_card_for_developers" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_eu_card_for_developers.metadata.0.name}-svc"
    namespace = var.pay_core_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_eu_card_for_developers.spec.0.selector.0.match_labels.app
    }
    port {
      port        = kubernetes_deployment_v1.eganow_eu_card_for_developers.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.eganow_eu_card_for_developers.spec.0.template.0.spec.0.container.0.port.0.container_port
      name        = "http"
    }
  }
}