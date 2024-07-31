variable "do_dns_token_name" {
  description = "The name of the secret that contains the token"
  type        = string
  default     = "digitalocean-dns"
}

variable "do_token" {
  description = "The DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "project_namespace" {
  description = "The namespace where the secret will be created"
  type        = string
}