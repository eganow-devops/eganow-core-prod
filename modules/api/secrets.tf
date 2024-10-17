resource "kubernetes_secret_v1" "digitalocean_dns_token" {
  metadata {
    name      = "digitalocean-dns"
    namespace = module.cert-manager.namespace
  }

  data = {
    token = var.do_token
  }
}

# secret for 1password key vault
resource "kubernetes_secret_v1" "onepassword_connect" {
  metadata {
    name      = "onepassword-connect-vault"
    namespace = var.pay_core_namespace
  }

  data = {
    token = var.onepassword_token
  }
}

#  secret for dockerconfigjson
resource "kubernetes_secret_v1" "docker_regcred" {
  metadata {
    name      = "dockerconfigjson"
    namespace = var.pay_core_namespace
  }

  data = {
    ".dockerconfigjson" = jsonencode(var.dockerconfigjson)
  }
}