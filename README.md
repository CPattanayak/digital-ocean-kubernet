# digital-ocean-kubernet
This project provision a kubernet cluster on digital ocean with jenkin server and ngnx loadbalancer
 1.to provision cluster terraform apply -auto-approve -var do_token=<token>
 2.to destroy cluster terraform destroy -auto-approve -var do_token=<token>
 
To provsion a domain use below script

provider "digitalocean" {
  token = <token>
}


resource "digitalocean_domain" "default" {
  name = "pattacpro.co.in"
}


resource "digitalocean_record" "build" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "build"
  value  = "<loadbalancerip>"
}


output "fqdn" {
  value = digitalocean_record.build.fqdn
}