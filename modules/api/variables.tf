variable "k8s_cluster_host" {
  description = "The host of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_ca_cert" {
  description = "The CA certificate of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_token" {
  description = "The token of the Kubernetes cluster"
  type        = string
}