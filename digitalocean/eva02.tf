resource "digitalocean_droplet" "eva02" {
  image              = "ubuntu-20-04-x64"
  name               = "eva02"
  region             = "nyc3"
  size               = "s-1vcpu-1gb"
  tags               = ["terraform"]
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
}
