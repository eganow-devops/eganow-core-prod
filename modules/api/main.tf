terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
  }
}

provider "kubernetes" {
  host                   = var.k8s_cluster_host
  client_certificate     = var.k8s_cluster_client_cert
  client_key             = var.k8s_cluster_client_key
  cluster_ca_certificate = var.k8s_cluster_ca_cert
}

module "deployments" {
  source = "./deployment"
  providers = {
    kubernetes = kubernetes
  }
}