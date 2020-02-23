variable "do_token" {
 
}
variable "region" {
  default="blr1"
}
variable "cluster_name" {
  default="sample-cluster"
}
variable "kubeversion" {
 default="1.16.6-do.0"
}
variable "kubesize" {
  default="s-6vcpu-16gb"
}

variable "jenkinversion" {
  default="latest"
}
variable "jenkinservice" {
  default="ClusterIP"
}
variable "node_pool_name"{
 default="autoscale-worker-pool"
}
variable "min_node"{
  default=1
}
variable "max_nodes"{
default=5
}
variable "ingress_enable"{
default=true
}
variable "host_name"{
default="build.pattacpro.co.in"
}