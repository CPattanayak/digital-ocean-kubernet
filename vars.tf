variable "do_token" {
  default=""
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
  default="NodePort"
}