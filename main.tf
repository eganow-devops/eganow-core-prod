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
  source                  = "./modules/api"
  k8s_cluster_ca_cert     = module.cluster.egapay_cluster_kubeconfig_ca_cert
  k8s_cluster_client_cert = module.cluster.egapay_cluster_kubeconfig_client_cert
  k8s_cluster_client_key  = module.cluster.egapay_cluster_kubeconfig_client_key
  k8s_cluster_host        = module.cluster.egapay_cluster_kubeconfig_host
}