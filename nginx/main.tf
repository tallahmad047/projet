variable "ssh_key" {}
variable "ssh_user" {}
variable "ssh_host" {}

resource "null_resource" "ssh_ubuntu"{
 connection {
   type  ="ssh"
   user =var.ssh_user
   host =var.ssh_host
   private_key =file(var.ssh_key)
  
}
provisioner "remote-exec" {
 inline = [
    "sudo apt-get update -qq >/dev/null",
   
   "sudo apt-get install -qq -y nginx >/dev/null"
   ]

}
}
