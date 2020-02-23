output "kubernet_host" {
  value = digitalocean_kubernetes_cluster.sample-cluster.endpoint
}
output "kubernet_token"{
  value = digitalocean_kubernetes_cluster.sample-cluster.kube_config[0].token
}
output "kubernet_certificate"{
  value=base64decode(digitalocean_kubernetes_cluster.sample-cluster.kube_config[0].cluster_ca_certificate)
}