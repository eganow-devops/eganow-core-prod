resource "digitalocean_vpc" "egapay_vpc" {
  name     = "${var.cluster_egapay_name}-vpc"
  region   = var.cluster_region
  ip_range = var.cluster_egapay_vpc_ip_range
}