variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "cluster_issuer_email" {
  description = "The email of the cluster issuer"
  type        = string
}