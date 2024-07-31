terraform {
  cloud {
    organization = "eganow-devops-org"
    workspaces {
      name = "eganow-core-prod-ws"
    }
  }
}

module "cluster" {
  source   = "./modules/cluster"
  do_token = var.do_token
}

module "api" {
  source              = "./modules/api"
  k8s_cluster_ca_cert = module.cluster.egapay_cluster_kubeconfig_ca_cert
  k8s_cluster_token   = module.cluster.egapay_cluster_kubeconfig_token
  k8s_cluster_host    = module.cluster.egapay_cluster_kubeconfig_host

  do_token             = var.do_token
  cluster_issuer_email = var.cluster_issuer_email
}