resource "helm_release" "nginx_ing" {
  chart      = "ingress-nginx"
  name       = "core-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = var.nginx_ingress_version
  namespace  = var.ingress_namespace

  create_namespace = true
  cleanup_on_fail  = true
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}

data "kubernetes_service_v1" "ingress_lb" {
  metadata {
    name      = "${helm_release.nginx_ing.name}-${helm_release.nginx_ing.chart}-controller"
    namespace = var.ingress_namespace
  }
}

####################################
# gRPC INGRESS                     #
####################################
resource "kubernetes_ingress_v1" "grpc_ing" {
  metadata {
    name      = "grpc-ingress"
    namespace = var.pay_core_namespace

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "cert-manager.io/cluster-issuer"                 = var.cluster_issuer_name
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "GRPC"
    }
  }

  spec {
    tls {
      hosts = ["*.${var.domain_name}"]
      secret_name = var.grpc_ingress_tls_secret_name
    }

    rule {
      host = "${digitalocean_record.eganow_eu_card.name}.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.eganow_eu_card.metadata.0.name
              port {
                name = kubernetes_service_v1.eganow_eu_card.spec.0.port.0.name
              }
            }
          }
        }
      }
    }
  }
}

####################################
# HTTP INGRESS                     #
####################################
resource "kubernetes_ingress_v1" "http_ing" {
  metadata {
    name      = "http-ingress"
    namespace = var.pay_core_namespace

    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect"       = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
      "cert-manager.io/cluster-issuer"                 = var.cluster_issuer_name
      "kubernetes.io/ingress.class"                    = "nginx"
      "nginx.ingress.kubernetes.io/enable-cors"        = "true"
    }
  }

  spec {
    tls {
      hosts = ["*.${var.domain_name}"]
      secret_name = var.http_ingress_tls_secret_name
    }

    rule {
      host = "${digitalocean_record.eganow_eu_card_gateway.name}.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.eganow_eu_card_gateway.metadata.0.name
              port {
                name = kubernetes_service_v1.eganow_eu_card_gateway.spec.0.port.0.name
              }
            }
          }
        }
      }
    }

    rule {
      host = "${digitalocean_record.eganow_eu_card_for_developers.name}.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.eganow_eu_card_for_developers.metadata.0.name
              port {
                name = kubernetes_service_v1.eganow_eu_card_for_developers.spec.0.port.0.name
              }
            }
          }
        }
      }
    }

    # rule {
    #   host = "${digitalocean_record.onepassword_vault.name}.${var.domain_name}"
    #   http {
    #     path {
    #       path      = "/"
    #       path_type = "Prefix"
    #       backend {
    #         service {
    #           name = data.kubernetes_service_v1.onepassword.metadata.0.name
    #           port {
    #             number = var.insecure_port
    #           }
    #         }
    #       }
    #     }
    #   }
    # }
  }
}