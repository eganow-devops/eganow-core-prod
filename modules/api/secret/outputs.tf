output "do_token_secret_name" {
  value = kubernetes_secret_v1.digitalocean_dns_token.metadata.0.name
}

output "do_token_secret_string_data_key" {
  value = "token"
}