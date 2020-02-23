resource "digitalocean_domain" "default" {
  name = var.domain_name
}


resource "digitalocean_record" "build" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "build"
  value  = var.loadbalancer_ip
}