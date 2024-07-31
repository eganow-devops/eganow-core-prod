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
  token                  = var.k8s_cluster_token
  cluster_ca_certificate = var.k8s_cluster_ca_cert
}

module "deployments" {
  source            = "./deployment"
  project_namespace = module.namespace.eganow_core_namespace
  providers = {
    kubernetes = kubernetes
  }
}

module "namespace" {
  source = "./namespace"
  providers = {
    kubernetes = kubernetes
  }
}