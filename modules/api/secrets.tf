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
    name      = "onepassword-connect"
    namespace = var.pay_core_namespace
  }

  data = {
    "1password-credentials.json" : jsonencode(var.onepassword_credentials_json)
  }
}

#  secret for dockerconfigjson
resource "kubernetes_secret_v1" "dockerconfigjson" {
  metadata {
    name      = "dockerconfigjson"
    namespace = var.pay_core_namespace
  }

  data = {
    ".dockerconfigjson" = jsonencode(var.dockerconfigjson)
  }
}