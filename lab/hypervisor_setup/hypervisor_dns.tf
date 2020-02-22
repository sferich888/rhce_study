variable "config_name" {
  type = string
  description = "NetworkManager dnsmasq configuration file name."
  default = "rhce_study_lab.conf"
}

variable "domain_name" {
  type = string
  description = "Network domain name for guests attached to the network."
  default = "rhce.lab"
}

variable "network_gateway" {
  type = string
  description = "Network gateway."
  default = "192.168.100.1"
}

variable "ansible_become_password" {
  type = string
  description = "Ansible become (sudo) password for the hypervisor."
}

# We'll use ansible to execute the key configuration items, as ansible is better at configuration management. 
resource "null_resource" "local_networkmanager_config" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/NetworkManager/NetworkManager.conf section=main option=dns value=dnsmasq' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_NM_dnsmasq_config" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m lineinfile -a 'path=/etc/NetworkManager/dnsmasq.d/${var.config_name} create=yes line=server=/${var.domain_name}/${var.network_gateway}' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_NM_restart" {
  provisioner "local-exec" {
    command = "systemctl restart NetworkManager"
  }
  depends_on = [
    null_resource.local_networkmanager_config,
    null_resource.local_NM_dnsmasq_config,
  ]
}
