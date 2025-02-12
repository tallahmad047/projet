
variable "ssh_key" {}
variable "ssh_user" {}
variable "ssh_host" {}
resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -qq >/dev/null",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo chmod 755 get-docker.sh",
      "sudo ./get-docker.sh >/dev/null"
    ]
  }
  provisioner "file" {
    source      = "startup-options.conf"
    destination = "/tmp/startup-options.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/systemd/system/docker.service.d/",
      "sudo cp /tmp/startup-options.conf /etc/systemd/system/docker.service.d/startup_options.conf",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart docker",
      "sudo usermod -aG docker tall"
    ]
  }
}
output "host" {
  value = var.ssh_host
  
}
output "user" {
  value = var.ssh_user
  
}
