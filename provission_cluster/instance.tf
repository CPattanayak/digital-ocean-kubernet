resource "digitalocean_kubernetes_cluster" "sample-cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.kubeversion

  node_pool {
    name       = var.node_pool_name
    size       = var.kubesize
    auto_scale = true
    min_nodes  = var.min_node
    max_nodes  = var.max_nodes
  }
}

provider "kubernetes" {
  load_config_file = false
  host  = digitalocean_kubernetes_cluster.sample-cluster.endpoint
  token = digitalocean_kubernetes_cluster.sample-cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.sample-cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
  host  = digitalocean_kubernetes_cluster.sample-cluster.endpoint
  token = digitalocean_kubernetes_cluster.sample-cluster.kube_config[0].token
  insecure = true
 }
}
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
resource "helm_release" "jenkins" {
  name  = "jenkins"
  chart = "stable/jenkins"

  set {
    name  = "master.tag"
    value = var.jenkinversion
  }

  set {
    name  = "master.serviceType"
    value = var.jenkinservice
  }
  set {
    name  = "master.csrf.defaultCrumbIssuer.enabled"
    value = "false"
  }
  set {
    name ="master.ingress.enabled"
	value=var.ingress_enable
  }
  set{
    name="master.ingress.hostName"
	value=var.host_name
  }
 
}

resource "helm_release" "nginx-ingress" {
  name  = "nginx-ingress"
  chart = "stable/nginx-ingress"

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

 
}




