resource "digitalocean_firewall" "egapay_core_firewall" {
  name        = "${var.cluster_egapay_name}-firewall"
  droplet_ids = [
    for droplet in digitalocean_kubernetes_cluster.egapay_cluster.node_pool.0.nodes : droplet.droplet_id
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = 22
    source_addresses = var.eganow_inbound_source_address
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = 443
    source_addresses = var.eganow_inbound_source_address
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = 443
    destination_addresses = var.eganow_outbound_destination_address
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = 25
    destination_addresses = var.eganow_outbound_destination_address
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = 587
    destination_addresses = var.eganow_outbound_destination_address
  }
}