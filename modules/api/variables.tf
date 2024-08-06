#################################################
# CLUSTER
#################################################
variable "k8s_cluster_host" {
  description = "The host of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_ca_cert" {
  description = "The CA certificate of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_token" {
  description = "The token of the Kubernetes cluster"
  type        = string
}

variable "cluster_issuer_email" {
  description = "The email of the cluster issuer"
  type        = string
}

variable "cluster_issuer_name" {
  description = "The name of the cluster issuer"
  type        = string
  default     = "eganow-cert-manager"
}

variable "cluster_issuer_private_key_secret_name" {
  description = "The name of the secret that contains the private key of the cluster issuer"
  type        = string
  default     = "cert-manager-private-key"
}

#################################################
# CLOUD PROVIDER (DIGITALOCEAN)
#################################################
variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

#################################################
# DOMAIN
#################################################
variable "domain_name" {
  description = "The domain name to use for the ingress"
  type        = string
}

#################################################
# PROJECT RESOURCES (SECRETS, NAMESPACES ETC)
#################################################
variable "pay_core_namespace" {
  description = "The namespace of the project"
  type        = string
  default     = "ns-eganow-pay-core"
}

variable "ingress_namespace" {
  description = "The namespace of the ingress"
  type        = string
  default     = "ns-cores-ingress"
}

variable "eganow_key_vault_name" {
  description = "The name of the secret that contains the key vault"
  type        = string
  default     = "eganow-key-vault"
}

variable "onepassword_credentials_json" {
  description = "The name of the secret that contains the 1password credentials"
  type = object({
    verifier = object({
      salt      = string
      localHash = string
    })
    encCredentials = object({
      kid  = string
      enc  = string
      cty  = string
      iv   = string
      data = string
    })
    version    = string
    deviceUuid = string
    uniqueKey = object({
      alg = string
      ext = bool
      k   = string
      key_ops = list(string)
      kty = string
      kid = string
    })
  })
}

variable "dockerconfigjson" {
  description = "Docker config JSON needed to set up image pull credentials"
  type = object({
    auths = map(object({
      username = string
      password = string
      email    = string
      auth     = string
    }))
  })
  sensitive = true
}

variable "ingress_tls_secret_name" {
  description = "The name of the secret that contains the TLS certificate"
  type        = string
  default     = "http-ingress-tls"
}