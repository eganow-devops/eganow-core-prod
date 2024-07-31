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

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}