resource "digitalocean_ssh_key" "default" {
  name       = "mykey"
  public_key = file("./mykey.pub")
}

resource "digitalocean_droplet" "replicaset" {
  count              = 1
  name               = "mongo${count.index}"
  image              = "ubuntu-18-04-x64"
  region             = "blr1"
  size               = "s-2vcpu-2gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  private_networking = true
  

  provisioner "file" {
	  connection {
	    host = self.ipv4_address
		type = "ssh"
		user = "root"
		agent = true
		private_key = file("./mykey")
	}
   
    destination = "/etc/mongod.conf"
    content  = "${templatefile("${path.module}/templates/config.tmpl", {})}"
  }
 provisioner "file" {
	  connection {
	    host = self.ipv4_address
		type = "ssh"
		user = "root"
		agent = true
		private_key = file("./mykey")
	}
   
    destination = "/var/admin.js"
    content  = "${templatefile("${path.module}/templates/admin.tmpl", {pass=var.pass})}"
  }

  provisioner "remote-exec" {
     connection {
	    host = self.ipv4_address
		type = "ssh"
		user = "root"
		agent = true
		private_key = file("./mykey")
	}
    
    inline = [
      "wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -",
      "echo 'deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list",
      "apt-get update",
      "apt-get install -y -o Dpkg::Options::=--force-confdef mongodb-org",
	  "ufw allow 27017",
      "service mongod start",
	  
    ]
  }
}