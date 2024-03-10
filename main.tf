#
#variable "str" {
#  type    = string

#  default = "127.0.0.1 gitlab.test"
#}

#resource "null_resource" "node1" {
#  provisioner "local-exec" {
#    command = "echo '${var.str}' > host.txt"
#  }
#}

#output "str_output" {
#  value = var.str

#variable "hosts" {
#  default = {
#  "127.0.0.2" ="localhost gitlab.local gitlab.me gitlab.tall"
#  "192.169.1.168" ="gitlab.test"
#  "192.169.1.170" ="prometheus.test"}

   
#}

#resource "null_resource" "hosts" {
#for_each=var.hosts
#triggers={foo=each.value
#}
#provisioner "local-exec" {
#    command = "echo '${each.key} ${each.value}'>> host.txt"
#  }
#}

#variable "hosts" {
  
#  default =[ "127.0.0.1 localhost","192.168.1.133 gitlab.test" ]
#}

#resource "null_resource" "hosts" {
# count="${length(var.hosts)}"
#  provisioner "local-exec" {
#    command = "echo '${element(var.hosts, count.index)}' > host.txt"
#  }
#}
#
variable "host"{}
resource "null_resource" "ssh_target"{
 connection {
   type  ="ssh"
   user =var.ssh_user
   host =var.shh_host
   private_key =file("/root/.ssh/id_rsa")
  
}
provisioner "remote-exec"{
 inline = [
   "sudo apt update -qq  >/dev/null",
   "sudo apt install -qq nginx >/dev/null"
   ]
}
}

