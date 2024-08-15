resource "digitalocean_domain" "core" {
  name = var.domain_name
}

resource "digitalocean_record" "onepassword_vault" {
  domain = digitalocean_domain.core.id
  name   = "pay"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}