variable "k8s_cluster_host" {
  description = "The host of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_ca_cert" {
  description = "The CA certificate of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_client_key" {
  description = "The client key of the Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_client_cert" {
  description = "The client certificate of the Kubernetes cluster"
  type        = string
}