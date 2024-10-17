resource "digitalocean_domain" "core" {
  name = var.domain_name
}

resource "digitalocean_record" "onepassword_vault" {
  domain = digitalocean_domain.core.id
  name   = "vault"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "eganow_eu_card_gateway" {
  domain = digitalocean_domain.core.id
  name   = "eucardgateway"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "eganow_eu_card" {
  domain = digitalocean_domain.core.id
  name   = "eucard"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "eganow_eu_card_for_developers" {
  domain = digitalocean_domain.core.id
  name   = "eucarddevelopers"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "egapay_payout" {
  domain = digitalocean_domain.core.id
  name   = "payout"
  type   = "A"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}