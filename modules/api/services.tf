resource "kubernetes_service_v1" "payment_gateway" {
  metadata {
    name      = "${kubernetes_deployment_v1.payment_gateway.metadata.0.name}-svc"
    namespace = var.pay_core_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.payment_gateway.spec.0.selector.0.match_labels.app
    }

    port {
      name        = "grpc"
      port        = kubernetes_deployment_v1.payment_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.payment_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
    }
  }
}