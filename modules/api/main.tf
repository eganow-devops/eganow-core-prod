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
  }
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

module "namespace" {
  source = "./namespace"
  providers = {
    kubernetes = kubernetes
  }
}

module "deployments" {
  source            = "./deployment"
  project_namespace = module.namespace.eganow_core_namespace
  providers = {
    kubernetes = kubernetes
  }
}

module "secrets" {
  source            = "./secret"
  project_namespace = module.namespace.eganow_core_namespace
  do_token          = var.do_token
  providers = {
    kubernetes = kubernetes
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
            name = module.secrets.do_token_secret_name
            key  = module.secrets.do_token_secret_string_data_key
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