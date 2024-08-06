terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.39.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host                   = var.k8s_cluster_host
  token                  = var.k8s_cluster_token
  cluster_ca_certificate = var.k8s_cluster_ca_cert
}

provider "kubectl" {
  host                   = var.k8s_cluster_host
  token                  = var.k8s_cluster_token
  cluster_ca_certificate = var.k8s_cluster_ca_cert
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_cluster_host
    token                  = var.k8s_cluster_token
    cluster_ca_certificate = var.k8s_cluster_ca_cert
  }
}

module "cert-manager" {
  source  = "terraform-iaac/cert-manager/kubernetes"
  version = "2.6.3"

  cluster_issuer_email                   = var.cluster_issuer_email
  cluster_issuer_name                    = var.cluster_issuer_name
  cluster_issuer_private_key_secret_name = var.cluster_issuer_private_key_secret_name

  solvers = [
    {
      dns01 = {
        digitalocean = {
          tokenSecretRef = {
            name = kubernetes_secret_v1.digitalocean_dns_token.metadata.0.name
            key  = "token"
          }
        }
      }
    }
  ]

  providers = {
    kubectl = kubectl
    helm    = helm
  }
}